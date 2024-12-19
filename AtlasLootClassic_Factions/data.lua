-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, 1)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local ALLIANCE_DIFF
local HORDE_DIFF
local LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local FACTIONS3_CONTENT = data:AddContentType(AL["SoD Factions"], ATLASLOOT_RAID20_COLOR)
local FACTIONS_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)
local FACTIONS2_CONTENT = data:AddContentType(AL["Secondary factions"], {0.1, 0.3, 0.1, 1})

local FACTIONS_HORDE_CONTENT, FACTIONS_ALLI_CONTENT
if UnitFactionGroup("player") == "Horde" then
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
else
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
end

--[[
0 - Unknown
1 - Hated
2 - Hostile
3 - Unfriendly
4 - Neutral
5 - Friendly
6 - Honored
7 - Revered
8 - Exalted
]]--

local AD_INSIGNIA_FORMAT_BLUE, AD_INSIGNIA_FORMAT_EPIC = "|cff0070dd%d|r",  "|cffa335ee%d|r" -- format(AD_INSIGNIA_FORMAT, 30)

data["Emerald Wardens"] = {
	FactionID = 2641,
	ContentType = FACTIONS3_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep8" },
				{ 2, 221442 }, -- Roar of the Guardian
				{ 3, 220621 }, -- Nightmare Resonance Crystal
				{ 4, 221440 }, -- Roar of the Dream
				{ 5, 221443 }, -- Roar of the Grove
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep7" },
				{ 2, 221441 }, -- Warden of the Dream
				{ 3, 220649 }, -- Merithra's Inheritence
				{ 4, 221439 }, -- Armor of the Emerald Slumber
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep6" },
				{ 2, 221391 }, --Emerald Scalemail Helmet
				{ 3, 221390 }, --Emerald Scalemail Breastplate
				{ 4, 221388 }, --Emerald Scalemail Leggings
				{ 5, 221402 }, --Emerald Chain Helmet
				{ 6, 221404 }, --Emerald Chain Breastplate
				{ 7, 221401 }, --Emerald Chain Leggings
				{ 8, 221397 }, --Emerald Laden Helmet
				{ 9, 221395 }, --Emerald Laden Breastplate
				{ 10, 221398 }, --Emerald Laden Leggings
				{ 12, 213407 }, -- Catnip
				{ 13, 221193 }, --Emerald Ring
				{ 14, 224006 }, --Emerald Ring
				{ 16, 221376 }, --Emerald Dream Helm
				{ 17, 221380 }, --Emerald Dream Breastplate
				{ 18, 221377 }, --Emerald Dream Legplates
				{ 19, 221384 }, --Emerald Encrusted Helmet
				{ 20, 221382 }, --Emerald Encrusted Battleplate
				{ 21, 221385 }, --Emerald Encrusted Legplates
				{ 23, 221425 }, --Emerald Enchanted Circlet
				{ 24, 221430 }, --Emerald Enchanted Robes
				{ 25, 221429 }, --Emerald Enchanted Pants
				{ 26, 221437 }, --Emerald Woven Circlet
				{ 27, 221434 }, --Emerald Woven Robes
				{ 28, 221435 }, --Emerald Woven Pants
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 221408 }, --Emerald Leather Helm
				{ 102, 221406 }, --Emerald Leather Vest
				{ 103, 221410 }, --Emerald Leather Pants
				{ 104, 221413 }, --Emerald Dreamkeeper Helm
				{ 105, 221417 }, --Emerald Dreamkeeper Chest
				{ 106, 221414 }, --Emerald Dreamkeeper Pants
				{ 107, 221422 }, --Emerald Watcher Helm
				{ 108, 221419 }, --Emerald Watcher Vest
				{ 109, 221423 }, --Emerald Watcher Leggings
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep5" },
				{ 2, 221392 }, --Emerald Scalemail Shoulders
				{ 3, 221389 }, --Emerald Scalemail Gauntlets
				{ 4, 221393 }, --Emerald Scalemail Boots
				{ 5, 221399 }, --Emerald Laden Shoulders
				{ 6, 221396 }, --Emerald Laden Gauntlets
				{ 7, 221394 }, --Emerald Laden Boots
				{ 8, 221400 }, --Emerald Chain Shoudlers
				{ 9, 221403 }, --Emerald Chain Gauntlets
				{ 10, 221405 }, --Emerald Chain Boots
				{ 12, 221386 }, --Emerald Encrusted Spaulders
				{ 13, 221383 }, --Emerald Encrusted Handguards
				{ 14, 221387 }, --Emerald Encrusted Plate Boots
				{ 16, 221369 }, -- Nightmare Siphon
				{ 17, 221374 }, -- Anguish of the Dream
				{ 18, 221362 }, -- Weapon Cleaning Cloth
				{ 19, 223648 }, -- Dream Imbued Arrow
				{ 20, 224005 }, -- Emerald Ring
				{ 21, 224004 }, -- Emerald Ring
				{ 23, 221381 }, --Emerald Dream Pauldrons
				{ 24, 221378 }, --Emerald Dream Gauntlets
				{ 25, 221379 }, --Emerald Dream Sabatons
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 221431 }, --Emerald Enchanted Shoulders
				{ 102, 221427 }, --Emerald Enchanted Gloves
				{ 103, 221426 }, --Emerald Enchanted Boots
				{ 104, 221432 }, --Emerald Woven Mantle
				{ 105, 221436 }, --Emerald Woven Gloves
				{ 106, 221438 }, --Emerald Woven Boots
				{ 108, 221411 }, --Emerald Leather Shoulders
				{ 109, 221407 }, --Emerald Leather Gloves
				{ 110, 221409 }, --Emerald Leather Sabatons
				{ 111, 221416 }, --Emerald Dreamkeeper Shoulders
				{ 112, 221412 }, --Emerald Dreamkeeper Gloves
				{ 113, 221415 }, --Emerald Dreamkeeper Boots
				{ 116, 221424 }, --Emerald Watcher Shoulders
				{ 117, 221421 }, --Emerald Watcher Gloves
				{ 118, 221420 }, --Emerald Watcher Boots
			},
		},
		{ -- Neutral
			name = ALIL["Neutral"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep4" },
				{ 2, 212568 }, -- Wolfshead Trophy
				{ 3, 223912 }, -- Purification Potion
				{ 4, 223913 }, -- Major Healing Potion
				{ 5, 223914 }, -- Greater Healing Potion
				{ 7, 221480 }, -- Spell Notes: Molten Armor
				{ 8, 221481 }, -- 	Nihilist Epiphany
				{ 9, 221482 }, -- 	Rune of Affliction
				{ 10, 221483 }, -- 	Rune of Burn
				{ 11, 221511 }, -- 	Rune of the Protector
				{ 12, 221512 }, -- 	Rune of Alacrity
				{ 13, 221515 }, -- 	Rune of Detonation
				{ 14, 221517 }, -- 	Rune of Bloodshed
				{ 15, 223288 }, -- 	Rune of the Hammer
			},
		},
	},
}

