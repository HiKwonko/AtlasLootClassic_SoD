local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local Favourites = Addons:RegisterNewAddon("Favourites")

-- lua
local type = _G.type
local next = _G.next
local format, strsub = _G.format, _G.strsub

-- WoW
local GetItemInfo = _G.GetItemInfo
local GetServerTime = _G.GetServerTime

-- locals
local ICONS_PATH = ALPrivate.ICONS_PATH
local BASE_NAME_P, BASE_NAME_G, LIST_BASE_NAME = "ProfileBase", "GlobalBase", "List"
local NEW_LIST_ID_PATTERN = "%s%s"
local ATLAS_ICON_IDENTIFIER = "#"
local STD_ICON, STD_ICON2

Favourites.BASE_NAME_P, Favourites.BASE_NAME_G = BASE_NAME_P, BASE_NAME_G


-- Addon
Favourites.DbDefaults = {
    enabled = true,
    activeList = { BASE_NAME_P, false }, -- name, isGlobal
    activeSubLists = {},
    lists = {
        [BASE_NAME_P] = {
            __name = AL["Profile base list"],
        },
    }
}

Favourites.GlobalDbDefaults = {
    activeSubLists = {},
    lists = {
        [BASE_NAME_G] = {
            __name = AL["Global base list"],
        },
    },
}

Favourites.PlaceHolderIcon = ICONS_PATH.."placeholder-icon"
Favourites.IconList = {
    ICONS_PATH.."VignetteKill",
    ICONS_PATH.."Gear",
    ICONS_PATH.."groupfinder-icon-class-druid",
    ICONS_PATH.."groupfinder-icon-class-hunter",
    ICONS_PATH.."groupfinder-icon-class-mage",
    ICONS_PATH.."groupfinder-icon-class-paladin",
    ICONS_PATH.."groupfinder-icon-class-priest",
    ICONS_PATH.."groupfinder-icon-class-rogue",
    ICONS_PATH.."groupfinder-icon-class-shaman",
    ICONS_PATH.."groupfinder-icon-class-warlock",
    ICONS_PATH.."groupfinder-icon-class-warrior",
    ICONS_PATH.."groupfinder-icon-role-large-dps",
    ICONS_PATH.."groupfinder-icon-role-large-heal",
    ICONS_PATH.."groupfinder-icon-role-large-tank",
    ICONS_PATH.."Vehicle-HammerGold",
    ICONS_PATH.."Vehicle-HammerGold-1",
    ICONS_PATH.."Vehicle-HammerGold-2",
    ICONS_PATH.."Vehicle-HammerGold-3",
    ICONS_PATH.."Vehicle-TempleofKotmogu-CyanBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-GreenBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-OrangeBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-PurpleBall",
    ICONS_PATH.."worldquest-tracker-questmarker",
}

local function AddItemsInfoFavouritesSub(items, activeSub, isGlobal)
    if items and activeSub then
        local fav = Favourites.subItems
        for itemID in next, items do
            fav[itemID] = { activeSub, isGlobal }
        end
    end
end

local function CheckSubSetDb(list, db, globalDb)
    if list then
        for activeSub, isGlobal in next, list do
            if isGlobal and globalDb[activeSub] then
                AddItemsInfoFavouritesSub(globalDb[activeSub] or db[activeSub], activeSub, isGlobal)
            elseif not isGlobal and db[activeSub] then
                AddItemsInfoFavouritesSub(db[activeSub], activeSub, isGlobal)
            end
        end
    end
end

local function PopulateSubLists(db, globalDb)
    local subDb, globalSubDb = db.activeSubLists, globalDb.activeSubLists
    db, globalDb = db.lists, globalDb.lists

    CheckSubSetDb(subDb, db, globalDb)
    CheckSubSetDb(globalSubDb, db, globalDb)
end

local function GetActiveList(self)
    local name, isGlobal = self.db.activeList[1], ( self.db.activeList[2] == true )
    local db = isGlobal and self:GetGlobaleLists() or self:GetProfileLists()
    if db[name] then
        return db[name]
    else
        self.db.activeList[1] = db[BASE_NAME_P]
        return db[BASE_NAME_P]
    end
end

local function CleanUpShownLists(db, globalDb, activeSubLists, isGlobalList)
    local new = {}

    for listID, isGlobal in next, activeSubLists do
        if ( isGlobal and globalDb[listID] ) then
            new[listID] = isGlobal
        elseif not isGlobal and not isGlobalList and db[listID] then
            new[listID] = isGlobal
        end
    end

    return new
end

function Favourites:UpdateDb()
    self.db = self:GetDb()
    self.globalDb = self:GetGlobalDb()
    self.activeList = GetActiveList(self)

    -- populate sublists
    Favourites.subItems = {}
    PopulateSubLists(self.db, self.globalDb)