data["Durotar Supply And Logistics"] = {
	FactionID = 2587,
	ContentType = FACTIONS3_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f2587rep8" },
				{ 2, 223164 }, -- Curiosity Cowl
				{ 3, 223169 }, -- Tenacity Cap
				{ 4, 223172 }, -- Tenacity Chain
				{ 5, 223186 }, -- Supply Expediter
				{ 6, 223162 }, -- Handy Courier Haversack
				{ 7, 220639 }, -- Lledra's Inanimator
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f2587rep7" },
				{ 2, 217399 }, -- Recipe: Lesser Arcane Elixir
				{ 3, 219021 }, -- Hefty Courier Pack
				{ 4, 223161 }, -- Empty Supply Crate
				{ 5, 219135 }, -- Curiosity Pendant
				{ 6, 219136 }, -- Tenacity Pendant
				{ 7, 219137 }, -- Initiative Pendant
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f2587rep6" },
				{ 2, 211384 }, -- Sturdy Courier Bag
				{ 3, 210779 }, -- Plans: Mantle of the Second War
				{ 4, 211247 }, -- Pattern: Phoenix Bindings
				{ 5, 212230 }, -- Schematic: Soul Vessel
				{ 6, 223160 }, -- Bargain Bush
				{ 7, 219022 }, -- Hauler's Ring
				{ 8, 219023 }, -- Clerk's Ring
				{ 9, 219024 }, -- Messenger's Ring
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f2587rep5" },
				{ 2, 211382 }, -- Small Courier Satchel
				{ 3, 212588 }, -- Provisioner's Gloves
				{ 4, 212589 }, -- Courier Treads
				{ 5, 212590 }, -- Hoist Strap
				{ 7, 211386 }, -- Spell Notes: Arcane Surge
				{ 8, 211387 }, -- Rune of Beckoning Light
				{ 9, 211392 }, -- Rune of Everlasting Affliction
				{ 10, 211391 }, -- Rune of Healing Rain
				{ 11, 211385 }, -- Rune of Serpent Spread
				{ 12, 211393 }, -- Rune of Single-Minded Fury
				{ 13, 206992 }, -- Rune of Skull Bash
				{ 14, 211390 }, -- Rune of Teasing
				{ 15, 205950 }, -- Tenebrous Epiphany
			},
		},
	},
}

data["Azeroth"] = {
	FactionID = 2586,
	ContentType = FACTIONS3_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f2586rep8" },
				{ 2, 223164 }, -- Curiosity Cowl
				{ 3, 223169 }, -- Tenacity Cap
				{ 4, 223172 }, -- Tenacity Chain
				{ 5, 223186 }, -- Supply Expediter
				{ 6, 223162 }, -- Handy Courier Haversack
				{ 7, 220639 }, -- Lledra's Inanimator
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f2586rep7" },
				{ 2, 217399 }, -- Recipe: Lesser Arcane Elixir
				{ 3, 219021 }, -- Hefty Courier Pack
				{ 4, 223161 }, -- Empty Supply Crate
				{ 5, 219135 }, -- Curiosity Pendant
				{ 6, 219136 }, -- Tenacity Pendant
				{ 7, 219137 }, -- Initiative Pendant
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f2586rep6" },
				{ 2, 211384 }, -- Sturdy Courier Bag
				{ 3, 210779 }, -- Plans: Mantle of the Second War
				{ 4, 211247 }, -- Pattern: Phoenix Bindings
				{ 5, 212230 }, -- Schematic: Soul Vessel
				{ 6, 223160 }, -- Bargain Bush
				{ 7, 219022 }, -- Hauler's Ring
				{ 8, 219023 }, -- Clerk's Ring
				{ 9, 219024 }, -- Messenger's Ring
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f2586rep5" },
				{ 2, 211382 }, -- Small Courier Satchel
				{ 3, 212588 }, -- Provisioner's Gloves
				{ 4, 212589 }, -- Courier Treads
				{ 5, 212590 }, -- Hoist Strap
				{ 7, 211386 }, -- Spell Notes: Arcane Surge
				{ 8, 211387 }, -- Rune of Beckoning Light
				{ 9, 211392 }, -- Rune of Everlasting Affliction
				{ 10, 211391 }, -- Rune of Healing Rain
				{ 11, 211385 }, -- Rune of Serpent Spread
				{ 12, 211393 }, -- Rune of Single-Minded Fury
				{ 13, 206992 }, -- Rune of Skull Bash
				{ 14, 211390 }, -- Rune of Teasing
				{ 15, 205950 }, -- Tenebrous Epiphany
			},
		},
	},
}