end

function Favourites.OnInitialize()
    Favourites:UpdateDb()
    STD_ICON, STD_ICON2 = Favourites.IconList[1], Favourites.IconList[2]
end

function Favourites:OnProfileChanged()
    self:UpdateDb()
end

function Favourites:OnStatusChanged()
    self:UpdateDb()
end

function Favourites:AddItemID(itemID)
    if itemID and GetItemInfo(itemID) and not self.activeList[itemID] then
        self.activeList[itemID] = true
        return true
    end
    return false
end

function Favourites:RemoveItemID(itemID)
    if itemID and self.activeList[itemID] then
        self.activeList[itemID] = nil
        return true
    end
    return false
end

function Favourites:IsFavouriteItemID(itemID, onlyActiveList)
    if onlyActiveList then
        return self.activeList[itemID]
    else
        return self.activeList[itemID] or self.subItems[itemID]
    end
end

function Favourites:SetFavouriteIcon(itemID, texture, hideOnFail)
    local listName = self:IsFavouriteItemID(itemID)
    if not listName then return hideOnFail and texture:Hide() or nil end
    local icon

    if listName == true then
        icon = self.activeList.__icon or STD_ICON
    elseif listName[2] == true then
        icon = self.globalDb.lists[listName[1]].IconList or STD_ICON2
    elseif listName[2] == false then
        icon = self.db.lists[listName[1]].__icon or STD_ICON2
    elseif listName[2] then
        icon = listName[2]
    end

    if icon then
        local iconType = type(icon)
        if iconType == "number" then
            texture:SetTexture(icon)
        elseif iconType == "string" then
            if strsub(icon, 1, 1) == ATLAS_ICON_IDENTIFIER then
                if icon and icon ~= texture:GetAtlas() then
                    texture:SetAtlas(strsub(icon, 2))
                end
            else
                texture:SetTexture(icon)
            end
        end
    end
end

function Favourites:GetProfileLists()
    return self.db.lists
end

function Favourites:GetGlobaleLists()
    return self.globalDb.lists
end

function Favourites:GetListName(id, isGlobal)
    if isGlobal and self:GetGlobaleLists()[id] then
        return self:GetGlobaleLists()[id].__name or LIST_BASE_NAME
    elseif not isGlobal and self:GetProfileLists()[id] then
        return self:GetProfileLists()[id].__name or LIST_BASE_NAME
    end
    return id
end

function Favourites:ListIsGlobalActive(listID)
    return ( self.globalDb.activeSubLists[listID] or self.globalDb.activeSubLists[listID] == false ) and true or false
end

function Favourites:ListIsProfileActive(listID)
    return ( self.db.activeSubLists[listID] or self.db.activeSubLists[listID] == false ) and true or false
end

function Favourites:CleanUpShownLists()
    local db, globalDb = self.db, self.globalDb

    local newDbActive, newGlobalActive = {}, {}

    self.db.activeSubLists = CleanUpShownLists(self.db, self.globalDb, self.db.activeSubLists)
    self.globalDb.activeSubLists = CleanUpShownLists(self.db, self.globalDb, self.globalDb.activeSubLists, true)
end

function Favourites:AddIntoShownList(listID, isGlobalList, globalShown)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if not listID or not list[listID] then return end
    local activeSubLists = ( isGlobalList and globalShown ) and self.globalDb.activeSubLists or self.db.activeSubLists

    activeSubLists[listID] = isGlobalList
end

function Favourites:RemoveFromShownList(listID, isGlobalList, globalShown)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    local activeSubLists = ( isGlobalList and globalShown ) and self.globalDb.activeSubLists or self.db.activeSubLists

    activeSubLists[listID] = nil
end

function Favourites:SetIcon(icon)
    self.activeList.__icon = ( icon ~= STD_ICON and icon ~= STD_ICON2 ) and icon or nil
end

function Favourites:GetIcon()
    return self.activeList.__icon
end

function Favourites:HasIcon()
    return self.activeList.__icon and true or false
end

function Favourites:GetName()
    return self.activeList.__name or LIST_BASE_NAME
end

function Favourites:SetName(name)
    self.activeList.__name = name
end

function Favourites:AddNewList(isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    local id = format(NEW_LIST_ID_PATTERN, isGlobalList and "g" or "p", GetServerTime())

    if not list[id] then    -- should work as spam protect as GetServerTime returns sec
        list[id] = {}
        return id
    end
    return false
end

function Favourites:RemoveList(id, isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if list[id] then
        list[id] = nil
        self:CleanUpShownLists()
        return true
    end
    return false
end

Favourites:Finalize()