data["ArgentDawn"] = {
	FactionID = 529,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep8" },
				{ 2, 18182 }, -- Chromatic Mantle of the Dawn
				{ 4,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 27), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 27) }, -- Insignia of the Dawn / Crusade
				{ 5,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 6), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 6) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep7" },
				{ 2, 13810 }, -- Blessed Sunfruit
				{ 3, 13813 }, -- Blessed Sunfruit Juice
				{ 5,  19217 }, -- Pattern: Argent Shoulders
				{ 6,  19329 }, -- Pattern: Golden Mantle of the Dawn
				{ 7,  19205 }, -- Plans: Gloves of the Dawn
				{ 8, 12698 }, -- Plans: Dawnbringer Shoulders
				{ 9,  19447 }, -- Formula: Enchant Bracer - Healing
				{ 11,  18171 }, -- Arcane Mantle of the Dawn
				{ 12,  18169 }, -- Flame Mantle of the Dawn
				{ 13,  18170 }, -- Frost Mantle of the Dawn
				{ 14,  18172 }, -- Nature Mantle of the Dawn
				{ 15, 18173 }, -- Shadow Mantle of the Dawn
				{ 16,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 45), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 45) }, -- Insignia of the Dawn / Crusade
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 7), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 7) }, -- Insignia of the Dawn / Crusade
				{ 19, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 20, 227888 }, -- Argent Elite Shoulders
				{ 21, 227818 }, -- Glowing Mantle of the Dawn
				{ 22, 227817 }, -- Radiant Gloves of the Dawn
				{ 23, 227859 }, -- Shimmering Dawnbringer Shoulders
				{ 25, 227819}, -- Blessed Flame Mantle of the Dawn
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep6" },
				{ 2,  19216 }, -- Pattern: Argent Boots
				{ 3,  19328 }, -- Pattern: Dawn Treaders
				{ 4,  19203 }, -- Plans: Girdle of the Dawn
				{ 5,  19442 }, -- Formula: Powerful Anti-Venom
				{ 6,  19446 }, -- Formula: Enchant Bracer - Mana Regeneration
				{ 7, 13482 }, -- Recipe: Transmute Air to Fire
				{ 9,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 75), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 75) }, -- Insignia of the Dawn / Crusade
				{ 10,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 20), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 20) }, -- Insignia of the Dawn / Crusade
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17,  227816 }, -- Argent Elite Boots
				{ 18,  227815 }, -- Fine Dawn Treaders
				{ 19,  227814 }, -- Radiant Girdle of the Dawn
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep5" },
				{ 2,  13724 }, -- Enriched Manna Biscuit
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 110), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 110) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 30), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 30) }, -- Insignia of the Dawn / Crusade
			},
		},
	},
}

data["Timbermaw"] = {
	FactionID = 576,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep8" },
				{ 2, 21326 }, -- Defender of the Timbermaw
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep7" },
				{ 2, 19218 }, -- Pattern: Mantle of the Timbermaw
				{ 3, 19327 }, -- Pattern: Timbermaw Brawlers
				{ 4, 19204 }, -- Plans: Heavy Timbermaw Boots
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, 227808 }, -- Rugged Mantle of the Timbermaw
				{ 18, 227809 }, -- Studded Timbermaw Brawlers
				{ 19, 227810 }, -- Dense Timbermaw Boots
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep6" },
				{ 2,  16768 }, -- Furbolg Medicine Pouch
				{ 3,  16769 }, -- Furbolg Medicine Totem
				{ 4, 19202 }, -- Plans: Heavy Timbermaw Belt
				{ 5, 19326 }, -- Pattern: Might of the Timbermaw
				{ 6, 19215 }, -- Pattern: Wisdom of the Timbermaw
				{ 7, 19445 }, -- Formula: Enchant Weapon - Agility
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, 227807 }, -- Dense Timbermaw Belt
				{ 18, 227805 }, -- Ferocity of the Timbermaw
				{ 19, 228190 }, -- Knowledge of the Timbermaw
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep5" },
				{ 2,  15754 }, -- Pattern: Warbear Woolies
				{ 3,  15742 }, -- Pattern: Warbear Harness
				{ 4,  13484 }, -- Recipe: Transmute Earth to Water
				{ 5,  22392 }, -- Formula: Enchant 2H Weapon - Agility
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17,  227804 }, -- Dire Warbear Woolies
				{ 18,  227803 }, -- Dire Warbear Harness
				{ 20,  227862 }, -- Incandescent Mooncloth Boots
			},
		},
	},
}

data["ThoriumBrotherhood"] = {
	FactionID = 59,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep8" },
				{ 2,  19210 }, -- Plans: Ebon Hand
				{ 3,  19211 }, -- Plans: Blackguard
				{ 4,  19212 }, -- Plans: Nightfall
				{ 5,  20040 }, -- Plans: Dark Iron Boots
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, 227842 }, -- Ebon Fist
				{ 18, 227840 }, -- Implacable Blackguard
				--{ 19, 227843 }, -- Reaving Nightfall (removed?)
				{ 20, 228929 }, -- Tempered Dark Iron Boots
				{ 21, 228924 }, -- Tempered Dark Iron Boots
				{ 22, 228927 }, -- Tempered Dark Iron Boots
				{ 23, 228926 }, -- Tempered Dark Iron Boots
				{ 24, 228925 }, -- Tempered Dark Iron Boots
				{ 25, 228928 }, -- Tempered Dark Iron Boots
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep7" },
				{ 2,  19220 }, -- Pattern: Flarecore Leggings
				{ 3,  19333 }, -- Pattern: Molten Belt
				{ 4,  19332 }, -- Pattern: Corehound Belt
				{ 5,  17053 }, -- Plans: Fiery Chain Shoulders
				{ 6,  19331 }, -- Pattern: Chromatic Gauntlets
				{ 7,  19207 }, -- Plans: Dark Iron Gauntlets
				{ 8,  17052 }, -- Plans: Dark Iron Leggings
				{ 9,  19208 }, -- Plans: Black Amnesty
				{ 10,  19209 }, -- Plans: Blackfury
				{ 11, 19449 }, -- Formula: Enchant Weapon - Mighty Intellect
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, 227839 }, -- Fine Flarecore Leggings
				{ 19, 227837 }, -- Thick Corehound Belt
				{ 20, 227834 }, -- Molten Chain Shoulders
				{ 21, 227838 }, -- Shining Chromatic Gauntlets
				{ 22, 227835 }, -- Tempered Dark Iron Gauntlets
				{ 23, 227836 }, -- Tempered Dark Iron Leggings
				{ 24, 227832 }, -- Tempered Black Amnesty
				{ 25, 227833 }, -- Glaive of Obsidian Fury
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep6" },
				{ 2,  17017 }, -- Pattern: Flarecore Mantle
				{ 3,  19219 }, -- Pattern: Flarecore Robe
				{ 4,  19330 }, -- Pattern: Lava Belt
				{ 5,  17049 }, -- Plans: Fiery Chain Girdle
				{ 6,  17025 }, -- Pattern: Black Dragonscale Boots
				{ 7,  19206 }, -- Plans: Dark Iron Helm
				{ 8,  17059 }, -- Plans: Dark Iron Reaver
				{ 9,  17060 }, -- Plans: Dark Iron Destroyer
				{ 10,  19448 }, -- Formula: Enchant Weapon - Mighty Spirit
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, 227830 }, -- Fine Flarecore Mantle
				{ 18, 227831 }, -- Fine Flarecore Robe
				{ 19, 227828 }, -- Lavawalker Belt
				{ 20, 227827 }, -- Molten Chain Girdle
				{ 21, 227829 }, -- Hardened Black Dragonscale Boots
				{ 22, 227824 }, -- Tempered Dark Iron Helm
				{ 23, 227826 }, -- Dark Iron Flame Reaver
				{ 24, 227825 }, -- Molten Dark Iron Destroyer
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep5" },
				{ 2,  17018 }, -- Pattern: Flarecore Gloves
				{ 3,  17023 }, -- Pattern: Molten Helm
				{ 4,  17022 }, -- Pattern: Corehound Boots
				{ 5,  17051 }, -- Plans: Dark Iron Bracers
				{ 6,  20761 }, -- Recipe: Transmute Elemental Fire
				{ 7,  19444 }, -- Formula: Enchant Weapon - Strength
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, 227823 }, -- Fine Flarecore Gloves
				{ 18, 227821 }, -- Flamekissed Molten Helm
				{ 19, 227822 }, -- Thick Corehound Boots
				{ 20, 227820 }, -- Tempered Dark Iron Bracers
			},
		},
	},
}

data["CenarionCircle"] = {
	FactionID = 609,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep8" },
				{ 2,  234325 }, -- Pattern: Dreamscale Breastplate
				{ 3,  234461 }, -- Plans: Obisidian Mail Tunic
				{ 17, 234747 }, -- Fist of Cenarius
				{ 18, 234462 }, -- Earthstrike
				{ 19, 234463 }, -- Wrath of Cenarius
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep7" },
				{ 2,   22312 }, -- Pattern: Satchel of Cenarius
				{ 3,  234318 }, -- Pattern: Sylvan Vest
				{ 4,  234311 }, -- Pattern: Bramblewood Helm
				{ 5,  234305 }, -- Pattern: Spitfire Breastplate
				{ 6,  234299 }, -- Pattern: Sandstalker Breastplate
				{ 7,  234293 }, -- Plans: Ironvine Breastplate
				{ 8,  234458 }, -- Plans: Jagged Obsidian Shield
				{ 9,  234261 }, -- Schematic: Schematic: Arcane Megabomb
				{ 17, 234748 }, -- Deeprock Bracers
				{ 18, 234760 }, -- Rockfury Bracers
				{ 19, 234749 }, -- Earthcalm Orb
				{ 20, 234761 }, -- Might of Cenarius
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep6" },
				{ 2,  234316 }, -- Pattern: Sylvan Crown
				{ 3,  234297 }, -- Pattern: Sandstalker Gauntlets
				{ 4,  234303 }, -- Pattern: Spitfire Gauntlets
				{ 5,  234309 }, -- Pattern: Bramblewood Boots
				{ 6,  234291 }, -- Plans: Ironvine Gloves
				{ 7,  234322 }, -- Plans: Light Obsidian Belt
				{ 8,  234278 }, -- Manual: Smelt Obsidian-Infused Thorium Bar
				{ 9,   20733 }, -- Formula: Enchant Cloak - Greater Nature Resistance
				{ 10, 234257 }, -- Recipe: Elixir of the Honey Badger
				{ 11, 234258 }, -- Recipe: Elixir of the Mage-Lord
				{ 12, 234259 }, -- Recipe: Elixir of the Ironside
				{ 13, 234262 }, -- Schematic: The Fumigator
				{ 17, 234779 }, -- Grace of Earth
				{ 18, 234782 }, -- Earthpower Vest
				{ 19, 234780 }, -- Band of Earthen Might
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep5" },
				{ 2,  234445 }, -- Pattern: Bolt of Qiraji Silk
				{ 3,  234314 }, -- Pattern: Sylvan Shoulders
				{ 4,   22310 }, -- Pattern: Cenarion Herb Bag
				{ 5,  234307 }, -- Pattern: Bramblewood Belt
				{ 6,  234295 }, -- Pattern: Sandstalker Bracers
				{ 7,  234289 }, -- Plans: Ironvine Belt
				{ 8,  234320 }, -- Plans: Heavy Obsidian Belt
				{ 9,  234279 }, -- Plans: Obsidian Grinding Stone
				{ 10,  20732 }, -- Formula: Enchant Cloak - Greater Fire Resistance
				{ 11, 234272 }, -- Formula: Enchanted Repellent
				{ 12, 234271 }, -- Formula: Scroll: Wrath of the Swarm
				{ 13, 234260 }, -- Recipe: Elixir of Alacrity
				{ 14, 234263 }, -- Schematic: Obsidian Bomb
				{ 15, 234280 }, -- Schematic: Obsidian Blasting Powder
				{ 17, 234785 }, -- Gloves of Earthen Power
				{ 18, 234788 }, -- Earthweave Cloak
				{ 19, 234786 }, -- Band of Earthen Wrath
			},
		},
	},
}

data["ZandalarTribe"] = {
	FactionID = 270,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep8" },
				{ 2,  20013 }, -- Recipe: Living Action Potion
				{ 3,  20077 }, -- Zandalar Signet of Might
				{ 4,  20076 }, -- Zandalar Signet of Mojo
				{ 5,  20078 }, -- Zandalar Signet of Serenity
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep7" },
				{ 2,  19764 }, -- Pattern: Bloodvine Vest
				{ 3,  19769 }, -- Pattern: Primal Batskin Jerkin
				{ 4,  19772 }, -- Pattern: Blood Tiger Breastplate
				{ 5,  19776 }, -- Plans: Bloodsoul Breastplate
				{ 6,  19779 }, -- Plans: Darksoul Breastplate
				{ 7,  20011 }, -- Recipe: Mageblood Potion
				{ 17,  20080 }, -- Sheen of Zanza
				{ 18,  20079 }, -- Spirit of Zanza
				{ 19,  20081 }, -- Swiftness of Zanza
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep6" },
				{ 2,  19765 }, -- Pattern: Bloodvine Leggings
				{ 3,  20000 }, -- Schematic: Bloodvine Goggles
				{ 4,  19770 }, -- Pattern: Primal Batskin Gloves
				{ 5,  19773 }, -- Pattern: Blood Tiger Shoulders
				{ 6,  19777 }, -- Plans: Bloodsoul Shoulders
				{ 7,  19780 }, -- Plans: Darksoul Leggings
				{ 8,  20014 }, -- Recipe: Major Troll's Blood Potion
				{ 9,  20756 }, -- Formula: Brilliant Wizard Oil
				{ 10,  20031 }, -- Essence Mango
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep5" },
				{ 2,  19766 }, -- Pattern: Bloodvine Boots
				{ 3,  19771 }, -- Pattern: Primal Batskin Bracers
				{ 4,  20001 }, -- Schematic: Bloodvine Lens
				{ 5,  19778 }, -- Plans: Bloodsoul Gauntlets
				{ 6,  19781 }, -- Plans: Darksoul Shoulders
				{ 7,  20012 }, -- Recipe: Greater Dreamless Sleep
				{ 8,  20757 }, -- Formula: Brilliant Mana Oil
			},
		},
	},
}

data["BroodOfNozdormu"] = {
	FactionID = 910,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep8" },
				{ 2, 21210 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 3, 21205 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 4, 21200 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, "INV_Box_01", nil, AL["Physical Damage"], nil },
				{ 18, 234034 }, --Signet Ring of the Bronze Dragonflight / 80				
				{ 19, 234202 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 20, "INV_Box_01", nil, AL["Spell Damage"], nil },
				{ 21, 234032 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 22, 234436 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 23, "INV_Box_01", nil, AL["Tank"], nil },
				{ 24, 234035 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 25, 234964 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 26, "INV_Box_01", nil, AL["Healing"], nil },
				{ 27, 234033 }, --Signet Ring of the Bronze Dragonflight / 80
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep7" },
				{ 2, 21209 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 3, 21204 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 4, 21199 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, "INV_Box_01", nil, AL["Physical Damage"], nil },
				{ 18, 234030 }, --Signet Ring of the Bronze Dragonflight / 75				
				{ 19, 234201 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 20, "INV_Box_01", nil, AL["Spell Damage"], nil },
				{ 21, 234028 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 22, 234437 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 23, "INV_Box_01", nil, AL["Tank"], nil },
				{ 24, 234031 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 25, 234965 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 26, "INV_Box_01", nil, AL["Healing"], nil },
				{ 27, 234029 }, --Signet Ring of the Bronze Dragonflight / 75
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep6" },
				{ 2, 21208 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 3, 21203 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 4, 21198 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, "INV_Box_01", nil, AL["Physical Damage"], nil },
				{ 18, 234026 }, --Signet Ring of the Bronze Dragonflight / 70				
				{ 19, 234200 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 20, "INV_Box_01", nil, AL["Spell Damage"], nil },
				{ 21, 234024 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 22, 234438 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 23, "INV_Box_01", nil, AL["Tank"], nil },
				{ 24, 234027 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 25, 234966 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 26, "INV_Box_01", nil, AL["Healing"], nil },
				{ 27, 234025 }, --Signet Ring of the Bronze Dragonflight / 70
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep5" },
				{ 2, 21207 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 3, 21202 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 4, 21197 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, "INV_Box_01", nil, AL["Physical Damage"], nil },
				{ 18, 234021 }, --Signet Ring of the Bronze Dragonflight / 65				
				{ 19, 234199 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 20, "INV_Box_01", nil, AL["Spell Damage"], nil },
				{ 21, 234020 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 22, 234439 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 23, "INV_Box_01", nil, AL["Tank"], nil },
				{ 24, 234022 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 25, 234967 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 26, "INV_Box_01", nil, AL["Healing"], nil },
				{ 27, 234023 }, --Signet Ring of the Bronze Dragonflight / 65
			},
		},
		{ -- Neutral
			name = ALIL["Neutral"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep4" },
				{ 2, 21206 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 3, 21201 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 4, 21196 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 16, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 17, "INV_Box_01", nil, AL["Physical Damage"], nil },
				{ 18, 234017 }, --Signet Ring of the Bronze Dragonflight / 60				
				{ 19, 234198 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 20, "INV_Box_01", nil, AL["Spell Damage"], nil },
				{ 21, 234016 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 22, 234440 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 23, "INV_Box_01", nil, AL["Tank"], nil },
				{ 24, 234018 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 25, 234968 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 26, "INV_Box_01", nil, AL["Healing"], nil },
				{ 27, 234019 }, --Signet Ring of the Bronze Dragonflight / 60
			},
		},
	},
}

data["HydraxianWaterlords"] = {
	FactionID = 749,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep8" },
				{ 2, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 3, 227915}, -- Duke's Domain
				{ 4, 227927}, -- Oath of the Sea
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep7" },
				{ 2, 22687 }, -- Pattern: Glacial Wrists
				{ 3, 22698 }, -- Pattern: Icy Scale Bracers
				{ 4, 22705 }, -- Plans: Icebane Bracers
				{ 5, 22695 }, -- Pattern: Polar Bracers
				{ 6, 22754 }, -- Eternal Quintessence
				{ 9, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 10, 228979}, -- Enchanted Sigil: Flowing Waters
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep6" },
				{ 2, 17333 }, -- Aqual Quintessence
				{ 4, "INV_Box_01", nil, AL["SoD Exclusive"], nil },
				{ 5, 227926}, -- Hydraxian Coronation
			},
		},
	},
}


data["BloodsailBuccaneers"] = {
	FactionID = 87,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f87rep5" },
				{ 2, 12185 }, -- Bloodsail Admiral's Hat
				{ 3, 22742 }, -- Bloodsail Shirt
				{ 4, 22743 }, -- Bloodsail Sash
				{ 5, 22745 }, -- Bloodsail Pants
			},
		},
	},
}

data["WintersaberTrainers"] = {
	FactionID = 589,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[ALLIANCE_DIFF] = {
				{ 1, "f589rep8", [ATLASLOOT_IT_ALLIANCE] = true },
				{ 2, 13086, [ATLASLOOT_IT_ALLIANCE] = true }, -- Reins of the Winterspring Frostsaber
			},
		},
	},
}

--[[
	data["Timbermaw"] = {
	FactionID = 59,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep8" },
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep7" },
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep6" },
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep5" },
			},
		},
	},
}
]]


