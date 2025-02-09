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
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CLASSIC_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local SOD_DIFF = data:AddDifficulty("SoD")
local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID20_DIFF = data:AddDifficulty("20RAID")
local RAID40_DIFF = data:AddDifficulty("40RAID")

local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
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
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local SOD10_CONTENT = data:AddContentType(AL["SoD 10 man"], ATLASLOOT_RAID20_COLOR)
local SOD20_CONTENT = data:AddContentType(AL["SoD 20 man"], ATLASLOOT_RAID40_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID20_COLOR)
local RAID20_CONTENT = data:AddContentType(AL["20 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID40_CONTENT = data:AddContentType(AL["40 Raids"], ATLASLOOT_RAID40_COLOR)

local ATLAS_MODULE_NAME = "Atlas_ClassicWoW"

local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURP = "|cff9900ff%s|r"
local WHIT = "|cffffffff%s|r"

local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_BRD_RING_OF_LAW = NAME_COLOR_BOSS..AL["Ring of Law"]..":|r %s" -- Tempest Keep

local KEYS = {	-- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1, "INV_Box_01", nil, AL["Key"], nil },
		{ 2, 16309,},
		{ 3, 12344,},
		{ 4, 17191,},
		{ 5, 7146, },
		{ 6, 12382,},
		{ 7, 6893, },
		{ 8, 11000,},
		{ 9, 11140,},
		{ 10, 18249, },
		{ 11, 13704, },
		{ 12, 11197, },
		{ 13, 18266, },
		{ 14, 18268, },
		{ 15, 13873, },
		{ 16, "INV_Box_01", nil, AL["Misc"], nil },
		{ 17, 19931 },
		{ 18, 18250 },
		{ 19, 9240 },
		{ 20, 17333 },
		{ 21, 22754 },
		{ 22, 13523 },
		{ 23, 18746 },
		{ 24, 18663 },
		{ 25, 19974 },
		{ 26, 7733 },
		{ 27, 10818 },
		{ 29, 22057 },
		{ 30, 21986 },
	},
}

local T1_SET = {
	name = format(AL["Tier %s Sets"], "1"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1, 203 }, -- Warlock
		{ 3, 202 }, -- Priest
		{ 16, 201 }, -- Mage
		{ 5, 204 }, -- Rogue
		{ 20, 205 }, -- Druid
		{ 7, 206 }, -- Hunter
		{ 9, 209 }, -- Warrior
		{ 24, 208 }, -- Paladin
	},

	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 22, 207 }, -- Shaman
		{ 24 }, -- Paladin
	},
}

local T2_SET = {
	name = format(AL["Tier %s Sets"], "2"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 3,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1, 212 }, -- Warlock
		{ 3, 211 }, -- Priest
		{ 16, 210 }, -- Mage
		{ 5, 213 }, -- Rogue
		{ 20, 214 }, -- Druid
		{ 7, 215 }, -- Hunter
		{ 9, 218 }, -- Warrior
		{ 24, 217 }, -- Paladin
	},

	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 22, 216 }, -- Shaman
		{ 24 }, -- Paladin
	},
}

local T3_SET = {
	name = format(AL["Tier %s Sets"], "3"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 6,
	IgnoreAsSource = true,
	[SOD_DIFF] = {
		{ 1, 1904 }, -- Druid Balance
		{ 2, 1903 }, -- Druid Feral
		{ 3, 1902 }, -- Druid Resto
		{ 4, 1901 }, -- Druid Tank
		{ 6, 1899 }, -- Hunter (Ranged)
		{ 7, 1900 }, -- Hunter (Melee)
		{ 9, 1898 }, -- Mage (DPS)
		{ 10, 1897 }, -- Mage (Healer)
		{ 12, 1889 }, -- Shaman (Ele)
		{ 13, 1888 }, -- Shaman (Enhance)
		{ 14, 1887 }, -- Shaman (Resto)
		{ 15, 1886 }, -- Shaman (Tank)
		{ 16, 1896 }, -- Paladin (DPS)
		{ 17, 1895 }, -- Paladin (Healer)
		{ 18, 1894 }, -- Paladin (Tank)
		{ 20, 1893 }, -- Priest (DPS)
		{ 21, 1892 }, -- Priest (Healer)
		{ 23, 1891 }, -- Rogue (DPS)
		{ 24, 1890 }, -- Rogue (Tank)
		{ 26, 1885 }, -- Warlock (DPS)
		{ 27, 1884 }, -- Warlock (Tank)
		{ 29, 1883 }, -- Warrior (DPS)
		{ 30, 1882 }, -- Warrior (Tank)
	},
	[NORMAL_DIFF] = {
		{ 1, 529 }, -- Warlock
		{ 3, 525 }, -- Priest
		{ 16, 526 }, -- Mage
		{ 5, 524 }, -- Rogue
		{ 20, 521 }, -- Druid
		{ 7, 530 }, -- Hunter
		{ 9, 523 }, -- Warrior
		{ 22, 527 }, -- Shaman
		{ 24, 528 }, -- Paladin
	},
}

local AQ_SCARABS = { -- AQ40Trash2
	name = AL["Ahn'Qiraj scarabs"],
	ExtraList = true,
	[NORMAL_DIFF] = {
		{ 1,  20876 }, -- Idol of Death
		{ 2,  20879 }, -- Idol of Life
		{ 3,  20875 }, -- Idol of Night
		{ 4,  20878 }, -- Idol of Rebirth
		{ 5,  20881 }, -- Idol of Strife
		{ 6,  20877 }, -- Idol of the Sage
		{ 7,  20874 }, -- Idol of the Sun
		{ 8,  20882 }, -- Idol of War
		{ 10, 21762 }, -- Greater Scarab Coffer Key
		{ 12, 21156 }, -- Scarab Bag
		{ 14, 21230 }, -- Ancient Qiraji Artifact
		{ 16, 20864 }, -- Bone Scarab
		{ 17, 20861 }, -- Bronze Scarab
		{ 18, 20863 }, -- Clay Scarab
		{ 19, 20862 }, -- Crystal Scarab
		{ 20, 20859 }, -- Gold Scarab
		{ 21, 20865 }, -- Ivory Scarab
		{ 22, 20860 }, -- Silver Scarab
		{ 23, 20858 }, -- Stone Scarab
		{ 26, 22203 }, -- Large Obsidian Shard
		{ 27, 22202 }, -- Small Obsidian Shard
		{ 29, 21229 }, -- Qiraji Lord's Insignia
	},
}

local AQ_ENCHANTS = { -- AQEnchants
	name = AL["Ahn'Qiraj enchants"],
	ExtraList = true,
		[SOD_DIFF] = {
		{ 1,  20728 }, -- Formula: Enchant Gloves - Frost Power
		{ 2,  20731 }, -- Formula: Enchant Gloves - Superior Agility
		{ 3,  20734 }, -- Formula: Enchant Cloak - Stealth
		{ 4,  20729 }, -- Formula: Enchant Gloves - Fire Power
		{ 5,  20736 }, -- Formula: Enchant Cloak - Dodge
		{ 6,  20730 }, -- Formula: Enchant Gloves - Healing Power
		{ 7,  20727 }, -- Formula: Enchant Gloves - Shadow Power
		{ 9, 233998 }, -- Formula: Enchant Gloves - Holy Power
		{ 10, 233999 }, -- Formula: Enchant Gloves - Arcane Power
		{ 11, 235526 }, -- Formula: Enchant Bracer - Spell Power
		{ 12, 235528 }, -- Formula: Enchant Bracer - Agility
		{ 13, 233997 }, -- Formula: Living Stats
	},
	[NORMAL_DIFF] = {
		{ 1,  20728 }, -- Formula: Enchant Gloves - Frost Power
		{ 2,  20731 }, -- Formula: Enchant Gloves - Superior Agility
		{ 3,  20734 }, -- Formula: Enchant Cloak - Stealth
		{ 4,  20729 }, -- Formula: Enchant Gloves - Fire Power
		{ 5,  20736 }, -- Formula: Enchant Cloak - Dodge
		{ 6,  20730 }, -- Formula: Enchant Gloves - Healing Power
		{ 7,  20727 }, -- Formula: Enchant Gloves - Shadow Power
	},
}

local AQ_OPENING = {	-- Keys
	name = AL["AQ opening"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	ContentPhase = 5,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,  21138 }, -- Red Scepter Shard
		{ 2,  21529 }, -- Amulet of Shadow Shielding
		{ 3,  21530 }, -- Onyx Embedded Leggings
		{ 5,  21139 }, -- Green Scepter Shard
		{ 6,  21531 }, -- Drake Tooth Necklace
		{ 7,  21532 }, -- Drudge Boots
		{ 9,  21137 }, -- Blue Scepter Shard
		{ 10, 21517 }, -- Gnomish Turban of Psychic Might
		{ 11, 21527 }, -- Darkwater Robes
		{ 12, 21526 }, -- Band of Icy Depths
		{ 13, 21025 }, -- Recipe: Dirge's Kickin' Chimaerok Chops
		{ 16, 21175 }, -- The Scepter of the Shifting Sands
		{ 17, 21176 }, -- Black Qiraji Resonating Crystal
		{ 18, 21523 }, -- Fang of Korialstrasz
		{ 19, 21521 }, -- Runesword of the Red
		{ 20, 21522 }, -- Shadowsong's Sorrow
		{ 21, 21520 }, -- Ravencrest's Legacy
	},
	[SOD_DIFF] = {
		{ 1,  21138 }, -- Red Scepter Shard
		{ 2,  234130 }, -- Amulet of Shadow Shielding
		{ 3,  234129 }, -- Onyx Embedded Leggings
		{ 5,  21139 }, -- Green Scepter Shard
		{ 6,  234132 }, -- Drake Tooth Necklace
		{ 7,  234133 }, -- Drudge Boots
		{ 9,  21137 }, -- Blue Scepter Shard
		{ 10, 234134 }, -- Gnomish Turban of Psychic Might
		{ 11, 234136 }, -- Darkwater Robes
		{ 12, 234135 }, -- Band of Icy Depths
		{ 13, 21025 }, -- Recipe: Dirge's Kickin' Chimaerok Chops
		{ 16, 21175 }, -- The Scepter of the Shifting Sands
		{ 17, 21176 }, -- Black Qiraji Resonating Crystal
		{ 18, 234137 }, -- Fang of Korialstrasz
		{ 19, 234141 }, -- Runesword of the Red
		{ 20, 234138 }, -- Shadowsong's Sorrow
		{ 21, 234139 }, -- Ravencrest's Legacy
	},
}

local DM_BOOKS = { -- DMBooks
	name = AL["Books"],
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,  18401 }, -- Foror's Compendium of Dragon Slaying
		{ 2,  18362 }, -- Holy Bologna: What the Light Won't Tell You
		{ 3,  18358 }, -- The Arcanist's Cookbook
		{ 4,  18360 }, -- Harnessing Shadows
		{ 5,  18356 }, -- Garona: A Study on Stealth and Treachery
		{ 6,  18364 }, -- The Emerald Dream
		{ 7,  18361 }, -- The Greatest Race of Hunters
		{ 8,  18363 }, -- Frost Shock and You
		{ 9, 18359 }, -- The Light and How to Swing It
		{ 10, 18357 }, -- Codex of Defense
		--{ 16, 18348 }, -- Quel'Serrar
		{ 12, 18333 }, -- Libram of Focus
		{ 13, 18334 }, -- Libram of Protection
		{ 14, 18332 }, -- Libram of Rapidity
		{ 15, 11733 }, -- Libram of Constitution
		{ 16, "INV_Box_01", nil, AL["Updated in SoD"], nil },
		{ 18, 228466 }, -- The Arcanist's Cookbook
		{ 20, 228464 }, -- Garona: A Study on Stealth and Treachery
		{ 24, 228467 }, -- The Light and How to Swing It
		{ 25, 228465 }, -- Codex of Defense
		{ 27, 11736 }, -- Libram of Resilience
		{ 28, 11732 }, -- Libram of Rumination
		{ 29, 11734 }, -- Libram of Tenacity
		{ 30, 11737 }, -- Libram of Voracity
	},
}

data["Ragefire"] = {
	MapID = 2437,
	InstanceID = 389,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Ragefire",
	AtlasMapFile = "RagefireChasm",
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({10, 13, 18}, {8, 13, 16}),
	items = {
		{ -- RFCTaragaman
			name = AL["Taragaman the Hungerer"],
			npcID = 11520,
			Level = 16,
			DisplayIDs = {{7970}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  14149 }, -- Subterranean Cape
				{ 2,  14148 }, -- Crystalline Cuffs
				{ 3,  14145 }, -- Cursed Felblade
			},
		},
		{ -- RFCJergosh
			name = AL["Jergosh the Invoker"],
			npcID = 11518,
			Level = 16,
			DisplayIDs = {{11429}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  14150 }, -- Robe of Evocation
				{ 2,  14147 }, -- Cavedweller Bracers
				{ 3,  14151 }, -- Chanting Blade
			},
		},
	},
}

data["WailingCaverns"] = {
	MapID = 718,
	InstanceID = 43,
	SubAreaIDs = { 15285, 15301, 15294, 15300, 15292, 17731 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "WailingCaverns",
	AtlasMapFile = {"CL_WailingCaverns", "CL_WailingCavernsEnt"},
	AtlasMapFile_AL = {"WailingCaverns", "WailingCavernsEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({10, 17, 24}, {10, 17, 21}),
	items = {
		{ -- WCLordCobrahn
			name = AL["Lord Cobrahn"],
			npcID = 3669,
			Level = 20,
			SubAreaID = 15300,
			DisplayIDs = {{4213}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  6460 }, -- Cobrahn's Grasp
				{ 2,  10410 }, -- Leggings of the Fang
				{ 4,  6465 }, -- Robe of the Moccasin
			},
		},
		{ -- WCLadyAnacondra
			name = AL["Lady Anacondra"],
			npcID = 3671,
			Level = 20,
			DisplayIDs = {{4313}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  10412 }, -- Belt of the Fang
				{ 3,  5404 }, -- Serpent's Shoulders
				{ 4,  6446 }, -- Snakeskin Bag
			},
		},
		{ -- WCKresh
			name = AL["Kresh"],
			npcID = 3653,
			Level = 20,
			DisplayIDs = {{5126}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  13245 }, -- Kresh's Back
				{ 3,  6447 }, -- Worn Turtle Shell Shield
			},
		},
		{ -- WCLordPythas
			name = AL["Lord Pythas"],
			npcID = 3670,
			Level = GetForVersion(21, 20),
			SubAreaID = 17731,
			DisplayIDs = {{4214}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6472 }, -- Stinging Viper
				{ 3,  6473 }, -- Armor of the Fang
			},
		},
		{ -- WCSkum
			name = AL["Skum"],
			npcID = 3674,
			Level = GetForVersion(21, 20),
			DisplayIDs = {{4203}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  6449 }, -- Glowing Lizardscale Cloak
				{ 3,  6448 }, -- Tail Spike
			},
		},
		{ -- WCLordSerpentis
			name = AL["Lord Serpentis"],
			npcID = 3673,
			Level = GetForVersion(21, 20),
			DisplayIDs = {{4215}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  6469 }, -- Venomstrike
				{ 3,  5970 }, -- Serpent Gloves
				{ 4,  10411 }, -- Footpads of the Fang
				{ 5,  6459 }, -- Savage Trodders
			},
		},
		{ -- WCVerdan
			name = AL["Verdan the Everliving"],
			npcID = 5775,
			Level = GetForVersion(21, 20),
			DisplayIDs = {{4256}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  6630 }, -- Seedcloud Buckler
				{ 2,  6631 }, -- Living Root
				{ 4,  6629 }, -- Sporid Cape
			},
		},
		{ -- WCMutanus
			name = AL["Mutanus the Devourer"],
			npcID = 3654,
			Level = GetForVersion(22, 20),
			SubAreaID = 15294,
			DisplayIDs = {{4088}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  6461 }, -- Slime-encrusted Pads
				{ 2,  6627 }, -- Mutant Scale Breastplate
				{ 3,  6463 }, -- Deep Fathom Ring
				{ 16,  10441 }, -- Glowing Shard
			},
		},
		{ -- WCDeviateFaerieDragon
			name = AL["Deviate Faerie Dragon"],
			npcID = 5912,
			Level = GetForVersion(19, 20),
			DisplayIDs = {{1267}},
			AtlasMapBossID = 10,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  5243 }, -- Firebelcher
				{ 3,  6632 }, -- Feyscale Cloak
			},
		},
		{ -- WCTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10413 }, -- Gloves of the Fang
			},
		},
	},
}

data["TheDeadmines"] = {
	MapID = 1581,
	InstanceID = 36,
	SubAreaIDs = { 19444, 19529, 19502, 26104 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheDeadmines",
	AtlasMapFile_AL = {"TheDeadmines", "TheDeadminesEnt"},
	AtlasMapFile = {"CL_TheDeadmines", "CL_TheDeadminesEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({10, 17, 26}, {10, 18, 22}),
	items = {
		{	--DMRhahkZor
			name = AL["Rhahk'Zor"],
			npcID = 644,
			Level = 19,
			DisplayIDs = {{14403}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 872 },	-- Rockslicer
				{ 3, 5187 },	-- Rhahk'Zor's Hammer
			},
		},
		{	--DMMinerJohnson
			name = AL["Miner Johnson"],
			npcID = 3586,
			Level = 19,
			DisplayIDs = {{556}},
			specialType = "rare",
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 5443 },	-- Gold-plated Buckler
				{ 3, 5444 },	-- Miner's Cape
			},
		},
		{	--DMSneed
			name = AL["Sneed"],
			npcID = 643,
			Level = 20,
			SubAreaID = 19529,
			DisplayIDs = {{7125}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 5194 },	-- Taskmaster Axe
				{ 3, 5195 },	-- Gold-flecked Gloves
			},
		},
		{	--DMSneedsShredder
			name = AL["Sneed's Shredder"],
			npcID = 642,
			Level = 20,
			DisplayIDs = {{1269}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 1937 },	-- Buzz Saw
				{ 3, 2169 },	-- Buzzer Blade
			},
		},
		{	--DMGilnid
			name = AL["Gilnid"],
			npcID = 1763,
			Level = 20,
			SubAreaID = 19502,
			DisplayIDs = {{7124}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 1156 },	-- Lavishly Jeweled Ring
				{ 3, 5199 },	-- Smelting Pants
			},
		},
		{	--DMMrSmite
			name = AL["Mr. Smite"],
			npcID = 646,
			Level = 20,
			SubAreaID = 26104,
			DisplayIDs = {{2026}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 7230 },	-- Smite's Mighty Hammer
				{ 3, 5192 },	-- Thief's Blade
				{ 4, 5196 },	-- Smite's Reaver
			},
		},
		{	--DMCaptainGreenskin
			name = AL["Captain Greenskin"],
			npcID = 647,
			Level = 20,
			DisplayIDs = {{7113},{2349},{2347},{5207}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5201 },	-- Emberstone Staff
				{ 3, 10403 },	-- Blackened Defias Belt
				{ 4, 5200 },	-- Impaling Harpoon
			},
		},
		{	--DMVanCleef
			name = AL["Edwin VanCleef"],
			npcID = 639,
			Level = GetForVersion(21,20),
			DisplayIDs = {{2029}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5193 },	-- Cape of the Brotherhood
				{ 2, 5202 },	-- Corsair's Overshirt
				{ 3, 10399 },	-- Blackened Defias Armor
				{ 4, 5191 },	-- Cruel Barb
				{ 6, 2874 },	-- An Unsent Letter
			},
		},
		{	--DMCookie
			name = AL["Cookie"],
			npcID = 645,
			Level = 20,
			DisplayIDs = {{1305}},
			specialType = "elite",
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5198 },	-- Cookie's Stirring Rod
				{ 3, 5197 },	-- Cookie's Tenderizer
				{ 5, 8490 },	-- Cat Carrier (Siamese)
			},
		},
		{	--DMDefiasGunpowder
			name = AL["Defias Gunpowder"],
			ExtraList = true,
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 5397 },	-- Defias Gunpowder
			},
		},
		{	--DMTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 8492 },	-- Parrot Cage (Green Wing Macaw)
			},
		},
		KEYS,
	}
}

data["ShadowfangKeep"] = {
	MapID = 209,
	InstanceID = 33,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ShadowfangKeep",
	AtlasMapFile = "CL_ShadowfangKeep",
	AtlasMapFile_AL = "ShadowfangKeep",
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({11, 22, 30}, {14, 18, 21}),
	items = {
		{ -- SFKRethilgore
			name = AL["Rethilgore"],
			npcID = 3914,
			Level = 20,
			DisplayIDs = {{524}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  5254 }, -- Rugged Spaulders
			},
		},
		{ -- SFKFelSteed
			name = AL["Fel Steed / Shadow Charger"],
			npcID = {3865, 3864},
			Level = GetForVersion({19, 20}, {18,19}),
			DisplayIDs = {{1952},{1951}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  6341 }, -- Eerie Stable Lantern
				{ 3,  932 }, -- Fel Steed Saddlebags
			},
		},
		{ -- SFKRazorclawtheButcher
			name = AL["Razorclaw the Butcher"],
			npcID = 3886,
			Level = GetForVersion(22,20),
			DisplayIDs = {{524}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  1292 }, -- Butcher's Cleaver
				{ 3,  6226 }, -- Bloody Apron
				{ 4,  6633 }, -- Butcher's Slicer
			},
		},
		{ -- SFKSilverlaine
			name = AL["Baron Silverlaine"],
			npcID = 3887,
			Level = GetForVersion(24,20),
			DisplayIDs = {{3222}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6321 }, -- Silverlaine's Family Seal
				{ 3,  6323 }, -- Baron's Scepter
			},
		},
		{ -- SFKSpringvale
			name = AL["Commander Springvale"],
			npcID = 4278,
			Level = GetForVersion(24,20),
			DisplayIDs = {{3223}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  6320 }, -- Commander's Crest
				{ 3,  3191 }, -- Arced War Axe
			},
		},
		{ -- SFKOdotheBlindwatcher
			name = AL["Odo the Blindwatcher"],
			npcID = 4279,
			Level = GetForVersion(24,21),
			DisplayIDs = {{522}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  6318 }, -- Odo's Ley Staff
				{ 3,  6319 }, -- Girdle of the Blindwatcher
			},
		},
		{ -- SFKDeathswornCaptain
			name = AL["Deathsworn Captain"],
			npcID = 3872,
			Level = GetForVersion(25,21),
			DisplayIDs = {{3224}},
			specialType = "rare",
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  6642 }, -- Phantom Armor
				{ 3,  6641 }, -- Haunting Blade
			},
		},
		{ -- SFKArugalsVoidwalker
			name = AL["Arugal's Voidwalker"],
			npcID = 4627,
			Level = GetForVersion({24, 25}, 20),
			DisplayIDs = {{1131}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  5943 }, -- Rift Bracers
			},
		},
		{ -- SFKFenrustheDevourer
			name = AL["Fenrus the Devourer"],
			npcID = 4274,
			Level = GetForVersion(25,21),
			DisplayIDs = {{2352}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  6340 }, -- Fenrus' Hide
				{ 2,  3230 }, -- Black Wolf Bracers
			},
		},
		{ -- SFKWolfMasterNandos
			name = AL["Wolf Master Nandos"],
			npcID = 3927,
			Level = GetForVersion(25,21),
			DisplayIDs = {{11179}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  3748 }, -- Feline Mantle
				{ 3,  6314 }, -- Wolfmaster Cape
			},
		},
		{ -- SFKArchmageArugal
			name = AL["Archmage Arugal"],
			npcID = 4275,
			Level = GetForVersion(25,21),
			DisplayIDs = {{2353}},
			AtlasMapBossID = 12,
			[NORMAL_DIFF] = {
				{ 1,  6324 }, -- Robes of Arugal
				{ 2,  6392 }, -- Belt of Arugal
				{ 3,  6220 }, -- Meteor Shard
			},
		},
		{ -- SFKTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  2292 }, -- Necrology Robes
				{ 2,  1489 }, -- Gloomshroud Armor
				{ 3,  1974 }, -- Mindthrust Bracers
				{ 4,  2807 }, -- Guillotine Axe
				{ 5,  1482 }, -- Shadowfang
				{ 6,  1935 }, -- Assassin's Blade
				{ 7,  1483 }, -- Face Smasher
				{ 8,  1318 }, -- Night Reaver
				{ 9,  3194 }, -- Black Malice
				{ 10, 2205 }, -- Duskbringer
				{ 11, 1484 }, -- Witching Stave
			},
		},
		{ -- SFKSever
			name = AL["Sever"],
			npcID = 14682,
			DisplayIDs = {{1061}},
			AtlasMapBossID = 7,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  23173 }, -- Abomination Skin Leggings
				{ 2,  23171 }, -- The Axe of Severing
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, { -- SFKApothecaryH
			name = AL["Apothecary Hummel <Crown Chemical Co.>"],
			npcID = 36296,
			Level = 83,
			DisplayIDs = {{31167}},
			AtlasMapBossID = 3,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  51804 }, -- Winking Eye of Love
				{ 2,  51805 }, -- Heartbreak Charm
				{ 3,  51806 }, -- Shard of Pirouetting Happiness
				{ 4,  51807 }, -- Sweet Perfume Broach
				{ 5,  51808 }, -- Choker of the Pure Heart
				{ 7,  49641 }, -- Faded Lovely Greeting Card
				{ 8,  49715 }, -- Forever-Lovely Rose
				{ 9,  50250 }, -- X-45 Heartbreaker
				{ 10,  50446 }, -- Toxic Wasteling
				{ 11,  50471 }, -- The Heartbreaker
				{ 12,  50741 }, -- Vile Fumigator's Mask
			},
		}),
		{ -- SFKJordansHammer
			name = AL["Jordan's Smithing Hammer"],
			ExtraList = true,
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  6895 }, -- Jordan's Smithing Hammer
			},
		},
		{ -- SFKBookofUr
			name = AL["The Book of Ur"],
			ExtraList = true,
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  6283 }, -- The Book of Ur
			},
		},
	},
}

data["TheStockade"] = {
	MapID = 717,
	InstanceID = 34,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheStockade",
	AtlasMapFile = "CL_TheStockade",
	AtlasMapFile_AL = "TheStockade",
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({15, 24, 32}, {15, 23, 29}),
	items = {
		{ -- SWStKamDeepfury
			name = AL["Kam Deepfury"],
			npcID = 1666,
			Level = GetForVersion(27, 25),
			DisplayIDs = {{825}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  2280 }, -- Kam's Walking Stick
			},
		},
		{ -- SWStBruegalIronknuckle
			name = AL["Bruegal Ironknuckle"],
			npcID = 1720,
			Level = GetForVersion(26, 25),
			DisplayIDs = {{2142}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  3228 }, -- Jimmied Handcuffs
				{ 2,  2941 }, -- Prison Shank
				{ 3,  2942 }, -- Iron Knuckles
			},
		},
		{ -- SWStTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  1076 }, -- Defias Renegade Ring
			},
		},
	},
}
data["BlackfathomDeeps2"] = {
	MapID = 719,
	InstanceID = 48,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackfathomDeeps",
	AtlasMapFile = {"CL_BlackfathomDeepsA", "CL_BlackfathomDeepsEnt"},
	AtlasMapFile_AL = {"BlackfathomDeeps", "BlackfathomDeepsEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = {25,25,40},
	items = {
		{ -- BFDBaronAquanis
			name = AL["Baron Aquanis"],
			npcID = 202699,
			Level = GetForVersion(28,24),
			DisplayIDs = {{110}},
			[SOD_DIFF] = {
				{ 1,  211454 }, -- Strange Water Globe
				{ 2,  211852 }, -- Handwraps of Befouled Water
				{ 3,  209423 }, -- Flowing Scarf
				{ 4,  209421 }, -- Cord of Aquanis
				{ 5,  209828 }, -- Sub-Zero Pauldrons
				{ 6,  209422 }, -- High Tide Choker
				{ 7,  209825 }, -- Droplet Choker
				{ 8,  204807 }, -- Fathomblade
				{ 9,  204804 }, -- Hydraxian Bangles
				{ 10,  209676 }, -- Shoulderguards of Crushing Depths
				{ 11,  209590 }, -- Cracked Water Globe
				{ 12,  209677 }, -- Loop of Swift Currents
			},
			[NORMAL_DIFF] = {
				{ 1,  16782 }, -- Strange Water Globe
			},			
		},
		{ -- BFDGhamoora
			name = AL["Ghamoo-ra"],
			npcID = 201722,
			Level = GetForVersion(25,23),
			DisplayIDs = {{5027}},
			[SOD_DIFF] = {
				{ 1,  209436 }, -- Chipped Bite of Serra'kis
				{ 2,  209830 }, -- Ironhide Arbalest
				{ 3,  209418 }, -- Adamantine Tortoise Armor
				{ 4,  209824 }, -- Shimmering Shoulderpads
				{ 5,  209523 }, -- Shimmering Thresher Cape
				{ 6,  209432 }, -- Ghamoo-ra's Cinch
				{ 7,  209678 }, -- Mantle of the Thresher Slayer
				{ 8,  209424 }, -- Shell Plate Barrier
				{ 9,  209675 }, -- Clamweave Tunic
				{ 10,  209524 }, -- Bindings of Serra'kis
			},
			[NORMAL_DIFF] = {
				{ 1,  6907 }, -- Tortoise Armor
				{ 3,  6908 }, -- Ghamoo-ra's Bind
			},
		},
		{ -- BFDLadySarevess
			name = AL["Lady Sarevess"],
			npcID = 204068,
			Level = GetForVersion(25,23),
			DisplayIDs = {{4979}},
			[SOD_DIFF] = {
				{ 1,  209566 }, -- Leggings of the Faithful
				{ 2,  211789 }, -- Artemis Cowl
				{ 3,  211842 }, -- Rakkamar's Tattered Thinking Cap
				{ 4,  209680 }, -- Waterproof Scarf
				{ 5,  209525 }, -- Honed Darkwater Talwar
				{ 6,  209565 }, -- Band of Deep Places
				{ 7,  211843 }, -- Mask of Scorn
				{ 8,  209563 }, -- Naga Heartrender
				{ 9,  209564 }, -- Guardian's Trident
				{ 10,  209527 }, -- Naga Battle Gauntlets
				{ 11,  209822 }, -- Strength of Purpose
				{ 12,  209679 }, -- Azshari Novice's Shoulderpads
				{ 13,  209823 }, -- Signet of Beasts
			},
			[NORMAL_DIFF] = {
				{ 1,  888 }, -- Naga Battle Gloves
				{ 3,  3078 }, -- Naga Heartpiercer
				{ 4,  11121 }, -- Darkwater Talwar
			},
		},
		{ -- BFDGelihast
			name = AL["Gelihast"],
			npcID = 204921,
			Level = GetForVersion(26,24),
			DisplayIDs = {{1773}},
			[SOD_DIFF] = {
				{ 1,  209569 }, -- Murloc Hide Kneeboots
				{ 2,  209559 }, -- Twilight Sage's Walking Stick
				{ 3,  209568 }, -- Algae Gauntlets
				{ 4,  209820 }, -- Black Shroud Choker
				{ 5,  209573 }, -- Wrathful Spire
				{ 6,  209567 }, -- Coral Reef Axe
				{ 7,  209571 }, -- Deadlight
				{ 8,  209670 }, -- Skinwalkers
				{ 9,  209570 }, -- Tome of Cavern Lore
				{ 10,  209821 }, -- Ring of Shadowsight
				{ 11,  209572 }, -- Black Boiled Leathers
				{ 12,  209681 }, -- Black Murloc Egg
				{ 13,  211491 }, -- Bottomless Murloc Skin Bag
				{ 16,  211505 }, -- Twilight Avenger's Helm
				{ 17,  211504 }, -- Twilight Avenger's Chain
				{ 18,  211506 }, -- Twilight Avenger's Boots
				{ 20,  211507 }, -- Twilight Elementalist's Cowl
				{ 21,  211509 }, -- Twilight Elementalist's Robe
				{ 22,  211508 }, -- Twilight Elementalist's Footpads
				{ 24,  211510 }, -- Twilight Slayer's Cowl
				{ 25,  211512 }, -- Twilight Slayer's Tunic 
				{ 26,  211511 }, -- Twilight Slayer's Footpads
				{ 28,  209683 }, -- Twilight Invoker's Shawl
				{ 29,  209671 }, -- Twilight Invoker's Robes
				{ 30,  209669 }, -- Twilight Invoker's Shoes
			},
			[NORMAL_DIFF] = {
				{ 1,  6906 }, -- Algae Fists
				{ 3,  6905 }, -- Reef Axe
				{ 5,  1470 }, -- Murloc Skin Bag
			},
		},
		{ -- BFDOldSerrakis
			name = AL["Lorgus Jett"],
			npcID = 207356,
			Level = GetForVersion(26,24),
			DisplayIDs = {{1816}},
			[SOD_DIFF] = {
				{ 1,  209560 }, -- Hammer of Righteous Judgement
				{ 2,  209576 }, -- Mind-Expanding Mushroom
				{ 3,  209818 }, -- Sun-Touched Crescent
				{ 4,  209581 }, -- Silver Hand Sabatons
				{ 5,  209578 }, -- Glowing Leather Bands
				{ 6,  209682 }, -- Sturdy Hood
				{ 7,  209574 }, -- Discarded Tenets of the Silver Hand
				{ 8,  209577 }, -- Fist of the Wild
				{ 9,  209575 }, -- Carved Driftwood Icon
				{ 10,  209579 }, -- Crashing Thunder
				{ 16,  211505 }, -- Twilight Avenger's Helm
				{ 17,  211504 }, -- Twilight Avenger's Chain
				{ 18,  211506 }, -- Twilight Avenger's Boots
				{ 20,  211507 }, -- Twilight Elementalist's Cowl
				{ 21,  211509 }, -- Twilight Elementalist's Robe
				{ 22,  211508 }, -- Twilight Elementalist's Footpads
				{ 24,  211510 }, -- Twilight Slayer's Cowl
				{ 25,  211512 }, -- Twilight Slayer's Tunic 
				{ 26,  211511 }, -- Twilight Slayer's Footpads
				{ 28,  209683 }, -- Twilight Invoker's Shawl
				{ 29,  209671 }, -- Twilight Invoker's Robes
				{ 30,  209669 }, -- Twilight Invoker's Shoes
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Unavailable in Classic"], nil },
			},
		},
		{ -- BFDTwilightLordKelris
			name = AL["Twilight Lord Kelris"],
			npcID = 4832,
			Level = GetForVersion(27,24),
			DisplayIDs = {{4939}},
			AtlasMapFile = {"CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt"},
			[SOD_DIFF] = {
				{ 1,  209694 }, -- Blackfathom Ritual Dagger
				{ 2,  209672 }, -- Black Fingerless Gloves
				{ 3,  209686 }, -- Jagged Bone Necklace
				{ 4,  209667 }, -- Gaze Dreamer Leggings
				{ 5,  209668 }, -- Signet of the Twilight Lord
				{ 6,  211455 }, -- Slick Fingerless Gloves
				{ 7,  209817 }, -- Voidwalker Brooch
				{ 8,  209674 }, -- Phoenix Ignition
				{ 9,  211458 }, -- Tome of Shadow Warding
				{ 10,  211457 }, -- Twilight Defender's Girdle
				{ 11,  209673 }, -- Glowing Fetish Amulet
				{ 12,  209816 }, -- Fetish of Mischief
				{ 13,  209561 }, -- Rod of the Ancient Sleepwalker
				{ 14,  211492 }, -- Kelris's Satchel
				{ 16,  211505 }, -- Twilight Avenger's Helm
				{ 17,  211504 }, -- Twilight Avenger's Chain
				{ 18,  211506 }, -- Twilight Avenger's Boots
				{ 20,  211507 }, -- Twilight Elementalist's Cowl
				{ 21,  211509 }, -- Twilight Elementalist's Robe
				{ 22,  211508 }, -- Twilight Elementalist's Footpads
				{ 24,  211510 }, -- Twilight Slayer's Cowl
				{ 25,  211512 }, -- Twilight Slayer's Tunic 
				{ 26,  211511 }, -- Twilight Slayer's Footpads
				{ 28,  209683 }, -- Twilight Invoker's Shawl
				{ 29,  209671 }, -- Twilight Invoker's Robes
				{ 30,  209669 }, -- Twilight Invoker's Shoes
			},
			[NORMAL_DIFF] = {
				{ 1,  1155 }, -- Rod of the Sleepwalker
				{ 3,  6903 }, -- Gaze Dreamer Pants
			},
		},
		{ -- BFDOldSerrakis
			name = AL["Old Serra'kis"],
			npcID = 4830,
			Level = GetForVersion(26,24),
			DisplayIDs = {{1816}},
			AtlasMapFile = {"CL_BlackfathomDeepsC", "CL_BlackfathomDeepsEnt"},
			[SOD_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Unavailable in SoD"], nil },
			},
			[NORMAL_DIFF] = {
				{ 1,  6901 }, -- Glowing Thresher Cape
				{ 2,  6904 }, -- Bite of Serra'kis
				{ 4,  6902 }, -- Bands of Serra'kis
			},
		},
		{ -- BFDAkumai
			name = AL["Aku'mai"],
			npcID = 213334,
			Level = GetForVersion(28,24),
			DisplayIDs = {{2837}},
			AtlasMapFile = {"CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt"},
			[SOD_DIFF] = {
				{ 1,  209693 }, -- Perfect Blackfathom Pearl
				{ 2,  211452 }, -- Perfect Blackfathom Pearl
				{ 4,  209692 }, -- Sentinel Pauldrons
				{ 5,  211456 }, -- Dagger of Willing Sacrifice
				{ 6,  209685 }, -- Ancient Moss Cinch
				{ 7,  209688 }, -- Bael Modan Blunderbuss
				{ 8,  209687 }, -- Hydra Hide Cuirass
				{ 9,  209690 }, -- Shadowscale Coif
				{ 10,  209691 }, -- Vampiric Boot Knife
				{ 11,  209580 }, -- Gusting Wind
				{ 12,  209684 }, -- Soul Leech Pants
				{ 13,  209689 }, -- Crabshell Waders
				{ 14,  209534 }, -- Azshari Arbalest
				{ 15,  209562 }, -- Deadly Strike of the Hydra
				{ 16,  211505 }, -- Twilight Avenger's Helm
				{ 17,  211504 }, -- Twilight Avenger's Chain
				{ 18,  211506 }, -- Twilight Avenger's Boots
				{ 20,  211507 }, -- Twilight Elementalist's Cowl
				{ 21,  211509 }, -- Twilight Elementalist's Robe
				{ 22,  211508 }, -- Twilight Elementalist's Footpads
				{ 24,  211510 }, -- Twilight Slayer's Cowl
				{ 25,  211512 }, -- Twilight Slayer's Tunic 
				{ 26,  211511 }, -- Twilight Slayer's Footpads
				{ 28,  209683 }, -- Twilight Invoker's Shawl
				{ 29,  209671 }, -- Twilight Invoker's Robes
				{ 30,  209669 }, -- Twilight Invoker's Shoes
			},
			[NORMAL_DIFF] = {
				{ 1,  6911 }, -- Moss Cinch
				{ 2,  6910 }, -- Leech Pants
				{ 3,  6909 }, -- Strike of the Hydra
			},
		},
		{ -- BFDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  1486 }, -- Tree Bark Jacket
				{ 2,  3416 }, -- Martyr's Chain
				{ 3,  1491 }, -- Ring of Precision
				{ 4,  3414 }, -- Crested Scepter
				{ 5,  1454 }, -- Axe of the Enforcer
				{ 6,  1481 }, -- Grimclaw
				{ 7,  2567 }, -- Evocator's Blade
				{ 8,  3413 }, -- Doomspike
				{ 9,  3417 }, -- Onyx Claymore
				{ 10, 3415 }, -- Staff of the Friar
				{ 11, 2271 }, -- Staff of the Blessed Seer
			},
		},
	},
}

data["Gnomeregan2"] = {
	MapID = 721,
	InstanceID = 90,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Gnomeregan",
	AtlasMapFile = {"CL_Gnomeregan", "CL_GnomereganEnt"},
	AtlasMapFile_AL = {"Gnomeregan", "GnomereganEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = {40,40,50},
	items = {
		{ -- Grubbis
			name = AL["Grubbis"],
			npcID = 217280,
			Level = 40,
			DisplayIDs = {{117047}},
			[SOD_DIFF] = {
				{ 1,  213288 }, -- Grubbis Grubby Gauntlets
				{ 2,  213304 }, -- Troggslayer Pauldrons
				{ 3,  213321 }, -- Volatile Concoction Belt
				{ 4,  213294 }, -- Caverndeep Sabatons
				{ 5,  213327 }, -- Belt of the Trogg Berserker
				{ 6,  213322 }, -- Skullduggery Waistband
				{ 7,  213351 }, -- Irradiated Tower Shield
				{ 8,  213542 }, -- The Necro-Gnomicon
				{ 9,  213323 }, -- Cord of Deep Earth
				{ 10,  215435 }, -- Libram of Benediction
				{ 11,  213324 }, -- Electromagnetic Waistcord
				{ 12,  213326 }, -- Girdle of Reclamation
				{ 13,  215436 }, -- Totem of Invigorating Flame
				{ 14,  215437 }, -- Trogg Transfigurator 3000
				{ 15,  216490 }, -- Idol of Wrath
			},
			[NORMAL_DIFF] = {
				{ 1,  9445 }, -- Grubbis Paws
			},
		},
		{ -- GnViscousFallout
			name = AL["Viscous Fallout"],
			npcID = 220007,
			Level = GetForVersion(32,28),
			DisplayIDs = {{5497}},
			[SOD_DIFF] = {
				{ 1,  213307 }, -- Drape of Dismantling
				{ 2,  213355 }, -- Falco's Sting
				{ 3,  213352 }, -- Gear-Mender's Grace
				{ 4,  213289 }, -- Hydrostaff
				{ 5,  213285 }, -- Lev's Oil-Stained Bindings
				{ 6,  213301 }, -- Synthetic Mantle
				{ 7,  213302 }, -- Mantle of the Cunning Negotiator
				{ 8,  213299 }, -- Petrolspill Pants
				{ 9,  213413 }, -- Generously Padded Shoulderpads
				{ 10,  213290 }, -- Acidic Waders
				{ 11,  213291 }, -- Toxic Revenger II
				{ 12,  213353 }, -- Defibrillating Staff
			},
			[NORMAL_DIFF] = {
				{ 1,  9454 }, -- Acidic Walkers
				{ 2,  9453 }, -- Toxic Revenger
				{ 3,  9452 }, -- Hydrocane
			},
		},
		{ -- GnElectrocutioner6000
			name = AL["Electrocutioner 6000"],
			npcID = 220072,
			Level = GetForVersion(30,28),
			DisplayIDs = {{118007}},
			[SOD_DIFF] = {
				{ 1,  213319 }, -- Machinist's Gloves
				{ 2,  213300 }, -- Fighter Ace Gloves
				{ 3,  213309 }, -- Cloak of Invention
				{ 4,  213287 }, -- Electrocutioner Hexnut
				{ 5,  213560 }, -- Mechanostrider Muffler
				{ 6,  213298 }, -- Mechbuilder's Overalls
				{ 7,  213293}, -- Hi-tech Supergun Mk.VII
				{ 8,  213559 }, -- Mechanostrider Gear Shifter
				{ 9,  216494}, -- Aragriar's Whimsical World Warper
				{ 10,  213354 }, -- Staff of the Evil Genius
				{ 11,  213414 }, -- Mech-Mender's Sash
				{ 12,  213418 }, -- Welded Truesilver Ringlets
				{ 13,  213279 }, -- Reflective Skullcap
				{ 16,  215377 }, -- Irradiated Robe
				{ 17,  215379 }, -- Irradiated Trousers
				{ 18,  215378 }, -- Irradiated Boots
				{ 20,  213286 }, -- Electrocutioner's Needle
				{ 22,  217008 }, -- Power Depleted Chest
				{ 23,  217009 }, -- Power Depleted Legs
				{ 24,  217007 }, -- Power Depleted Boots
			},
			[NORMAL_DIFF] = {
				{ 1,  9447 }, -- Electrocutioner Lagnut
				{ 2,  9446 }, -- Electrocutioner Leg
				{ 4,  9448 }, -- Spidertank Oilrag
				{ 6,  6893 }, -- Workshop Key
			},
		},
		{ -- GnCrowdPummeler960
			name = AL["Crowd Pummeler 9-60"],
			npcID = 215728,
			Level = GetForVersion(32,28),
			DisplayIDs = {{6774}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  213295 }, -- Ultrasonic Vibroblade
				{ 2,  213419 }, -- 9-60 Repair Manual
				{ 3,  213408 }, -- Gyromatic Macro-Adjustor
				{ 4,  213278 }, -- Bonk-Maestro's Handguards
				{ 5,  213442 }, -- Cogmaster's Claw
				{ 6,  213317 }, -- Experimental Aim Stabilizers
				{ 7,  213292 }, -- Gizmotron Gigachopper
				{ 8,  213340 }, -- Gnomebot Operators Boots
				{ 9,  213415 }, -- Tinker's Wrist Wraps
				{ 10,  213305 }, -- Machined Alloy Shoulderplates
				{ 11,  210741 }, -- Automatic Crowd Pummeler
				{ 13,  215449 }, -- World Shrinker
				{ 14,  213412 }, -- Dielectric Safety Shield
			},
			[NORMAL_DIFF] = {
				{ 1,  9449 }, -- Manual Crowd Pummeler
				{ 3,  9450 }, -- Gnomebot Operating Boots
			},
		},
		{ -- GnDIAmbassador
			name = AL["Dark Iron Ambassador"],
			npcID = 6228,
			Level = GetForVersion(33,28),
			DisplayIDs = {{6669}},
			AtlasMapBossID = 7,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Unavailable in SoD"], nil },
			},
			[NORMAL_DIFF] = {
				{ 1,  9455 }, -- Emissary Cuffs
				{ 2,  9456 }, -- Glass Shooter
				{ 3,  9457 }, -- Royal Diplomatic Scepter
			},
		},
		{ -- GnMechanicalMenagerie
			name = AL["The Mechanical Menagerie"],
			npcID = 218242,
			Level = GetForVersion(33,28),
			DisplayIDs = {{117365}},
			[SOD_DIFF] = {
				{ 1,  213296 }, -- Supercharged Headchopper
				{ 2,  213297 }, -- Oscillating Blasthammer
				{ 3,  213306 }, -- Ingenuity's Cover
				{ 4,  213325 }, -- Darkvision Girdle
				{ 5,  213411 }, -- Izzleflick's Inextinguishable Igniter
				{ 6,  213280 }, -- Marksman's Scopevisor
				{ 7,  213318 }, -- Ornate Dark Iron Bangles
				{ 8,  213320 }, -- Fingers of Arcane Accuracy
				{ 9,  213308 }, -- Prototype Parachute Cloak
				{ 10,  213417 }, -- Truesilver Filament Coif
				{ 11,  213303 }, -- Lightning Rod Spaulders
				{ 13,  215378 }, -- Irradiated Boots
				{ 14,  215379 }, -- Irradiated Trousers
				{ 15,  215377 }, -- Irradiated Robe
				{ 16,  215380 }, -- Power-Assisted Lifting Belt
				{ 17,  213410 }, -- Glimmering Gizmoblade
				{ 19,  217008 }, -- Power Depleted Chest
				{ 20,  217009 }, -- Power Depleted Legs	
				{ 21,  217007 }, -- Power Depleted Boots		
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Unavailable in Classic"], nil },
			},
		},
		{ -- GnMekgineerThermaplugg
			name = AL["Mekgineer Thermaplugg"],
			npcID = 218537,
			Level = GetForVersion(34,28),
			DisplayIDs = {{117499}},
			[SOD_DIFF] = {
				{ 1,  217350 }, -- Thermaplugg's Engineering Notes
				{ 2,  217351 }, -- Thermaplugg's Engineering Notes
				{ 4,  213281 }, -- Electromagnetic Hyperflux Reactivator
				{ 5,  213348 }, -- Gyromatic Experiment 420b
				{ 6,  213349 }, -- Gniodine Pill Bottle
				{ 7,  213350 }, -- Wirdal's Hardened Core
				{ 8,  213347 }, -- Miniaturized Combustion Chamber
				{ 9,  215461 }, -- Domesticated Attack Chicken
				{ 11,  215379 }, -- Irradiated Trousers
				{ 12,  215377 }, -- Irradiated Robe
				{ 13,  215378 }, -- Irradiated Boots
				{ 16,  213283 }, -- Hypercharged Gear of Conflagration
				{ 17,  213284 }, -- Hypercharged Gear of Devastation
				{ 18,  213282 }, -- Hypercharged Gear of Innovation
				{ 20,  213356 }, -- Thermaplugg's Custom Blaster
				{ 21,  213409 }, -- Mekgatorque's Arcano-Shredder
				{ 22,  213416 }, -- Thermaplugg's Rocket Cleaver
				{ 24,  216608 }, -- Radiant Ray Reflectors
				{ 25,  13325 }, -- Fluorescent Green Mechanostrider
				{ 27,  217008 }, -- Power Depleted Chest
				{ 28,  217009 }, -- Power Depleted Legs
				{ 29,  217007 }, -- Power Depleted Boots
			},
			[NORMAL_DIFF] = {
				{ 1,  9492 }, -- Electromagnetic Gigaflux Reactivator
				{ 2,  9461 }, -- Charged Gear
				{ 3,  9458 }, -- Thermaplugg's Central Core
				{ 4,  9459 }, -- Thermaplugg's Left Arm
				{ 16, 4415 }, -- Schematic: Craftsman's Monocle
				--{ 17, 4393 }, -- Craftsman's Monocle
				{ 17, 4413 }, -- Schematic: Discombobulator Ray
				--{ 20, 4388 }, -- Discombobulator Ray
				{ 18, 4411 }, -- Schematic: Flame Deflector
				--{ 23, 4376 }, -- Flame Deflector
				{ 19, 7742 }, -- Schematic: Gnomish Cloaking Device
				--{ 26, 4397 }, -- Gnomish Cloaking Device
				{ 20, 11828 }, -- Schematic: Pet Bombling
				--{ 29, 11825 }, -- Pet Bombling
			},
		},
		{ -- GnTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  9508 }, -- Mechbuilder's Overalls
				{ 2,  9491 }, -- Hotshot Pilot's Gloves
				{ 3,  9509 }, -- Petrolspill Leggings
				{ 4,  9510 }, -- Caverndeep Trudgers
				{ 5,  9487 }, -- Hi-tech Supergun
				{ 6,  9485 }, -- Vibroblade
				{ 7,  9488 }, -- Oscillating Power Hammer
				{ 8,  9486 }, -- Supercharger Battle Axe
				{ 9,  9490 }, -- Gizmotron Megachopper
				{ 11, 9489 }, -- Gyromatic Icemaker
				{ 12, 11827 }, -- Schematic: Lil' Smoky
				--{ 15, 11826 }, -- Lil' Smoky
				{ 16, 9327 }, -- Security DELTA Data Access Card
				{ 18, 7191 }, -- Fused Wiring
				{ 19, 9308 }, -- Grime-Encrusted Object
				{ 20, 9326 }, -- Grime-Encrusted Ring
				{ 22, 9279 }, -- White Punch Card
				{ 23, 9280 }, -- Yellow Punch Card
				{ 24, 9282 }, -- Blue Punch Card
				{ 25, 9281 }, -- Red Punch Card
				{ 26, 9316 }, -- Prismatic Punch Card
				{ 29, 213427 }, -- Grime-Encrusted Salvage
			},
			[NORMAL_DIFF] = {
				{ 1,  9508 }, -- Mechbuilder's Overalls
				{ 2,  9491 }, -- Hotshot Pilot's Gloves
				{ 3,  9509 }, -- Petrolspill Leggings
				{ 4,  9510 }, -- Caverndeep Trudgers
				{ 5,  9487 }, -- Hi-tech Supergun
				{ 6,  9485 }, -- Vibroblade
				{ 7,  9488 }, -- Oscillating Power Hammer
				{ 8,  9486 }, -- Supercharger Battle Axe
				{ 9,  9490 }, -- Gizmotron Megachopper
				{ 11, 9489 }, -- Gyromatic Icemaker
				{ 12, 11827 }, -- Schematic: Lil' Smoky
				--{ 15, 11826 }, -- Lil' Smoky
				{ 16, 9327 }, -- Security DELTA Data Access Card
				{ 18, 7191 }, -- Fused Wiring
				{ 19, 9308 }, -- Grime-Encrusted Object
				{ 20, 9326 }, -- Grime-Encrusted Ring
				{ 22, 9279 }, -- White Punch Card
				{ 23, 9280 }, -- Yellow Punch Card
				{ 24, 9282 }, -- Blue Punch Card
				{ 25, 9281 }, -- Red Punch Card
				{ 26, 9316 }, -- Prismatic Punch Card
			},
		},
	},
}

data["RazorfenKraul"] = {
	MapID = 491,
	InstanceID = 47,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "RazorfenKraul",
	AtlasMapFile = "CL_RazorfenKraul",
	AtlasMapFile_AL = "RazorfenKraul",
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({25, 29, 38},{17, 24, 27}),
	items = {
		{ -- RFKAggem
			name = AL["Aggem Thorncurse"],
			npcID = 4424,
			Level = GetForVersion(30,26),
			DisplayIDs = {{6097}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  6681 }, -- Thornspike
			},
		},
		{ -- RFKDeathSpeakerJargba
			name = AL["Death Speaker Jargba"],
			npcID = 4428,
			Level = GetForVersion(30,27),
			DisplayIDs = {{4644}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  2816 }, -- Death Speaker Scepter
				{ 3,  6685 }, -- Death Speaker Mantle
				{ 4,  6682 }, -- Death Speaker Robes
			},
		},
		{ -- RFKOverlordRamtusk
			name = AL["Overlord Ramtusk"],
			npcID = 4420,
			Level = GetForVersion(32,27),
			DisplayIDs = {{4652}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  6687 }, -- Corpsemaker
				{ 3,  6686 }, -- Tusken Helm
			},
		},
		{ -- RFKRazorfenSpearhide
			name = AL["Razorfen Spearhide"],
			npcID = 4438,
			Level = GetForVersion({29, 30},27),
			DisplayIDs = {{6078}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  6679 }, -- Armor Piercer
			},
		},
		{ -- RFKAgathelos
			name = AL["Agathelos the Raging"],
			npcID = 4422,
			Level = GetForVersion(33,27),
			DisplayIDs = {{2450}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6691 }, -- Swinetusk Shank
				{ 3,  6690 }, -- Ferine Leggings
			},
		},
		{ -- RFKBlindHunter
			name = AL["Blind Hunter"],
			npcID = 4425,
			Level = GetForVersion(32,27),
			DisplayIDs = {{4735}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  6695 }, -- Stygian Bone Amulet
				{ 2,  6697 }, -- Batwing Mantle
				{ 3,  6696 }, -- Nightstalker Bow
			},
		},
		{ -- RFKCharlgaRazorflank
			name = AL["Charlga Razorflank"],
			npcID = 4421,
			Level = GetForVersion(33,27),
			DisplayIDs = {{4642}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  6693 }, -- Agamaggan's Clutch
				{ 2,  6694 }, -- Heart of Agamaggan
				{ 3,  6692 }, -- Pronged Reaver
				{ 16,  17008 }, -- Small Scroll
			},
		},
		{ -- RFKEarthcallerHalmgar
			name = AL["Earthcaller Halmgar"],
			npcID = 4842,
			Level = GetForVersion(32,27),
			DisplayIDs = {{6102}},
			AtlasMapBossID = 9,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  6689 }, -- Wind Spirit Staff
				{ 3,  6688 }, -- Whisperwind Headdress
			},
		},
		{ -- RFKTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  2264 }, -- Mantle of Thieves
				{ 2,  1488 }, -- Avenger's Armor
				{ 3,  4438 }, -- Pugilist Bracers
				{ 4,  1978 }, -- Wolfclaw Gloves
				{ 5,  2039 }, -- Plains Ring
				{ 6,  1727 }, -- Sword of Decay
				{ 7,  776 }, -- Vendetta
				{ 8,  1976 }, -- Slaghammer
				{ 9,  1975 }, -- Pysan's Old Greatsword
				{ 10, 2549 }, -- Staff of the Shade
			},
		},
	},
}

data["ScarletMonasteryGraveyard"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21379, 24000, 23805 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Graveyard"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"CL_SMGraveyard", "CL_ScarletMonasteryEnt"},
	AtlasMapFile_AL = {"SMGraveyard", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({20, 26, 36},{20, 30, 32}),
	items = {
		-- Graveyard
				{ -- SMVishas
			name = AL["Interrogator Vishas"],
			npcID = 3983,
			Level = 32,
			DisplayIDs = {{2044}},
			SubAreaID = 21379,
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  7682 }, -- Torturing Poker
				{ 3,  7683 }, -- Bloody Brass Knuckles
			},
			[NORMAL_DIFF] = {
				{ 1,  7682 }, -- Torturing Poker
				{ 3,  7683 }, -- Bloody Brass Knuckles
			},
		},
		{ -- SMAzshir
			name = AL["Azshir the Sleepless"],
			npcID = 6490,
			Level = GetForVersion(33,32),
			DisplayIDs = {{5534}},
			SubAreaID = 24000,
			AtlasMapBossID = "1'",
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1,  7709 }, -- Blighted Leggings
				{ 2, 217295 }, -- Necrotic Wand
				{ 3, 217296 }, -- Ghostshard Talisman
			},
			[NORMAL_DIFF] = {
				{ 1,  7709 }, -- Blighted Leggings
				{ 2,  7708 }, -- Necrotic Wand
				{ 3,  7731 }, -- Ghostshard Talisman
			},
		},
		{ -- SMFallenChampion
			name = AL["Fallen Champion"],
			npcID = 6488,
			Level = GetForVersion(33,32),
			DisplayIDs = {{5230}},
			specialType = "rare",
			AtlasMapBossID = "1'",
			[SOD_DIFF] = {
				{ 1, 217294 }, -- Embalmed Shroud
				{ 2,  7690 }, -- Ebon Vise
				{ 3,  7689 }, -- Morbid Dawn
			},
			[NORMAL_DIFF] = {
				{ 1,  7691 }, -- Embalmed Shroud
				{ 2,  7690 }, -- Ebon Vise
				{ 3,  7689 }, -- Morbid Dawn
			},
		},
		{ -- SMIronspine
			name = AL["Ironspine"],
			npcID = 6489,
			Level = GetForVersion(33,32),
			DisplayIDs = {{5231}},
			AtlasMapBossID = "1'",
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1,  7688 }, -- Ironspine's Ribcage
				{ 2,  7687 }, -- Ironspine's Fist
				{ 3,  7686 }, -- Ironspine's Eye
			},
			[NORMAL_DIFF] = {
				{ 1,  7688 }, -- Ironspine's Ribcage
				{ 2,  7687 }, -- Ironspine's Fist
				{ 3,  7686 }, -- Ironspine's Eye
			},
		},
		{ -- SMBloodmageThalnos
			name = AL["Bloodmage Thalnos"],
			npcID = 4543,
			Level = GetForVersion(33,32),
			SubAreaID = 23805,
			DisplayIDs = {{11396}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1,  7685 }, -- Orb of the Forgotten Seer
				{ 3,  7684 }, -- Bloodmage Mantle
			},
			[NORMAL_DIFF] = {
				{ 1,  7685 }, -- Orb of the Forgotten Seer
				{ 3,  7684 }, -- Bloodmage Mantle
			},
		},
		{ -- SMGTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7727 }, -- Watchman Pauldrons
				{ 3,  7728 }, -- Beguiler Robes
				{ 4,  7754 }, -- Harbinger Boots
				{ 5,  10332 }, -- Scarlet Boots
				{ 6,  2262 }, -- Mark of Kern
				{ 7,  7787 }, -- Resplendent Guardian
				{ 8,  7729 }, -- Chesterfall Musket
				{ 9,  7761 }, -- Steelclaw Reaver
				{ 10, 7752 }, -- Dreamslayer
				{ 11, 8226 }, -- The Butcher
				{ 12, 7786 }, -- Headsplitter
				{ 13, 7753 }, -- Bloodspiller
				{ 14, 7730 }, -- Cobalt Crusher
			},
		},
		{ -- SMScorn
			name = AL["Scorn"],
			npcID = 14693,
			DisplayIDs = {{16197}},
			AtlasMapBossID = 1,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23169 }, -- Scorn's Icy Choker
				{ 2, 23170 }, -- The Frozen Clutch
				{ 3, 23168 }, -- Scorn's Focal Dagger
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, { -- SMHeadlessHorseman
			name = AL["Headless Horseman"],
			npcID = 23682,
			Level = 83,
			DisplayIDs = {{22351}},
			AtlasMapBossID = nil,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 211817 }, -- Ring of Ghoulish Glee
				{ 2, 211844 }, -- The Horseman's Seal
				{ 3, 211847 }, -- Wicked Witch's Band
				{ 5, 211850 }, -- The Horseman's Horrific Helm
				{ 6, 211851 }, -- The Horseman's Baleful Blade
				{ 8, 33292 }, -- Hallowed Helm
				{ 10, 34068 }, -- Weighted Jack-o'-Lantern
				{ 12, 33277 }, -- Tome of Thomas Thomson
				{ 16, 37012 }, -- The Horseman's Reins
				{ 18, 33182 }, -- Swift Flying Broom        280% flying
				{ 19, 33176 }, -- Flying Broom              60% flying
				{ 21, 33184 }, -- Swift Magic Broom         100% ground
				{ 22, 37011 }, -- Magic Broom               60% ground
				{ 24, 33154 }, -- Sinister Squashling
			}
		}),
		KEYS,
	},
}

data["ScarletMonasteryLibrary"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21426, 21444, 21420 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Library"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"CL_SMLibrary", "CL_ScarletMonasteryEnt"},
	AtlasMapFile_AL = {"SMLibrary", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({20, 29, 39},{20, 33, 35}),
	items = {
		-- Library
			{ -- SMHoundmasterLoksey
		name = AL["Houndmaster Loksey"],
		npcID = 3974,
		Level = 34,
		SubAreaID = 21444,
		DisplayIDs = {{2040}},
		AtlasMapBossID = 1,
		[SOD_DIFF] = {
			{ 1,  7710 }, -- Loksey's Training Stick
			{ 3,  7756 }, -- Dog Training Gloves
			{ 4,  3456 }, -- Dog Whistle
		},
		[NORMAL_DIFF] = {
			{ 1,  7710 }, -- Loksey's Training Stick
			{ 3,  7756 }, -- Dog Training Gloves
			{ 4,  3456 }, -- Dog Whistle
		},
	},
	{ -- SMDoan
		name = AL["Arcanist Doan"],
		npcID = 6487,
		Level = GetForVersion(37,34),
		SubAreaID = 21420,
		DisplayIDs = {{5266}},
		AtlasMapBossID = 2,
		[SOD_DIFF] = {
			{ 1,  7714 }, -- Hypnotic Blade
			{ 2, 217299 }, -- Illusionary Rod
			{ 4, 217298 }, -- Mantle of Doan
			{ 5, 217297 }, -- Robe of Doan
		},
		[NORMAL_DIFF] = {
			{ 1,  7714 }, -- Hypnotic Blade
			{ 2,  7713 }, -- Illusionary Rod
			{ 4,  7712 }, -- Mantle of Doan
			{ 5,  7711 }, -- Robe of Doan
			AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 22,  34227 }), -- Deadman's Hand
		},
	},
	{ -- SMLTrash
		name = AL["Trash"],
		ExtraList = true,
		[SOD_DIFF] = {
			{ 1,  5819 }, -- Sunblaze Coif
			{ 2,  7755 }, -- Flintrock Shoulders
			{ 3,  7727 }, -- Watchman Pauldrons
			{ 4,  7728 }, -- Beguiler Robes
			{ 5,  7759 }, -- Archon Chestpiece
			{ 6,  7760 }, -- Warchief Kilt
			{ 7,  7754 }, -- Harbinger Boots
			{ 8, 10332 }, -- Scarlet Boots
			{ 9,  1992 }, -- Swampchill Fetish
			{ 10, 2262 }, -- Mark of Kern
			{ 11, 7787 }, -- Resplendent Guardian
			{ 12, 7729 }, -- Chesterfall Musket
			{ 13, 7761 }, -- Steelclaw Reaver
			{ 14, 7752 }, -- Dreamslayer
			{ 15, 8226 }, -- The Butcher
			{ 16, 7786 }, -- Headsplitter
			{ 17, 5756 }, -- Sliverblade
			{ 18, 7736 }, -- Fight Club
			{ 19, 8225 }, -- Tainted Pierce
			{ 20, 7753 }, -- Bloodspiller
			{ 21, 7730 }, -- Cobalt Crusher
			{ 22, 7758 }, -- Ruthless Shiv
			{ 23, 7757 }, -- Windweaver Staff
		},
		[NORMAL_DIFF] = {
			{ 1,  5819 }, -- Sunblaze Coif
			{ 2,  7755 }, -- Flintrock Shoulders
			{ 3,  7727 }, -- Watchman Pauldrons
			{ 4,  7728 }, -- Beguiler Robes
			{ 5,  7759 }, -- Archon Chestpiece
			{ 6,  7760 }, -- Warchief Kilt
			{ 7,  7754 }, -- Harbinger Boots
			{ 8, 10332 }, -- Scarlet Boots
			{ 9,  1992 }, -- Swampchill Fetish
			{ 10, 2262 }, -- Mark of Kern
			{ 11, 7787 }, -- Resplendent Guardian
			{ 12, 7729 }, -- Chesterfall Musket
			{ 13, 7761 }, -- Steelclaw Reaver
			{ 14, 7752 }, -- Dreamslayer
			{ 15, 8226 }, -- The Butcher
			{ 16, 7786 }, -- Headsplitter
			{ 17, 5756 }, -- Sliverblade
			{ 18, 7736 }, -- Fight Club
			{ 19, 8225 }, -- Tainted Pierce
			{ 20, 7753 }, -- Bloodspiller
			{ 21, 7730 }, -- Cobalt Crusher
			{ 22, 7758 }, -- Ruthless Shiv
			{ 23, 7757 }, -- Windweaver Staff
		},
	},
		{
			name = AL["Doan's Strongbox"],
			ExtraList = true,
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1,  7146 }, -- The Scarlet Key
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryArmory"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21460, 21455, 21448, 21457 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Armory"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"CL_SMArmory", "CL_ScarletMonasteryEnt"},
	AtlasMapFile_AL = {"SMArmory", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({20, 32, 42},{20, 35, 37}),
	items = {
		-- Armory
		{ -- SMHerod
			name = AL["Herod"],
			npcID = 3975,
			Level = GetForVersion(40,37),
			SubAreaID = 21448,
			DisplayIDs = {{2041}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7719 }, -- Raging Berserker's Helm
				{ 2,  7718 }, -- Herod's Shoulder
				{ 3,  10330 }, -- Scarlet Leggings
				{ 4,  7717 }, -- Ravager
			},
		},
		{ -- SMATrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7754 }, -- Harbinger Boots
				{ 7,  10332 }, -- Scarlet Boots
				{ 8,  1992 }, -- Swampchill Fetish
				{ 9,  2262 }, -- Mark of Kern
				{ 10, 7787 }, -- Resplendent Guardian
				{ 11, 7729 }, -- Chesterfall Musket
				{ 12, 7761 }, -- Steelclaw Reaver
				{ 13, 7752 }, -- Dreamslayer
				{ 14, 8226 }, -- The Butcher
				{ 15, 7786 }, -- Headsplitter
				{ 16, 5756 }, -- Sliverblade
				{ 17, 7736 }, -- Fight Club
				{ 18, 8225 }, -- Tainted Pierce
				{ 19, 7753 }, -- Bloodspiller
				{ 20, 7730 }, -- Cobalt Crusher
				{ 21, 7757 }, -- Windweaver Staff
				{ 23, 10333 }, -- Scarlet Wristguards
				{ 24, 10329 }, -- Scarlet Belt
				{ 26, 23192 }, -- Tabard of the Scarlet Crusade
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryCathedral"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21401, 21410 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Cathedral"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"CL_SMCathedral", "CL_ScarletMonasteryEnt"},
	AtlasMapFile_AL = {"SMCathedral", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({20, 35, 45},{20, 36, 40}),
	items = {
		-- Cathedral
		{ -- SMFairbanks
			name = AL["High Inquisitor Fairbanks"],
			npcID = 4542,
			Level = 40,
			DisplayIDs = {{2605}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  19507 }, -- Inquisitor's Shawl
				{ 2,  19508 }, -- Branded Leather Bracers
				{ 3,  19509 }, -- Dusty Mail Boots
			},
			[NORMAL_DIFF] = {
				{ 1,  19507 }, -- Inquisitor's Shawl
				{ 2,  19508 }, -- Branded Leather Bracers
				{ 3,  19509 }, -- Dusty Mail Boots
			},
		},
		{ -- SMMograine
			name = AL["Scarlet Commander Mograine"],
			npcID = 3976,
			Level = GetForVersion(42,40),
			DisplayIDs = {{2042}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1,  7724 }, -- Gauntlets of Divinity
				{ 2,  10330 }, -- Scarlet Leggings
				{ 3,  7726 }, -- Aegis of the Scarlet Commander
				{ 4, 217302 }, -- Mograine's Might
			},
			[NORMAL_DIFF] = {
				{ 1,  7724 }, -- Gauntlets of Divinity
				{ 2,  10330 }, -- Scarlet Leggings
				{ 3,  7726 }, -- Aegis of the Scarlet Commander
				{ 4,  7723 }, -- Mograine's Might
			},
		},
		{ -- SMWhitemane
			name = AL["High Inquisitor Whitemane"],
			npcID = 3977,
			Level = GetForVersion(42,40),
			DisplayIDs = {{2043}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 217300 }, -- Whitemane's Chapeau
				{ 2, 217301 }, -- Triune Amulet
				{ 3,  7721 }, -- Hand of Righteousness
			},
			[NORMAL_DIFF] = {
				{ 1,  7720 }, -- Whitemane's Chapeau
				{ 2,  7722 }, -- Triune Amulet
				{ 3,  7721 }, -- Hand of Righteousness
			},
		},
		{ -- SMCTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
				{ 25, 10328 }, -- Scarlet Chestpiece
				{ 26, 10331 }, -- Scarlet Gauntlets
				{ 27, 10329 }, -- Scarlet Belt
			},
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
				{ 25, 10328 }, -- Scarlet Chestpiece
				{ 26, 10331 }, -- Scarlet Gauntlets
				{ 27, 10329 }, -- Scarlet Belt
			},
		},
		KEYS,
	},
}

data["RazorfenDowns"] = {
	MapID = 722,
	InstanceID = 129,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "RazorfenDowns",
	AtlasMapFile = "CL_RazorfenDowns",
	AtlasMapFile_AL = "RazorfenDowns",
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({35, 37, 46},{25, 34, 37}),
	items = {
			{ -- RFDTutenkash
				name = AL["Tuten'kash"],
				npcID = 7355,
				Level = GetForVersion(40,37),
				DisplayIDs = {{7845}},
				AtlasMapBossID = 1,
				[SOD_DIFF] = {
					{ 1, 217293 }, -- Silky Spider Cape
					{ 2,  10775 }, -- Carapace of Tuten'kash
					{ 3,  10777 }, -- Arachnid Gloves
				},
				[NORMAL_DIFF] = {
					{ 1,  10776 }, -- Silky Spider Cape
					{ 2,  10775 }, -- Carapace of Tuten'kash
					{ 3,  10777 }, -- Arachnid Gloves
				},
			},
			{ -- RFDMordreshFireEye
				name = AL["Mordresh Fire Eye"],
				npcID = 7357,
				Level = GetForVersion(39,37),
				DisplayIDs = {{8055}},
				AtlasMapBossID = 3,
				[SOD_DIFF] = {
					{ 1, 217290 }, -- Glowing Eye of Mordresh
					{ 2, 217292 }, -- Deathmage Sash
					{ 3, 217291 }, -- Mordresh's Lifeless Skull
				},
				[NORMAL_DIFF] = {
					{ 1,  10769 }, -- Glowing Eye of Mordresh
					{ 2,  10771 }, -- Deathmage Sash
					{ 3,  10770 }, -- Mordresh's Lifeless Skull
				},
			},
			{ -- RFDGlutton
				name = AL["Glutton"],
				npcID = 8567,
				Level = GetForVersion(40,37),
				DisplayIDs = {{7864}},
				AtlasMapBossID = 4,
				[SOD_DIFF] = {
					{ 1,  10774 }, -- Fleshhide Shoulders
					{ 3,  10772 }, -- Glutton's Cleaver
				},
				[NORMAL_DIFF] = {
					{ 1,  10774 }, -- Fleshhide Shoulders
					{ 3,  10772 }, -- Glutton's Cleaver
				},
			},
			{ -- RFDRagglesnout
				name = AL["Ragglesnout"],
				npcID = 7354,
				Level = GetForVersion(40,37),
				DisplayIDs = {{11382}},
				AtlasMapBossID = 5,
				specialType = "rare",
				[SOD_DIFF] = {
					{ 1,  10768 }, -- Boar Champion's Belt
					{ 2,  10767 }, -- Savage Boar's Guard
					{ 3,  10758 }, -- X'caliboar
				},
				[NORMAL_DIFF] = {
					{ 1,  10768 }, -- Boar Champion's Belt
					{ 2,  10767 }, -- Savage Boar's Guard
					{ 3,  10758 }, -- X'caliboar
				},
			},
			{ -- RFDAmnennar
				name = AL["Amnennar the Coldbringer"],
				npcID = 7358,
				Level = GetForVersion(41,37),
				DisplayIDs = {{7971}},
				AtlasMapBossID = 6,
				[SOD_DIFF] = {
					{ 1,  10763 }, -- Icemetal Barbute
					{ 2, 217288 }, -- Robes of the Lich
					{ 3, 217289 }, -- Deathchill Armor
					{ 4,  10761 }, -- Coldrage Dagger
					{ 6,  10765 }, -- Bonefingers
				},
				[NORMAL_DIFF] = {
					{ 1,  10763 }, -- Icemetal Barbute
					{ 2,  10762 }, -- Robes of the Lich
					{ 3,  10764 }, -- Deathchill Armor
					{ 4,  10761 }, -- Coldrage Dagger
					{ 6,  10765 }, -- Bonefingers
				},
			},
			{ -- RFDPlaguemaw
				name = AL["Plaguemaw the Rotting"],
				npcID = 7356,
				Level = GetForVersion(40,37),
				DisplayIDs = {{6124}},
				AtlasMapBossID = 7,
				[SOD_DIFF] = {
					{ 1,  10766 }, -- Plaguerot Sprig
					{ 3,  10760 }, -- Swine Fists
				},
				[NORMAL_DIFF] = {
					{ 1,  10766 }, -- Plaguerot Sprig
					{ 3,  10760 }, -- Swine Fists
				},
			},
			{ -- RFDTrash
				name = AL["Trash"],
				ExtraList = true,
				[SOD_DIFF] = {
					{ 1,  10574 }, -- Corpseshroud
					{ 2,  10581 }, -- Death's Head Vestment
					{ 3,  10583 }, -- Quillward Harness
					{ 4,  10584 }, -- Stormgale Fists
					{ 5,  10578 }, -- Thoughtcast Boots
					{ 6,  10582 }, -- Briar Tredders
					{ 7,  10572 }, -- Freezing Shard
					{ 8,  10567 }, -- Quillshooter
					{ 9,  10571 }, -- Ebony Boneclub
					{ 10, 10570 }, -- Manslayer
					{ 11, 10573 }, -- Boneslasher
				},
				[NORMAL_DIFF] = {
					{ 1,  10574 }, -- Corpseshroud
					{ 2,  10581 }, -- Death's Head Vestment
					{ 3,  10583 }, -- Quillward Harness
					{ 4,  10584 }, -- Stormgale Fists
					{ 5,  10578 }, -- Thoughtcast Boots
					{ 6,  10582 }, -- Briar Tredders
					{ 7,  10572 }, -- Freezing Shard
					{ 8,  10567 }, -- Quillshooter
					{ 9,  10571 }, -- Ebony Boneclub
					{ 10, 10570 }, -- Manslayer
					{ 11, 10573 }, -- Boneslasher
				},
			},

		{ -- RFDLadyF
			name = AL["Lady Falther'ess"],
			npcID = 14686,
			DisplayIDs = {{10698}},
			AtlasMapBossID = 2,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  23178 }, -- Mantle of Lady Falther'ess
				{ 2,  23177 }, -- Lady Falther'ess' Finger
			},
		},
		{ -- RFDHenryStern
			name = AL["Henry Stern"],
			npcID = 8696,
			DisplayIDs = {{8029}},
			AtlasMapBossID = 2,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  3826 }, -- Mighty Troll's Blood Potion
				{ 2,  10841 }, -- Goldthorn Tea
			},
		},
	},
}

data["Uldaman"] = {
	MapID = 1337, -- just no...
	InstanceID = 70,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Uldaman",
	ContentType = DUNGEON_CONTENT,
	AtlasMapFile = {"CL_Uldaman", "CL_UldamanEnt"},
	AtlasMapFile_AL = {"Uldaman", "UldamanEnt"},
	LevelRange = GetForVersion({30, 41, 51},{30, 36, 40}),
	items = {
		{ -- UldEric
			name = AL["Eric \"The Swift\""],
			npcID = 6907,
			Level = GetForVersion(40,39),
			DisplayIDs = {{5708}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  9394 }, -- Horned Viking Helmet
				{ 3,  9398 }, -- Worn Running Boots
				{ 5,  2459 }, -- Swiftness Potion
			},
			[NORMAL_DIFF] = {
				{ 1,  9394 }, -- Horned Viking Helmet
				{ 3,  9398 }, -- Worn Running Boots
				{ 5,  2459 }, -- Swiftness Potion
			},
		},
		{ -- UldBaelog
			name = AL["Baelog"],
			npcID = 6906,
			Level = GetForVersion(41,39),
			DisplayIDs = {{5710}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  9401 }, -- Nordic Longshank
				{ 3,  9399 }, -- Precision Arrow
				{ 5,  9400 }, -- Baelog's Shortbow
			},
			[NORMAL_DIFF] = {
				{ 1,  9401 }, -- Nordic Longshank
				{ 3,  9399 }, -- Precision Arrow
				{ 5,  9400 }, -- Baelog's Shortbow
			},
		},
		{ -- UldOlaf
			name = AL["Olaf"],
			npcID = 6908,
			Level = GetForVersion(40,39),
			DisplayIDs = {{5709}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  9404 }, -- Olaf's All Purpose Shield
				{ 3,  9403 }, -- Battered Viking Shield
				{ 4,  1177 }, -- Oil of Olaf
			},
			[NORMAL_DIFF] = {
				{ 1,  9404 }, -- Olaf's All Purpose Shield
				{ 3,  9403 }, -- Battered Viking Shield
				{ 4,  1177 }, -- Oil of Olaf
			},
		},
		{ -- UldRevelosh
			name = AL["Revelosh"],
			npcID = 6910,
			Level = GetForVersion(40,39),
			DisplayIDs = {{5945}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 217304 }, -- Revelosh's Gloves
				{ 2, 217307 }, -- Revelosh's Spaulders
				{ 3, 217305 }, -- Revelosh's Armguards
				{ 4, 217306 }, -- Revelosh's Boots
				{ 6,  7741 }, -- The Shaft of Tsol
			},
			[NORMAL_DIFF] = {
				{ 1,  9389 }, -- Revelosh's Spaulders
				{ 2,  9388 }, -- Revelosh's Armguards
				{ 3,  9390 }, -- Revelosh's Gloves
				{ 4,  9387 }, -- Revelosh's Boots
				{ 6,  7741 }, -- The Shaft of Tsol
			},
		},
		{ -- UldIronaya
			name = AL["Ironaya"],
			npcID = 7228,
			Level = GetForVersion(40,39),
			DisplayIDs = {{6089}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1,  9409 }, -- Ironaya's Bracers
				{ 2, 217303 }, -- Stoneweaver Leggings
				{ 3,  9408 }, -- Ironshod Bludgeon
			},
			[NORMAL_DIFF] = {
				{ 1,  9409 }, -- Ironaya's Bracers
				{ 2,  9407 }, -- Stoneweaver Leggings
				{ 3,  9408 }, -- Ironshod Bludgeon
			},
		},
		{ -- UldObsidianSentinel
			name = AL["Obsidian Sentinel"],
			npcID = 7023,
			Level = GetForVersion(42,40),
			DisplayIDs = {{5285}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1,  8053 }, -- Obsidian Power Source
			},
			[NORMAL_DIFF] = {
				{ 1,  8053 }, -- Obsidian Power Source
			},
		},
		{ -- UldAncientStoneKeeper
			name = AL["Ancient Stone Keeper"],
			npcID = 7206,
			Level = GetForVersion(44,40),
			DisplayIDs = {{10798}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1,  9410 }, -- Cragfists
				{ 3,  9411 }, -- Rockshard Pauldrons
			},
			[NORMAL_DIFF] = {
				{ 1,  9410 }, -- Cragfists
				{ 3,  9411 }, -- Rockshard Pauldrons
			},
		},
		{ -- UldGalgannFirehammer
			name = AL["Galgann Firehammer"],
			npcID = 7291,
			Level = GetForVersion(45,40),
			DisplayIDs = {{6059}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1,  11310 }, -- Flameseer Mantle
				{ 2,  9412 }, -- Galgann's Fireblaster
				{ 3,  11311 }, -- Emberscale Cape
				{ 4,  9419 }, -- Galgann's Firehammer
			},
			[NORMAL_DIFF] = {
				{ 1,  11310 }, -- Flameseer Mantle
				{ 2,  9412 }, -- Galgann's Fireblaster
				{ 3,  11311 }, -- Emberscale Cape
				{ 4,  9419 }, -- Galgann's Firehammer
			},
		},
		{ -- UldGrimlok
			name = AL["Grimlok"],
			npcID = 4854,
			Level = GetForVersion(45,40),
			DisplayIDs = {{11165}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1, 223535 }, -- Grimlok's Tribal Vestments
				{ 2, 223536 }, -- Grimlok's Charge
				{ 3,  9414 }, -- Oilskin Leggings
				{ 5, 7670 }, -- Shattered Necklace Sapphire
			},
			[NORMAL_DIFF] = {
				{ 1,  9415 }, -- Grimlok's Tribal Vestments
				{ 2,  9416 }, -- Grimlok's Charge
				{ 3,  9414 }, -- Oilskin Leggings
				{ 5, 7670 }, -- Shattered Necklace Sapphire
			},
		},
		{ -- UldArchaedas
			name = AL["Archaedas"],
			npcID = 2748,
			Level = GetForVersion(47,40),
			DisplayIDs = {{5988}},
			AtlasMapBossID = 10,
			[SOD_DIFF] = {
				{ 1,  11118 }, -- Archaedic Stone
				{ 2,  9413 }, -- The Rockpounder
				{ 3,  9418 }, -- Stoneslayer
			},
			[NORMAL_DIFF] = {
				{ 1,  11118 }, -- Archaedic Stone
				{ 2,  9413 }, -- The Rockpounder
				{ 3,  9418 }, -- Stoneslayer
			},
		},
		{ -- UldTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  9431 }, -- Papal Fez
				{ 2,  9429 }, -- Miner's Hat of the Deep
				{ 3,  9420 }, -- Adventurer's Pith Helmet
				{ 4,  9430 }, -- Spaulders of a Lost Age
				{ 5,  9397 }, -- Energy Cloak
				{ 6,  9406 }, -- Spirewind Fetter
				{ 7, 223537 }, -- Skullplate Bracers
				{ 16, 9381 }, -- Earthen Rod
			},
			[NORMAL_DIFF] = {
				{ 1,  9431 }, -- Papal Fez
				{ 2,  9429 }, -- Miner's Hat of the Deep
				{ 3,  9420 }, -- Adventurer's Pith Helmet
				{ 4,  9430 }, -- Spaulders of a Lost Age
				{ 5,  9397 }, -- Energy Cloak
				{ 6,  9406 }, -- Spirewind Fetter
				{ 16, 9381 }, -- Earthen Rod
			},
		},
		{ -- UldBaelogsChest
			name = AL["Baelog's Chest"],
			ExtraList = true,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7740 }, -- Gni'kiv Medallion
			},
		},
		{ -- UldConspicuousUrn
			name = AL["Conspicuous Urn"],
			ExtraList = true,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7671 }, -- Shattered Necklace Topaz
			},
		},
		{ -- UldShadowforgeCache
			name = AL["Shadowforge Cache"],
			ExtraList = true,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  7669 }, -- Shattered Necklace Ruby
			},
		},
		{ -- UldTabletofWill
			name = AL["Tablet of Will"],
			ExtraList = true,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  5824 }, -- Tablet of Will
			},
		},
	},
}

data["Zul'Farrak"] = {
	MapID = 1176,
	InstanceID = 209,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Zul'Farrak",
	AtlasMapFile = "CL_ZulFarrak",
	AtlasMapFile_AL = "ZulFarrak",
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({39, 44, 54},{35, 42, 46}),
	items = {
		{ -- ZFAntusul
	name = AL["Antu'sul"],
	npcID = 8127,
	Level = GetForVersion(48,46),
	DisplayIDs = {{7353}},
	AtlasMapBossID = 1,
	[SOD_DIFF] = {
		{ 1,  9640 }, -- Vice Grips
		{ 2,  223532 }, -- Lifeblood Amulet
		{ 3,  9639 }, -- The Hand of Antu'sul
		{ 5,  9379 }, -- Sang'thraze the Deflector
	},
	[NORMAL_DIFF] = {
		{ 1,  9640 }, -- Vice Grips
		{ 2,  9641 }, -- Lifeblood Amulet
		{ 3,  9639 }, -- The Hand of Antu'sul
		{ 5,  9379 }, -- Sang'thraze the Deflector
	},
},
{ -- ZFThekatheMartyr
	name = AL["Theka the Martyr"],
	npcID = 7272,
	Level = GetForVersion({45, 46},46),
	DisplayIDs = {{6696}},
	AtlasMapBossID = 2,
	specialType = "quest",
	[SOD_DIFF] = {
		{ 1,  10660 }, -- First Mosh'aru Tablet
	},
	[NORMAL_DIFF] = {
		{ 1,  10660 }, -- First Mosh'aru Tablet
	},
},
{ -- ZFSandarrDunereaver
	name = AL["Sandarr Dunereaver"],
	npcID = 10080,
	Level = 45,
	DisplayIDs = {{9291}},
	IgnoreAsSource = true,
	specialType = "rare",
	[SOD_DIFF] = {
		{ 1,  9523, [ATLASLOOT_IT_AMOUNT1] = "2-4" }, -- First Mosh'aru Tablet
	},
	[NORMAL_DIFF] = {
		{ 1,  9523, [ATLASLOOT_IT_AMOUNT1] = "2-4" }, -- First Mosh'aru Tablet
	},
},
{ -- ZFWitchDoctorZumrah
	name = AL["Witch Doctor Zum'rah"],
	npcID = 7271,
	Level = 46,
	DisplayIDs = {{6434}},
	AtlasMapBossID = 3,
	[SOD_DIFF] = {
		{ 1,  223534 }, -- Jumanza Grips
		{ 2,  18082 }, -- Zum'rah's Vexing Cane
	},
	[NORMAL_DIFF] = {
		{ 1,  18083 }, -- Jumanza Grips
		{ 2,  18082 }, -- Zum'rah's Vexing Cane
	},
},
{ -- ZFNekrumGutchewer
	name = AL["Nekrum Gutchewer"],
	npcID = 7796,
	Level = GetForVersion({45, 46},45),
	DisplayIDs = {{6690}},
	AtlasMapBossID = 4,
	specialType = "quest",
	[SOD_DIFF] = {
		{ 1,  9471 }, -- Nekrum's Medallion
	},
	[NORMAL_DIFF] = {
		{ 1,  9471 }, -- Nekrum's Medallion
	},
},
{ -- ZFSezzziz
	name = AL["Shadowpriest Sezz'ziz"],
	npcID = 7275,
	Level = GetForVersion(47,46),
	DisplayIDs = {{6441}},
	AtlasMapBossID = 4,
	[SOD_DIFF] = {
		{ 1,  9470 }, -- Bad Mojo Mask
		{ 2,  223529 }, -- Jinxed Hoodoo Skin
		{ 3,  223530 }, -- Jinxed Hoodoo Kilt
		{ 4,  9475 }, -- Diabolic Skiver
	},
	[NORMAL_DIFF] = {
		{ 1,  9470 }, -- Bad Mojo Mask
		{ 2,  9473 }, -- Jinxed Hoodoo Skin
		{ 3,  9474 }, -- Jinxed Hoodoo Kilt
		{ 4,  9475 }, -- Diabolic Skiver
	},
},
{ -- ZFDustwraith
	name = AL["Dustwraith"],
	npcID = 10081,
	Level = GetForVersion(47,46),
	DisplayIDs = {{9292}},
	AtlasMapBossID = 4,
	specialType = "rare",
	[SOD_DIFF] = {
		{ 1, 223533 }, -- Desertwalker Cane
	},
	[NORMAL_DIFF] = {
		{ 1,  12471 }, -- Desertwalker Cane
	},
},
{ -- ZFSandfury
	name = AL["Sandfury Executioner"],
	npcID = 7274,
	Level = 46,
	DisplayIDs = {{6440}},
	AtlasMapBossID = 5,
	[SOD_DIFF] = {
		{ 1,  8444 }, -- Executioner's Key
	},
	[NORMAL_DIFF] = {
		{ 1,  8444 }, -- Executioner's Key
	},
},
{ -- ZFSergeantBly
	name = AL["Sergeant Bly"],
	npcID = 7604,
	Level = 45,
	DisplayIDs = {{6433}},
	AtlasMapBossID = 5,
	specialType = "quest",
	[SOD_DIFF] = {
		{ 1,  8548 }, -- Divino-matic Rod
	},
	[NORMAL_DIFF] = {
		{ 1,  8548 }, -- Divino-matic Rod
	},
},
{ -- ZFHydromancerVelratha
	name = AL["Hydromancer Velratha"],
	npcID = 7795,
	Level = 46,
	DisplayIDs = {{6685}},
	AtlasMapBossID = 6,
	specialType = "quest",
	[SOD_DIFF] = {
		{ 1,  9234 }, -- Tiara of the Deep
		{ 2,  10661 }, -- Second Mosh'aru Tablet
	},
	[NORMAL_DIFF] = {
		{ 1,  9234 }, -- Tiara of the Deep
		{ 2,  10661 }, -- Second Mosh'aru Tablet
	},
},
{ -- ZFGahzrilla
	name = AL["Gahz'rilla"],
	npcID = 7273,
	Level = 46,
	DisplayIDs = {{7271}},
	AtlasMapBossID = 6,
	[SOD_DIFF] = {
		{ 1, 223528 }, -- Gahz'rilla Scale Armor
		{ 3, 223527 }, -- Gahz'rilla Fang
	},
	[NORMAL_DIFF] = {
		{ 1,  9469 }, -- Gahz'rilla Scale Armor
		{ 3,  9467 }, -- Gahz'rilla Fang
	},
},
{ -- ZFChiefUkorzSandscalp
	name = AL["Chief Ukorz Sandscalp"],
	npcID = 7267,
	Level = GetForVersion(48,46),
	DisplayIDs = {{6439}},
	AtlasMapBossID = 7,
	[SOD_DIFF] = {
		{ 1, 223963 }, -- Embrace of the Lycan
		{ 2, 223531 }, -- Big Bad Pauldrons
		{ 3,  9478 }, -- Ripsaw
		{ 4,  9477 }, -- The Chief's Enforcer
		{ 6,  11086 }, -- Jang'thraze the Protector
	},
	[NORMAL_DIFF] = {
		{ 1,  9479 }, -- Embrace of the Lycan
		{ 2,  9476 }, -- Big Bad Pauldrons
		{ 3,  9478 }, -- Ripsaw
		{ 4,  9477 }, -- The Chief's Enforcer
		{ 6,  11086 }, -- Jang'thraze the Protector
	},
},
{ -- ZFZerillis
	name = AL["Zerillis"],
	npcID = 10082,
	Level = 45,
	DisplayIDs = {{9293}},
	AtlasMapBossID = 8,
	specialType = "rare",
	[SOD_DIFF] = {
		{ 1,  12470 }, -- Sandstalker Ankleguards
	},
	[NORMAL_DIFF] = {
		{ 1,  12470 }, -- Sandstalker Ankleguards
	},
},
{ -- ZFTrash
	name = AL["Trash"],
	ExtraList = true,
	[SOD_DIFF] = {
		{ 1,  9512 }, -- Blackmetal Cape
		{ 2,  9484 }, -- Spellshock Leggings
		{ 3,  862 }, -- Runed Ring
		{ 4,  6440 }, -- Brainlash
		{ 5,  9483 }, -- Flaming Incinerator
		{ 6,  2040 }, -- Troll Protector
		{ 7,  5616 }, -- Gutwrencher
		{ 8,  9511 }, -- Bloodletter Scalpel
		{ 9,  9481 }, -- The Minotaur
		{ 10, 9480 }, -- Eyegouger
		{ 11, 9482 }, -- Witch Doctor's Cane
		{ 13, 9243 }, -- Shriveled Heart
	},
	[NORMAL_DIFF] = {
		{ 1,  9512 }, -- Blackmetal Cape
		{ 2,  9484 }, -- Spellshock Leggings
		{ 3,  862 }, -- Runed Ring
		{ 4,  6440 }, -- Brainlash
		{ 5,  9483 }, -- Flaming Incinerator
		{ 6,  2040 }, -- Troll Protector
		{ 7,  5616 }, -- Gutwrencher
		{ 8,  9511 }, -- Bloodletter Scalpel
		{ 9,  9481 }, -- The Minotaur
		{ 10, 9480 }, -- Eyegouger
		{ 11, 9482 }, -- Witch Doctor's Cane
		{ 13, 9243 }, -- Shriveled Heart
	},
},

	},
}

data["Maraudon"] = {
	MapID = 2100,
	InstanceID = 349,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Maraudon",
	AtlasMapFile = {"CL_Maraudon", "CL_MaraudonEnt"},
	AtlasMapFile_AL = {"Maraudon", "MaraudonEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({25, 46, 55},{30, 43, 48}),
	items = {
		{ -- MaraKhanVeng
			name = AL["Veng"],
			npcID = 13738,
			DisplayIDs = {{9418}},
			AtlasMapBossID = 1,
			specialType = "quest",
			[SOD_DIFF] = {
				{ 1,  17765 }, -- Gem of the Fifth Khan
			},
			[NORMAL_DIFF] = {
				{ 1,  17765 }, -- Gem of the Fifth Khan
			},
		},
		{ -- MaraNoxxion
			name = AL["Noxxion"],
			npcID = 13282,
			Level = GetForVersion(48,46),
			DisplayIDs = {{11172}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1,  17746 }, -- Noxxion's Shackles
				{ 2,  17744 }, -- Heart of Noxxion
				{ 3,  17745 }, -- Noxious Shooter
			},
			[NORMAL_DIFF] = {
				{ 1,  17746 }, -- Noxxion's Shackles
				{ 2,  17744 }, -- Heart of Noxxion
				{ 3,  17745 }, -- Noxious Shooter
			},
		},
		{ -- MaraRazorlash
			name = AL["Razorlash"],
			npcID = 12258,
			Level = GetForVersion(48,46),
			DisplayIDs = {{12389}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1,  17749 }, -- Phytoskin Spaulders
				{ 2,  223543 }, -- Vinerot Sandals
				{ 4,  17750 }, -- Chloromesh Girdle
				{ 5,  17751 }, -- Brusslehide Leggings
			},
			[NORMAL_DIFF] = {
				{ 1,  17749 }, -- Phytoskin Spaulders
				{ 2,  17748 }, -- Vinerot Sandals
				{ 4,  17750 }, -- Chloromesh Girdle
				{ 5,  17751 }, -- Brusslehide Leggings
			},
		},
		{ -- MaraKhanMaraudos
			name = AL["Maraudos"],
			npcID = 13739,
			DisplayIDs = {{9441}},
			AtlasMapBossID = 4,
			specialType = "quest",
			[SOD_DIFF] = {
				{ 1,  17764 }, -- Gem of the Fourth Khan
			},
			[NORMAL_DIFF] = {
				{ 1,  17764 }, -- Gem of the Fourth Khan
			},
		},
		{ -- MaraLordVyletongue
			name = AL["Lord Vyletongue"],
			npcID = 12236,
			Level = GetForVersion(47,44),
			DisplayIDs = {{12334}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1,  17755 }, -- Satyrmane Sash
				{ 2,  17754 }, -- Infernal Trickster Leggings
				{ 3,  17752 }, -- Satyr's Lash
			},
			[NORMAL_DIFF] = {
				{ 1,  17755 }, -- Satyrmane Sash
				{ 2,  17754 }, -- Infernal Trickster Leggings
				{ 3,  17752 }, -- Satyr's Lash
			},
		},
		{ -- MaraMeshlok
			name = AL["Meshlok the Harvester"],
			npcID = 12237,
			Level = 48,
			DisplayIDs = {{9014}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1,  17767 }, -- Bloomsprout Headpiece
				{ 2,  17741 }, -- Nature's Embrace
				{ 3,  17742 }, -- Fungus Shroud Armor
			},
			[NORMAL_DIFF] = {
				{ 1,  17767 }, -- Bloomsprout Headpiece
				{ 2,  17741 }, -- Nature's Embrace
				{ 3,  17742 }, -- Fungus Shroud Armor
			},
		},
		{ -- MaraCelebras
			name = AL["Celebras the Cursed"],
			npcID = 12225,
			Level = GetForVersion(49,46),
			DisplayIDs = {{12350}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 223525 }, -- Soothsayer's Headdress
				{ 2,  17739 }, -- Grovekeeper's Drape
				{ 3,  17738 }, -- Claw of Celebras
			},
			[NORMAL_DIFF] = {
				{ 1,  17740 }, -- Soothsayer's Headdress
				{ 2,  17739 }, -- Grovekeeper's Drape
				{ 3,  17738 }, -- Claw of Celebras
			},
		},
		{ -- MaraLandslide
			name = AL["Landslide"],
			npcID = 12203,
			Level = GetForVersion(50,48),
			DisplayIDs = {{12293}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1, 223522 }, -- Helm of the Mountain
				{ 2,  17736 }, -- Rockgrip Gauntlets
				{ 3, 223523 }, -- Cloud Stone
				{ 4, 223524 }, -- Fist of Stone
			},
			[NORMAL_DIFF] = {
				{ 1,  17734 }, -- Helm of the Mountain
				{ 2,  17736 }, -- Rockgrip Gauntlets
				{ 3,  17737 }, -- Cloud Stone
				{ 4,  17943 }, -- Fist of Stone
			},
		},
		{ -- MaraTinkererGizlock
			name = AL["Tinkerer Gizlock"],
			npcID = 13601,
			Level = GetForVersion(50,48),
			DisplayIDs = {{7125}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1, 223545 }, -- Gizlock's Hypertech Buckler
				{ 2, 223542 }, -- Megashot Rifle
				{ 3, 223520 }, -- Inventor's Focal Sword
			},
			[NORMAL_DIFF] = {
				{ 1,  17718 }, -- Gizlock's Hypertech Buckler
				{ 2,  17717 }, -- Megashot Rifle
				{ 3,  17719 }, -- Inventor's Focal Sword
			},
		},
		{ -- MaraRotgrip
			name = AL["Rotgrip"],
			npcID = 13596,
			Level = GetForVersion(50,48),
			DisplayIDs = {{13589}},
			AtlasMapBossID = 10,
			[SOD_DIFF] = {
				{ 1, 223521 }, -- Rotgrip Mantle
				{ 2,  17728 }, -- Albino Crocscale Boots
				{ 3,  17730 }, -- Gatorbite Axe
			},
			[NORMAL_DIFF] = {
				{ 1,  17732 }, -- Rotgrip Mantle
				{ 2,  17728 }, -- Albino Crocscale Boots
				{ 3,  17730 }, -- Gatorbite Axe
			},
		},
		{ -- MaraPrincessTheradras
			name = AL["Princess Theradras"],
			npcID = 12201,
			Level = GetForVersion(51,48),
			DisplayIDs = {{12292}},
			AtlasMapBossID = 11,
			[SOD_DIFF] = {
				{ 1, 223964 }, -- Blade of Eternal Darkness
				{ 3, 223519 }, -- Eye of Theradras
				{ 4, 223541 }, -- Gemshard Heart
				{ 5, 223518 }, -- Charstone Dirk
				{ 6, 221780 }, -- Princess Theradras' Scepter
				{ 7,  17714 }, -- Bracers of the Stone Princess
				{ 8,  17711 }, -- Elemental Rockridge Leggings
				{ 9,  17713 }, -- Blackstone Ring
			},
			[NORMAL_DIFF] = {
				{ 1,  17780 }, -- Blade of Eternal Darkness
				{ 3,  17715 }, -- Eye of Theradras
				{ 4,  17707 }, -- Gemshard Heart
				{ 5,  17714 }, -- Bracers of the Stone Princess
				{ 6,  17711 }, -- Elemental Rockridge Leggings
				{ 7,  17713 }, -- Blackstone Ring
				{ 8,  17710 }, -- Charstone Dirk
				{ 9,  17766 }, -- Princess Theradras' Scepter
			},
		},
		{ -- MaraNamelesProphet
			name = AL["The Nameless Prophet"],
			npcID = 13718,
			DisplayIDs = {{9426}},
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*A",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17757 }, -- Amulet of Spirits
			},
		},
		{ -- MaraKhanKolk
			name = AL["Kolk"],
			npcID = 13742,
			DisplayIDs = {{4860}},
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*1",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17761 }, -- Gem of the First Khan
			},
		},
		{ -- MaraKhanGelk
			name = AL["Gelk"],
			npcID = 13741,
			DisplayIDs = {{9427}},
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*2",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17762 }, -- Gem of the Second Khan
			},
		},
		{ -- MaraKhanMagra
			name = AL["Magra"],
			npcID = 13740,
			DisplayIDs = {{9433}},
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*3",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17763 }, -- Gem of the Third Khan
			},
		},
	},
}

data["TheTempleOfAtal'Hakkar2"] = {
	MapID = 1477,
	InstanceID = 109,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheTempleOfAtal'Hakkar",
	AtlasMapFile = { "CL_TheSunkenTemple", "CL_TheSunkenTempleEnt" },
	AtlasMapFile_AL = { "TheSunkenTemple", "TheSunkenTempleEnt" },
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion{50, 50, 60},
	items = {
	{ -- STBalconyMinibosses
			name = AL["Balcony Minibosses"],
			npcID = {5716, 5712, 5717, 5714, 5715, 5713},
			Level = GetForVersion({51, 52}, {459,50}),
			DisplayIDs = {{6701},{6699},{6707},{6700},{6702},{6698}},
			AtlasMapBossID = "C",
			[SOD_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Unavailable in SoD"], nil },
			},
			[NORMAL_DIFF] = {
				{ 1,  10783 }, -- Atal'ai Spaulders
				{ 2,  10784 }, -- Atal'ai Breastplate
				{ 3,  10787 }, -- Atal'ai Gloves
				{ 5,  10788 }, -- Atal'ai Girdle
				{ 6,  10785 }, -- Atal'ai Leggings
				{ 7,  10786 }, -- Atal'ai Boots
				{ 9,  20606 }, -- Amber Voodoo Feather
				{ 10, 20607 }, -- Blue Voodoo Feather
				{ 11, 20608 }, -- Green Voodoo Feather
			},
		},
		{ -- STAtalalarion
			name = AL["Atal'alarion"],
			npcID = 218624,
			Level = GetForVersion(50,50),
			DisplayIDs = {{7873}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  220539 }, -- Warbands of Sacrifice
				{ 2,  220529 }, -- Spaulders of Fanaticism
				{ 3,  220527 }, -- Atal'ai Berserker's Mantle
				{ 4,  220602 }, -- Sewer Turtle Half-Shell
				{ 5,  220568 }, -- Temple Explorer's Gun Axe
				{ 6,  220567 }, -- Bloodied Headspike
				{ 7,  220615 }, -- Panther Fur Cloak
				{ 8,  220554 }, -- Atal'alarion's Tusk Band
				{ 9,  220511 }, -- Greathelm of the Nightmare
				{ 10,  220561 }, -- Tenacious Troll Kickers
				{ 11,  220537 }, -- Dreamer's Darkwater Bracers
				{ 12,  220580 }, -- Madness of the Avatar
				{ 13,  220635 }, -- Atal'alarion's Enchanted Boulder
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
			[NORMAL_DIFF] = {
				{ 1,  10800 }, -- Darkwater Bracers
				{ 2,  10798 }, -- Atal'alarion's Tusk Ring
				{ 3,  10799 }, -- Headspike
			},
		},
		{ -- STSpawnOfHakkar
			name = AL["Spawn of Hakkar"],
			npcID = 5708,
			Level = GetForVersion(51,49),
			DisplayIDs = {{4065}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Unavailable in SoD"], nil },
			},
			[NORMAL_DIFF] = {
				{ 1,  10801 }, -- Slitherscale Boots
				{ 3,  10802 }, -- Wingveil Cloak
			},
		},
		{ -- STFesteringRotslime
			name = AL["Festering Rotslime"],
			npcID = 218819,
			Level = GetForVersion(50,50),
			DisplayIDs = {{119351}},
			[SOD_DIFF] = {
				{ 1, 220542 }, -- Polluted Murkwater Gauntlets
				{ 2, 220552 }, -- Waistguard of Pain
				{ 3, 220538 }, -- Cursed Slimescale Bracers
				{ 4, 220545 }, -- Foul Smelling Fighter's Gloves
				{ 5, 220546 }, -- Hands of the Tormented
				{ 6, 220540 }, -- Corruption Laden Handguards
				{ 7, 220569 }, -- Blistering Ragehammer
				{ 8, 220550 }, -- Temple Looter's Waistband
				{ 9, 220518 }, -- Ba'ham's Dusty Hat
				{ 10, 220541 }, -- Disease-Ridden Plate Fists
				{ 11, 220571 }, -- Stinging Longbow
				{ 12, 220565 }, -- Ethereal Mistwalker Boots
				{ 13, 221484 }, -- Witch Doctor's Hex Stick
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Unavailable in Classic"], nil },
			},
		},
		{ -- STAtalaiDefenders
			name = AL["Atal'ai Defenders"],
			npcID = 221637,
			Level = GetForVersion(50,50),
			DisplayIDs = {{118789}},
			[SOD_DIFF] = {
				{ 1,  220555 }, -- Atal'ai Serpentscale Girdle
				{ 2,  220532 }, -- Reinforced Atal'ai Spaulders
				{ 3,  220516 }, -- Gasher's Forgotten Visor
				{ 4,  220591 }, -- Mijan's Restorative Rod
				{ 5,  220558 }, -- Atal'ai Assassin's Leggings
				{ 6,  220572 }, -- Rinzo's Rapid Repeater
				{ 7,  220528 }, -- Atal'ai Huntsman's Shoulders
				{ 8,  220611 }, -- Hukku's Hex Cape
				{ 9,  220533 }, -- Reforged Atal'ai Breastplate
				{ 10,  220522 }, -- Soulcatcher Crown
				{ 11,  220674 }, -- Debased Stealthblade
				{ 12,  220548 }, -- Atal'ai Hexxer's Gloves
				{ 13,  220560 }, -- Silvershell Legplates
				{ 14,  220638 }, -- Unorthodox Hex Stick
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Unavailable in Classic"], nil },
			},
		},
		{ -- STDreamscytheandWeaver
			name = AL["Dreamscythe and Weaver"],
			npcID = 220833,
			Level = GetForVersion(50,50),
			DisplayIDs = {{6379}},
			[SOD_DIFF] = {
				{ 1, 220549 }, -- Dawnspire Strap
				{ 2, 220521 }, -- Hakkari Ritualist's Headdress
				{ 3, 220587 }, -- Sacrificial Dream Dagger
				{ 4, 220536 }, -- Atal'ai Medicine Man's Wrists
				{ 5, 220581 }, -- Snake Clobberer
				{ 6, 220566 }, -- Smolder Claw
				{ 7, 220551 }, -- Devotee's Sash of the Emerald Dream
				{ 8, 220584 }, -- Flamebreath Blade
				{ 9, 220519 }, -- Voodoo Feathered Headdress
				{ 10, 220544 }, -- Bloodflare Talons
				{ 11, 220594 }, -- Scythe of the Dream
				{ 12, 220609 }, -- Drape of Nightfall
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Dreamscythe"], nil },
				{ 2,  12465 }, -- Nightfall Drape
				{ 3,  12466 }, -- Dawnspire Cord
				{ 4,  12464 }, -- Bloodfire Talons
				{ 5,  10797 }, -- Firebreather
				{ 6,  12463 }, -- Drakefang Butcher
				{ 7,  12243 }, -- Smoldering Claw
				{ 8,  10795 }, -- Drakeclaw Band
				{ 9,  10796 }, -- Drakestone
				{ 16, "INV_Box_01", nil, AL["Weaver"], nil },
				{ 17,  12465 }, -- Nightfall Drape
				{ 18,  12466 }, -- Dawnspire Cord
				{ 19,  12464 }, -- Bloodfire Talons
				{ 20,  10797 }, -- Firebreather
				{ 21,  12463 }, -- Drakefang Butcher
				{ 22,  12243 }, -- Smoldering Claw
				{ 23,  10795 }, -- Drakeclaw Band
				{ 24,  10796 }, -- Drakestone
			},
		},
		{ -- STJammalanandOgom
			name = AL["Jammal'an and Ogom"],
			npcID = 218721,
			Level = GetForVersion(50,50),
			DisplayIDs = {{6708}},
			[SOD_DIFF] = {
				{ 1, 220578 }, -- Fist of the Forsaken
				{ 2, 220556 }, -- Kilt of the Fallen Atal'ai Prophet
				{ 3, 220601 }, -- Hakkari Witch Doctor's Guard
				{ 4, 220575 }, -- Eater of the Damned
				{ 5, 220547 }, -- Gloves of the Fallen Atal'ai Prophet
				{ 6, 220583 }, -- Vile Blade of the Wretched
				{ 7, 220576 }, -- Axe of the Atal'ai Executioner
				{ 8, 220625 }, -- Resilience of the Exiled
				{ 9, 220624 }, -- Bloodstained Charm of Valor
				{ 10, 220535 }, -- Garments of the Atal'ai Prophet
				{ 11, 220623 }, -- Jin'do's Lost Locket
				{ 12, 220605 }, -- Libram of Sacrilege
				{ 13, 220515 }, -- Enchanted Emerald Helmet
				{ 14, 220586 }, -- Hubris, the Bandit Brander
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Jammal'an"], nil },
				{ 2,  10806 }, -- Vestments of the Atal'ai Prophet
				{ 3,  10808 }, -- Gloves of the Atal'ai Prophet
				{ 4,  10807 }, -- Kilt of the Atal'ai Prophet
				{ 6, "INV_Box_01", nil, AL["Ogom"], nil },
				{ 7,  10805 }, -- Eater of the Dead
				{ 8,  10803 }, -- Blade of the Wretched
				{ 9,  10804 }, -- Fist of the Damned
			},
		},
		{ -- STMorphazandHazzas
			name = AL["Morphaz and Hazzas"],
			npcID = 221943,
			Level = GetForVersion(50,50),
			DisplayIDs = {{9584}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 220965 }, -- Scalebane Greataxe
				{ 2, 220514 }, -- Visor of Verdant Feathers
				{ 3, 220553 }, -- Belt of the Forsaken Worshipper
				{ 4, 220543 }, -- Emerald Scalemail Gloves
				{ 5, 220563 }, -- Boots of the Atal'ai Blood Shaman
				{ 6, 220599 }, -- Drakestone of the Blood Prophet
				{ 7, 220598 }, -- Drakestone of the Nightmare Harbinger
				{ 8, 220559 }, -- Revitalized Drake Scale Leggings
				{ 9, 220606 }, -- Idol of the Dream
				{ 10, 220607 }, -- Totem of Tormented Ancestry
				{ 11, 220597 }, -- Drakestone of the Dream Harbinger
				{ 12, 220512 }, -- Immaculate Goldsteel Helmet
				{ 13, 220589 }, -- Serpent's Striker
				{ 14, 220596 }, -- Ancient Divining Rod
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Hazzas"], nil },
				{ 2,  12465 }, -- Nightfall Drape
				{ 3,  12466 }, -- Dawnspire Cord
				{ 4,  12464 }, -- Bloodfire Talons
				{ 5,  10797 }, -- Firebreather
				{ 6,  12463 }, -- Drakefang Butcher
				{ 7,  12243 }, -- Smoldering Claw
				{ 8,  10795 }, -- Drakeclaw Band
				{ 9,  10796 }, -- Drakestone
				{ 16, "INV_Box_01", nil, AL["Morphaz"], nil },
				{ 17,  12465 }, -- Nightfall Drape
				{ 18,  12466 }, -- Dawnspire Cord
				{ 19,  12464 }, -- Bloodfire Talons
				{ 20,  10797 }, -- Firebreather
				{ 21,  12463 }, -- Drakefang Butcher
				{ 22,  12243 }, -- Smoldering Claw
				{ 23,  10795 }, -- Drakeclaw Band
				{ 24,  10796 }, -- Drakestone
			},
		},
		{ -- STEranikus
			name = AL["Shade of Eranikus"],
			npcID = 218571,
			Level = GetForVersion(50,50),
			DisplayIDs = {{117504}},
			[SOD_DIFF] = {
				{ 1, 220604 }, -- Nightmare Trophy
				{ 2, 220622 }, -- Perfectly Preserved Dragon's Eye
				{ 3, 220564 }, -- Restored Slitherscale Boots
				{ 4, 220603 }, -- Rod of Irreversible Corrosion
				{ 5, 220523 }, -- Visage of the Exiled
				{ 6, 220600 }, -- Crest of Preeminence
				{ 7, 220574 }, -- Sharpened Tooth of Eranikus
				{ 8, 220573 }, -- Dreadstalker's Hunting Bow
				{ 9, 220595 }, -- Nightmare Focus Staff
				{ 10, 220579 }, -- Witch Doctor's Stick of Mojo
				{ 11, 220585 }, -- Degraded Dire Nail
				{ 12, 220582 }, -- Dragon's Cry
				{ 16,  220636 }, -- Atal'ai Blood Icon
				{ 17,  220637 }, -- Atal'ai Ritual Token
				{ 19,  221475 }, -- Essence of Eranikus
			},
			[NORMAL_DIFF] = {
				{ 1,  10847 }, -- Dragon's Call
				{ 3,  10833 }, -- Horns of Eranikus
				{ 4,  10829 }, -- Dragon's Eye
				{ 5,  10836 }, -- Rod of Corrosion
				{ 6,  10835 }, -- Crest of Supremacy
				{ 7,  10837 }, -- Tooth of Eranikus
				{ 8,  10828 }, -- Dire Nail
				{ 10, 10454 }, -- Essence of Eranikus
			},
		},
		{ -- STAvatarofHakkar
			name = AL["Avatar of Hakkar"],
			npcID = 221394,
			DisplayIDs = {{8053}},
			AtlasMapBossID = 3,
			Level = 48,
			[SOD_DIFF] = {
				{ 1, 221363 }, -- Scapula of the Fallen Avatar
				{ 2, 221346 }, -- Scapula of the Fallen Avatar
				{ 4, 220608 }, -- Featherskin Drape
				{ 5, 220530 }, -- Will of the Atal'ai Warrior
				{ 6, 220577 }, -- Might of the Blood Loa
				{ 7, 220557 }, -- Cursed Windscale Sarong
				{ 8, 220562 }, -- Bloodshot Battle Greaves
				{ 9,  220636 }, -- Atal'ai Blood Icon
				{ 10, 220637 }, -- Atal'ai Ritual Token
				{ 12, 220634 }, -- Atal'ai Blood Ritual Charm
				{ 13, 220633 }, -- Atal'ai Blood Ritual Badge
				{ 14, 220632 }, -- Atal'ai Blood Ritual Medallion
				{ 16, 220590 }, -- Spire of Hakkari Worship
				{ 17, 220620 }, -- Wind Serpent Skull
				{ 18, 220534 }, -- Eternal Embrace of the Wind Serpent
				{ 19, 220686 }, -- Chieftain's Bane
				{ 20, 220588 }, -- Cobra Fang Claw
			},
			[NORMAL_DIFF] = {
				{ 1,  12462 }, -- Embrace of the Wind Serpent
				{ 3,  10843 }, -- Featherskin Cape
				{ 4,  10845 }, -- Warrior's Embrace
				{ 5,  10842 }, -- Windscale Sarong
				{ 6,  10846 }, -- Bloodshot Greaves
				{ 7,  10838 }, -- Might of Hakkar
				{ 8,  10844 }, -- Spire of Hakkar
			},
		},
		{ -- STTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  10630 }, -- Soulcatcher Halo
				{ 2,  10632 }, -- Slimescale Bracers
				{ 3,  10631 }, -- Murkwater Gauntlets
				{ 4,  10633 }, -- Silvershell Leggings
				{ 5,  10629 }, -- Mistwalker Boots
				{ 6,  10634 }, -- Mindseye Circle
				{ 7,  10624 }, -- Stinging Bow
				{ 8,  10623 }, -- Winter's Bite
				{ 9,  10625 }, -- Stealthblade
				{ 10, 10626 }, -- Ragehammer
				{ 11, 10628 }, -- Deathblow
				{ 12, 10627 }, -- Bludgeon of the Grinning Dog
				{ 16, 10782 }, -- Hakkari Shroud
				{ 17, 10781 }, -- Hakkari Breastplate
				{ 18, 10780 }, -- Mark of Hakkar
				{ 20, 16216 }, -- Formula: Enchant Cloak - Greater Resistance
				{ 21, 15733 }, -- Pattern: Green Dragonscale Leggings
			},
			[NORMAL_DIFF] = {
				{ 1,  10630 }, -- Soulcatcher Halo
				{ 2,  10632 }, -- Slimescale Bracers
				{ 3,  10631 }, -- Murkwater Gauntlets
				{ 4,  10633 }, -- Silvershell Leggings
				{ 5,  10629 }, -- Mistwalker Boots
				{ 6,  10634 }, -- Mindseye Circle
				{ 7,  10624 }, -- Stinging Bow
				{ 8,  10623 }, -- Winter's Bite
				{ 9,  10625 }, -- Stealthblade
				{ 10, 10626 }, -- Ragehammer
				{ 11, 10628 }, -- Deathblow
				{ 12, 10627 }, -- Bludgeon of the Grinning Dog
				{ 16, 10782 }, -- Hakkari Shroud
				{ 17, 10781 }, -- Hakkari Breastplate
				{ 18, 10780 }, -- Mark of Hakkar
				{ 20, 16216 }, -- Formula: Enchant Cloak - Greater Resistance
				{ 21, 15733 }, -- Pattern: Green Dragonscale Leggings
			},
		},
	},
}

data["BlackrockDepths"] = {
	MapID = 1584,
	InstanceID = 230,
	SubAreaIDs = { 26758, 26761, 26747, 26733, 26755, 26740, 26751, 26759, 26735, 26769, 26768, 26766, 26781, 26765, 26764, 26742, 26750, 26745, 26784, 26749 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackrockDepths",
	AtlasMapFile = {"CL_BlackrockDepths", "CL_BlackrockMountainEnt"},
	AtlasMapFile_AL = {"BlackrockDepths", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({42, 52, 60},{40, 48, 56}),
	items = {
		{ -- BRDLordRoccor
			name = AL["Lord Roccor"],
			npcID = 9025,
			Level = 51,
			SubAreaID = 26735,
			DisplayIDs = {{5781}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  22234 }, -- Mantle of Lost Hope
				{ 2,  11632 }, -- Earthslag Shoulders
				{ 3,  11631 }, -- Stoneshell Guard
				{ 4,  22397 }, -- Idol of Ferocity
				{ 5,  11630 }, -- Rockshard Pellets
				{ 7,  11813 }, -- Formula: Smoking Heart of the Mountain
			},
			[NORMAL_DIFF] = {
				{ 1,  22234 }, -- Mantle of Lost Hope
				{ 2,  11632 }, -- Earthslag Shoulders
				{ 3,  11631 }, -- Stoneshell Guard
				{ 4,  22397 }, -- Idol of Ferocity
				{ 5,  11630 }, -- Rockshard Pellets
				{ 7,  11813 }, -- Formula: Smoking Heart of the Mountain
			},
		},
		{ -- BRDHighInterrogatorGerstahn
			name = AL["High Interrogator Gerstahn "],
			npcID = 9018,
			Level = 52,
			SubAreaID = 26733,
			DisplayIDs = {{8761}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1,  11626 }, -- Blackveil Cape
				{ 2,  11624 }, -- Kentic Amice
				{ 3,  22240 }, -- Greaves of Withering Despair
				{ 4, 223539 }, -- Enthralled Sphere
				{ 5,  11623 }, -- Spritecaster Cape
				{ 7,  11140 }, -- Prison Cell Key
			},
			[NORMAL_DIFF] = {
				{ 1,  11626 }, -- Blackveil Cape
				{ 2,  11624 }, -- Kentic Amice
				{ 3,  22240 }, -- Greaves of Withering Despair
				{ 4,  11625 }, -- Enthralled Sphere
				{ 5,  11623 }, -- Spritecaster Cape
				{ 7,  11140 }, -- Prison Cell Key
			},
		},
		{ -- BRDHoundmaster
			name = AL["Houndmaster Grebmar"],
			npcID = 9319,
			Level = 52,
			SubAreaID = 26735,
			DisplayIDs = {{9212}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  11623 }, -- Spritecaster Cape
				{ 2,  11627 }, -- Fleetfoot Greaves
				{ 3, 223540 }, -- Houndmaster's Bow
				{ 4, 223982 }, -- Houndmaster's Rifle
				{ 5,  11626 }, -- Blackveil Cape
			},
			[NORMAL_DIFF] = {
				{ 1,  11623 }, -- Spritecaster Cape
				{ 2,  11627 }, -- Fleetfoot Greaves
				{ 3,  11628 }, -- Houndmaster's Bow
				{ 4,  11629 }, -- Houndmaster's Rifle
				{ 5,  11626 }, -- Blackveil Cape
			},
		},
		-- ## RING START
		{ -- BRDGorosh
			name = AL["Gorosh the Dervish"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9027,
			Level = GetForVersion(56,52),
			SubAreaID = 26742,
			DisplayIDs = {{8760}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 227952 }, -- Savage Gladiator Chain
				{ 2,  22271 }, -- Leggings of Frenzied Magic
				{ 3,  22257 }, -- Bloodclot Band
				{ 4, 227962 }, -- Flarethorn
			},
			[NORMAL_DIFF] = {
				{ 1,  11726 }, -- Savage Gladiator Chain
				{ 2,  22271 }, -- Leggings of Frenzied Magic
				{ 3,  22257 }, -- Bloodclot Band
				{ 4,  22266 }, -- Flarethorn
			},
		},
		{ -- BRDGrizzle
			name = AL["Grizzle"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9028,
			Level = GetForVersion(54,52),
			DisplayIDs = {{7873}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 223544 }, -- Dregmetal Spaulders
				{ 2,  11703 }, -- Stonewall Girdle
				{ 3,  22270 }, -- Entrenching Boots
				{ 4,  11702 }, -- Grizzle's Skinner
				{ 6,  11610 }, -- Plans: Dark Iron Pulverizer
			},
			[NORMAL_DIFF] = {
				{ 1,  11722 }, -- Dregmetal Spaulders
				{ 2,  11703 }, -- Stonewall Girdle
				{ 3,  22270 }, -- Entrenching Boots
				{ 4,  11702 }, -- Grizzle's Skinner
				{ 6,  11610 }, -- Plans: Dark Iron Pulverizer
			},
		},
		{ -- BRDEviscerator
			name = AL["Eviscerator"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9029,
			Level = GetForVersion(54,52),
			DisplayIDs = {{523}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 223987 }, -- Splinthide Shoulders
				{ 2,  11679 }, -- Rubicund Armguards
				{ 4,  11686 }, -- Girdle of Beastial Fury
				{ 5, 227961 }, -- Savage Gladiator Grips
			},
			[NORMAL_DIFF] = {
				{ 1,  11685 }, -- Splinthide Shoulders
				{ 2,  11679 }, -- Rubicund Armguards
				{ 4,  11686 }, -- Girdle of Beastial Fury
				{ 5,  11730 }, -- Savage Gladiator Grips
			},
		},
		{ -- BRDOkthor
			name = AL["Ok'thor the Breaker"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9030,
			Level = GetForVersion(54,53),
			DisplayIDs = {{11538}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  11665 }, -- Ogreseer Fists
				{ 2,  11662 }, -- Ban'thok Sash
				{ 3,  11728 }, -- Savage Gladiator Leggings
				{ 4, 223985 }, -- Cyclopean Band
			},
			[NORMAL_DIFF] = {
				{ 1,  11665 }, -- Ogreseer Fists
				{ 2,  11662 }, -- Ban'thok Sash
				{ 3,  11728 }, -- Savage Gladiator Leggings
				{ 4,  11824 }, -- Cyclopean Band
			},
		},
		{ -- BRDAnubshiah
			name = AL["Anub'shiah"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9031,
			Level = GetForVersion(54,52),
			DisplayIDs = {{3004}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  11678 }, -- Carapace of Anub'shiah
				{ 2, 223986 }, -- Graverot Cape
				{ 3,  11675 }, -- Shadefiend Boots
				{ 4, 227957 }, -- Savage Gladiator Greaves
			},
			[NORMAL_DIFF] = {
				{ 1,  11678 }, -- Carapace of Anub'shiah
				{ 2,  11677 }, -- Graverot Cape
				{ 3,  11675 }, -- Shadefiend Boots
				{ 4,  11731 }, -- Savage Gladiator Greaves
			},
		},
		{ -- BRDHedrum
			name = AL["Hedrum the Creeper"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9032,
			Level = GetForVersion(53,52),
			DisplayIDs = {{8271}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  11633 }, -- Spiderfang Carapace
				{ 2, 223984 }, -- Silkweb Gloves
				{ 3,  11635 }, -- Hookfang Shanker
				{ 4, 227955 }, -- Savage Gladiator Helm
			},
			[NORMAL_DIFF] = {
				{ 1,  11633 }, -- Spiderfang Carapace
				{ 2,  11634 }, -- Silkweb Gloves
				{ 3,  11635 }, -- Hookfang Shanker
				{ 4,  11729 }, -- Savage Gladiator Helm
			},
		},
		-- ## RING END
		{ -- BRDPyromancerLoregrain
			name = AL["Pyromancer Loregrain"],
			npcID = 9024,
			Level = 52,
			SubAreaID = 26745,
			DisplayIDs = {{8762}},
			AtlasMapBossID = 7,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 223981 }, -- Flamestrider Robes
				{ 2, 223980 }, -- Searingscale Leggings
				{ 3,  11748 }, -- Pyric Caduceus
				{ 4, 223538 }, -- Kindling Stave
				{ 6,  11207 }, -- Formula: Enchant Weapon - Fiery Weapon
			},
			[NORMAL_DIFF] = {
				{ 1,  11747 }, -- Flamestrider Robes
				{ 2,  11749 }, -- Searingscale Leggings
				{ 3,  11748 }, -- Pyric Caduceus
				{ 4,  11750 }, -- Kindling Stave
				{ 6,  11207 }, -- Formula: Enchant Weapon - Fiery Weapon
			},
		},
		{ -- BRDTheVault
			name = AL["Dark Coffer"],
			SubAreaID = 26758,
			npcID = {9438, 9442, 9443, 9439, 9437, 9441},
			DisplayIDs = {{8592},{8595},{8596},{8593},{8591},{8594}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Dark Keeper"], nil },
				{ 2,  11197 }, -- Dark Keeper Key
				{ 5, "INV_Box_01", nil, AL["Secret Safe"], nil },
				{ 6,  22256 }, -- Mana Shaping Handwraps
				{ 7,  22205 }, -- Black Steel Bindings
				{ 8,  22255 }, -- Magma Forged Band
				{ 9,  22254 }, -- Wand of Eternal Light
				{ 10,  11923 }, -- The Hammer of Grace
				{ 12, "INV_Box_01", nil, AL["Dark Coffer"], nil },
				{ 13, 11752 }, -- Black Blood of the Tormented
				{ 14, 11751 }, -- Burning Essence
				{ 15, 11753 }, -- Eye of Kajal
				{ 16, "INV_Box_01", nil, AL["Relic Coffer"], nil },
				{ 17, 11945 }, -- Dark Iron Ring
				{ 18, 11946 }, -- Fire Opal Necklace
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Dark Keeper"], nil },
				{ 2,  11197 }, -- Dark Keeper Key
				{ 5, "INV_Box_01", nil, AL["Secret Safe"], nil },
				{ 6,  22256 }, -- Mana Shaping Handwraps
				{ 7,  22205 }, -- Black Steel Bindings
				{ 8,  22255 }, -- Magma Forged Band
				{ 9,  22254 }, -- Wand of Eternal Light
				{ 10,  11923 }, -- The Hammer of Grace
				{ 12, "INV_Box_01", nil, AL["Dark Coffer"], nil },
				{ 13, 11752 }, -- Black Blood of the Tormented
				{ 14, 11751 }, -- Burning Essence
				{ 15, 11753 }, -- Eye of Kajal
				{ 16, "INV_Box_01", nil, AL["Relic Coffer"], nil },
				{ 17, 11945 }, -- Dark Iron Ring
				{ 18, 11946 }, -- Fire Opal Necklace
			},
		},
		{ -- BRDWarderStilgiss
			name = AL["Warder Stilgiss"],
			npcID = 9041,
			Level = GetForVersion(56,54),
			SubAreaID = 26758,
			DisplayIDs = {{9089}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1,  11782 }, -- Boreal Mantle
				{ 2,  22241 }, -- Dark Warder's Pauldrons
				{ 3,  11783 }, -- Chillsteel Girdle
				{ 4, 223983 }, -- Arbiter's Blade
			},
			[NORMAL_DIFF] = {
				{ 1,  11782 }, -- Boreal Mantle
				{ 2,  22241 }, -- Dark Warder's Pauldrons
				{ 3,  11783 }, -- Chillsteel Girdle
				{ 4,  11784 }, -- Arbiter's Blade
			},
		},
		{ -- BRDVerek
			name = AL["Verek"],
			npcID = 9042,
			Level = GetForVersion(55,53),
			SubAreaID = 26758,
			DisplayIDs = {{9019}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1,  11755 }, -- Verek's Collar
				{ 2,  22242 }, -- Verek's Leash
			},
			[NORMAL_DIFF] = {
				{ 1,  11755 }, -- Verek's Collar
				{ 2,  22242 }, -- Verek's Leash
			},
		},
		{ -- BRDWatchmanDoomgrip
			name = AL["Watchman Doomgrip"],
			npcID = 9476,
			Level = GetForVersion(55,54),
			SubAreaID = 26758,
			DisplayIDs = {{8655}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1,  22205 }, -- Black Steel Bindings
				{ 2,  22255 }, -- Magma Forged Band
				{ 3,  22256 }, -- Mana Shaping Handwraps
				{ 4,  22254 }, -- Wand of Eternal Light
			},
			[NORMAL_DIFF] = {
				{ 1,  22205 }, -- Black Steel Bindings
				{ 2,  22255 }, -- Magma Forged Band
				{ 3,  22256 }, -- Mana Shaping Handwraps
				{ 4,  22254 }, -- Wand of Eternal Light
			},
		},
		{ -- BRDFineousDarkvire
			name = AL["Fineous Darkvire"],
			npcID = 9056,
			Level = GetForVersion(54,53),
			SubAreaID = 26759,
			DisplayIDs = {{8704}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1,  11839 }, -- Chief Architect's Monocle
				{ 2,  22223 }, -- Foreman's Head Protector
				{ 3,  11842 }, -- Lead Surveyor's Mantle
				{ 4,  11841 }, -- Senior Designer's Pantaloons
				{ 6,  11840 }, -- Master Builder's Shirt
			},
			[NORMAL_DIFF] = {
				{ 1,  11839 }, -- Chief Architect's Monocle
				{ 2,  22223 }, -- Foreman's Head Protector
				{ 3,  11842 }, -- Lead Surveyor's Mantle
				{ 4,  11841 }, -- Senior Designer's Pantaloons
				{ 6,  11840 }, -- Master Builder's Shirt
			},
		},
		{ -- BRDLordIncendius
			name = AL["Lord Incendius"],
			npcID = 9017,
			Level = GetForVersion(55,53),
			SubAreaID = 26750,
			DisplayIDs = {{1204}},
			AtlasMapBossID = 10,
			[SOD_DIFF] = {
				{ 1,  11766 }, -- Flameweave Cuffs
				{ 2,  11764 }, -- Cinderhide Armsplints
				{ 3,  11765 }, -- Pyremail Wristguards
				{ 4,  11767 }, -- Emberplate Armguards
				{ 6,  19268 }, -- Ace of Elementals
				{ 8,  11768 }, -- Incendic Bracers
			},
			[NORMAL_DIFF] = {
				{ 1,  11766 }, -- Flameweave Cuffs
				{ 2,  11764 }, -- Cinderhide Armsplints
				{ 3,  11765 }, -- Pyremail Wristguards
				{ 4,  11767 }, -- Emberplate Armguards
				{ 6,  19268 }, -- Ace of Elementals
				{ 8,  11768 }, -- Incendic Bracers
			},
		},
		{ -- BRDBaelGar
			name = AL["Bael'Gar"],
			npcID = 9016,
			Level = GetForVersion(54,52),
			SubAreaID = 26747,
			DisplayIDs = {{12162}},
			AtlasMapBossID = 11,
			[SOD_DIFF] = {
				{ 1,  11807 }, -- Sash of the Burning Heart
				{ 2,  11802 }, -- Lavacrest Leggings
				{ 3,  11805 }, -- Rubidium Hammer
				{ 4,  11803 }, -- Force of Magma
			},
			[NORMAL_DIFF] = {
				{ 1,  11807 }, -- Sash of the Burning Heart
				{ 2,  11802 }, -- Lavacrest Leggings
				{ 3,  11805 }, -- Rubidium Hammer
				{ 4,  11803 }, -- Force of Magma
			},
		},
		{ -- BRDGeneralAngerforge
			name = AL["General Angerforge"],
			npcID = 9033,
			Level = GetForVersion(57,55),
			SubAreaID = 26749,
			DisplayIDs = {{8756}},
			AtlasMapBossID = 13,
			[SOD_DIFF] = {
				{ 1,  11820 }, -- Royal Decorated Armor
				{ 2,  11821 }, -- Warstrife Leggings
				{ 3, 11810 }, -- Force of Will
				{ 4, 227940 }, -- Lord General's Sword
				{ 5, 227948 }, -- Angerforge's Battle Axe
				{ 6,  11841 }, -- Senior Designer's Pantaloons
			},
			[NORMAL_DIFF] = {
				{ 1,  11820 }, -- Royal Decorated Armor
				{ 2,  11821 }, -- Warstrife Leggings
				{ 3, 11810 }, -- Force of Will
				{ 4,  11817 }, -- Lord General's Sword
				{ 5,  11816 }, -- Angerforge's Battle Axe
				{ 6,  11841 }, -- Senior Designer's Pantaloons
			},
		},
		{ -- BRDGolemLordArgelmach
			name = AL["Golem Lord Argelmach"],
			npcID = 8983,
			Level = GetForVersion(57,55),
			SubAreaID = 26781,
			DisplayIDs = {{8759}},
			AtlasMapBossID = 14,
			[SOD_DIFF] = {
				{ 1, 227964 }, -- Luminary Kilt
				{ 2, 227965 }, -- Omnicast Boots
				{ 3,  11669 }, -- Naglering
				{ 4, 227967 }, -- Second Wind
			},
			[NORMAL_DIFF] = {
				{ 1,  11823 }, -- Luminary Kilt
				{ 2,  11822 }, -- Omnicast Boots
				{ 3,  11669 }, -- Naglering
				{ 4,  11819 }, -- Second Wind
			},
		},
		{ -- BRDGuzzler
			name = AL["Guzzler"],
			SubAreaID = 26751,
			npcID = {9537, 12944, 9543, 9499},
			Level = 55,
			DisplayIDs = {{8658},{14666},{8667},{8652}},
			AtlasMapBossID = 15,
			[SOD_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Hurley Blackbreath"], nil },
				{ 2,  11735 }, -- Ragefury Eyepatch
				{ 3,  18043 }, -- Coal Miner Boots
				{ 4,  22275 }, -- Firemoss Boots
				{ 5,  18044 }, -- Hurley's Tankard
				{ 7, "INV_Box_01", nil, AL["Ribbly Screwspigot"], nil },
				{ 8, 227901 }, -- Plans: Tempered Dark Iron Plate
				{ 9, 2662 }, -- Ribbly's Quiver
				{ 10, 2663 }, -- Ribbly's Bandolier
				{ 11, 11742 }, -- Wayfarer's Knapsack
				{ 16, "INV_Box_01", nil, AL["Lokhtos Darkbargainer"], nil },
				{ 17, 18592 }, -- Plans: Sulfuron Hammer
				{ 22, "INV_Box_01", nil, AL["Plugger Spazzring"], nil },
				{ 23, 12793 }, -- Mixologist's Tunic
				{ 24, 12791 }, -- Barman Shanker
				{ 25, 18653 }, -- Schematic: Goblin Jumper Cables XL
				{ 26, 13483 }, -- Recipe: Transmute Fire to Earth
				{ 27, 15759 }, -- Pattern: Black Dragonscale Breastplate
				{ 28, 11325 }, -- Dark Iron Ale Mug
				{ 29, 11602 }, -- Grim Guzzler Key
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Hurley Blackbreath"], nil },
				{ 2,  11735 }, -- Ragefury Eyepatch
				{ 3,  18043 }, -- Coal Miner Boots
				{ 4,  22275 }, -- Firemoss Boots
				{ 5,  18044 }, -- Hurley's Tankard
				{ 7, "INV_Box_01", nil, AL["Ribbly Screwspigot"], nil },
				{ 8, 11612 }, -- Plans: Dark Iron Plate
				{ 9, 2662 }, -- Ribbly's Quiver
				{ 10, 2663 }, -- Ribbly's Bandolier
				{ 11, 11742 }, -- Wayfarer's Knapsack
				{ 16, "INV_Box_01", nil, AL["Lokhtos Darkbargainer"], nil },
				{ 17, 18592 }, -- Plans: Sulfuron Hammer
				{ 22, "INV_Box_01", nil, AL["Plugger Spazzring"], nil },
				{ 23, 12793 }, -- Mixologist's Tunic
				{ 24, 12791 }, -- Barman Shanker
				{ 25, 18653 }, -- Schematic: Goblin Jumper Cables XL
				{ 26, 13483 }, -- Recipe: Transmute Fire to Earth
				{ 27, 15759 }, -- Pattern: Black Dragonscale Breastplate
				{ 28, 11325 }, -- Dark Iron Ale Mug
				{ 29, 11602 }, -- Grim Guzzler Key
			},
		},
		{ -- Phalanx
			name = AL["Phalanx"],
			npcID = 9502,
			Level = 55,
			SubAreaID = 26751,
			DisplayIDs = {{8177}},
			AtlasMapBossID = 15,
			[SOD_DIFF] = {
				{ 1, 227947 }, -- Golem Fitted Pauldrons
				{ 2,  11745 }, -- Fists of Phalanx
				{ 3, 11744 }, -- Bloodfist
				{ 4, 11743 }, -- Rockfist
			},
			[NORMAL_DIFF] = {
				{ 1,  22212 }, -- Golem Fitted Pauldrons
				{ 2,  11745 }, -- Fists of Phalanx
				{ 3, 11744 }, -- Bloodfist
				{ 4, 11743 }, -- Rockfist
			},
		},
		{ -- BRDFlamelash
			name = AL["Ambassador Flamelash"],
			npcID = 9156,
			Level = GetForVersion(57,55),
			SubAreaID = 26761,
			DisplayIDs = {{8329}},
			AtlasMapBossID = 16,
			[SOD_DIFF] = {
				{ 1,  11808 }, -- Circle of Flame
				{ 3, 227970 }, -- Cape of the Fire Salamander
				{ 4, 227971 }, -- Molten Fists
				{ 5, 227972 }, -- Burst of Knowledge
				{ 6,  11809 }, -- Flame Wrath
				{ 8,  23320 }, -- Tablet of Flame Shock VI
			},
			[NORMAL_DIFF] = {
				{ 1,  11808 }, -- Circle of Flame
				{ 3,  11812 }, -- Cape of the Fire Salamander
				{ 4,  11814 }, -- Molten Fists
				{ 5,  11832 }, -- Burst of Knowledge
				{ 6,  11809 }, -- Flame Wrath
				{ 8,  23320 }, -- Tablet of Flame Shock VI
			},
		},
		{ -- BRDPanzor
			name = AL["Panzor the Invincible"],
			npcID = 8923,
			Level = GetForVersion(57,56),
			SubAreaID = 26764,
			DisplayIDs = {{8270}},
			AtlasMapBossID = 17,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1,  22245 }, -- Soot Encrusted Footwear
				{ 2,  11787 }, -- Shalehusk Boots
				{ 3,  11785 }, -- Rock Golem Bulwark
				{ 4,  11786 }, -- Stone of the Earth
			},
			[NORMAL_DIFF] = {
				{ 1,  22245 }, -- Soot Encrusted Footwear
				{ 2,  11787 }, -- Shalehusk Boots
				{ 3,  11785 }, -- Rock Golem Bulwark
				{ 4,  11786 }, -- Stone of the Earth
			},
		},
		{ -- BRDTomb
			name = AL["Chest of The Seven"],
			SubAreaID = 26784,
			npcID = {9034, 9035, 9036, 9037, 9038, 9039, 9040},
			ObjectID = 169243,
			Level = GetForVersion({55, 57},{55, 56}),
			DisplayIDs = {{8690},{8686},{8692},{8689},{8691},{8687},{8688}},
			AtlasMapBossID = 18,
			[SOD_DIFF] = {
				{ 1, 227958 }, -- Ghostshroud
				{ 2, 227956 }, -- Deathdealer Breastplate
				{ 3,  11929 }, -- Haunting Specter Leggings
				{ 4, 227959 }, -- Legplates of the Eternal Guardian
				{ 5,  11920 }, -- Wraith Scythe
				{ 6, 227963 }, -- Blood-etched Blade
				{ 7,  11923 }, -- The Hammer of Grace
				{ 8, 227960 }, -- Impervious Giant
			},
			[NORMAL_DIFF] = {
				{ 1,  11925 }, -- Ghostshroud
				{ 2,  11926 }, -- Deathdealer Breastplate
				{ 3,  11929 }, -- Haunting Specter Leggings
				{ 4,  11927 }, -- Legplates of the Eternal Guardian
				{ 5,  11920 }, -- Wraith Scythe
				{ 6,  11922 }, -- Blood-etched Blade
				{ 7,  11923 }, -- The Hammer of Grace
				{ 8,  11921 }, -- Impervious Giant
			},
		},
		{ -- BRDMagmus
			name = AL["Magmus"],
			npcID = 9938,
			Level = GetForVersion(57,56),
			SubAreaID = 26768,
			DisplayIDs = {{12162}},
			AtlasMapBossID = 20,
			[SOD_DIFF] = {
				{ 1,  11746 }, -- Golem Skull Helm 227975
				{ 2, 227978 }, -- Magmus Stone
				{ 3,  22395 }, -- Totem of Rage
				{ 4, 227974 }, -- Lavastone Hammer
				{ 5,  22400 }, -- Libram of Truth
			},
			[NORMAL_DIFF] = {
				{ 1,  11746 }, -- Golem Skull Helm
				{ 2,  11935 }, -- Magmus Stone
				{ 3,  22395 }, -- Totem of Rage
				{ 4,  22400 }, -- Libram of Truth
				{ 5,  22208 }, -- Lavastone Hammer
			},
		},
		{ -- BRDPrincess
			name = AL["Princess Moira Bronzebeard"],
			npcID = 8929,
			Level = GetForVersion(58,55),
			SubAreaID = 26769,
			DisplayIDs = {{8705}},
			AtlasMapBossID = 21,
			[SOD_DIFF] = {
				{ 1,  12557 }, -- Ebonsteel Spaulders
				{ 2,  12554 }, -- Hands of the Exalted Herald
				{ 3,  12556 }, -- High Priestess Boots
				{ 4,  12553 }, -- Swiftwalker Boots
			},
			[NORMAL_DIFF] = {
				{ 1,  12557 }, -- Ebonsteel Spaulders
				{ 2,  12554 }, -- Hands of the Exalted Herald
				{ 3,  12556 }, -- High Priestess Boots
				{ 4,  12553 }, -- Swiftwalker Boots
			},
		},
		{ -- BRDEmperorDagranThaurissan
			name = AL["Emperor Dagran Thaurissan"],
			npcID = 9019,
			Level = GetForVersion(59,56),
			SubAreaID = 26769,
			DisplayIDs = {{8807}},
			AtlasMapBossID = 21,
			[SOD_DIFF] = {
				{ 1, 227991 }, -- Ironfoe
				{ 3, 227988 }, -- Imperial Jewel
				{ 4, 227984 }, -- Thaurissan's Royal Scepter
				{ 5, 227981 }, -- Dreadforge Retaliator
				{ 6, 227980 }, -- Robes of the Royal Crown
				{ 7, 227986 }, -- Wristguards of Renown
				{ 8,  11934 }, -- Emperor's Seal
				{ 9, 227987 }, -- Sash of the Grand Hunt
				{ 10, 227985 }, -- The Emperor's New Cape
				{ 11, 227982 }, -- Guiding Stave of Wisdom
				{ 12,  11815 }, -- Hand of Justice
				{ 14, 12033 }, -- Thaurissan Family Jewels
			},
			[NORMAL_DIFF] = {
				{ 1,  11684 }, -- Ironfoe
				{ 3,  11933 }, -- Imperial Jewel
				{ 4, 11928 }, -- Thaurissan's Royal Scepter
				{ 5, 11931 }, -- Dreadforge Retaliator
				{ 6,  11924 }, -- Robes of the Royal Crown
				{ 7,  22204 }, -- Wristguards of Renown
				{ 8,  11934 }, -- Emperor's Seal
				{ 9,  22207 }, -- Sash of the Grand Hunt
				{ 10,  11930 }, -- The Emperor's New Cape
				{ 11, 11932 }, -- Guiding Stave of Wisdom
				{ 12,  11815 }, -- Hand of Justice
				{ 14, 12033 }, -- Thaurissan Family Jewels
			},
		},
		{ -- BRDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  12549 }, -- Braincage
				{ 2,  12552 }, -- Blisterbane Wrap
				{ 3,  12551 }, -- Stoneshield Cloak
				{ 4,  12542 }, -- Funeral Pyre Vestment
				{ 5,  12546 }, -- Aristocratic Cuffs
				{ 6,  12550 }, -- Runed Golem Shackles
				{ 7,  12547 }, -- Mar Alom's Grip
				{ 8,  12555 }, -- Battlechaser's Greaves
				{ 9,  12527 }, -- Ribsplitter
				{ 10, 12531 }, -- Searing Needle
				{ 11, 12535 }, -- Doomforged Straightedge
				{ 12, 12528 }, -- The Judge's Gavel
				{ 13, 12532 }, -- Spire of the Stoneshaper
				{ 16, 15781 }, -- Pattern: Black Dragonscale Leggings
				{ 17, 15770 }, -- Pattern: Black Dragonscale Shoulders
				{ 19, 11611 }, -- Plans: Dark Iron Sunderer
				{ 20, 11614 }, -- Plans: Dark Iron Mail
				{ 21, 11615 }, -- Plans: Dark Iron Shoulders
				{ 23, 16048 }, -- Schematic: Dark Iron Rifle
				{ 24, 16053 }, -- Schematic: Master Engineer's Goggles
				{ 25, 16049 }, -- Schematic: Dark Iron Bomb
				{ 26, 18654 }, -- Schematic: Gnomish Alarm-O-Bot
				{ 27, 18661 }, -- Schematic: World Enlarger
			},
		},
		{ -- BRDBSPlans
			name = AL["Plans"],
			ExtraList = true,
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1,  11614 }, -- Plans: Dark Iron Mail
				{ 2,  11615 }, -- Plans: Dark Iron Shoulders
			},
		},
		{ -- BRDTheldren
			name = AL["Theldren"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16059,
			DisplayIDs = {{15981}},
			AtlasMapBossID = 6,
			Level = 60,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  22305 }, -- Ironweave Mantle
				{ 2,  22330 }, -- Shroud of Arcane Mastery
				{ 3,  22318 }, -- Malgen's Long Bow
				{ 4,  22317 }, -- Lefty's Brass Knuckle
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, { -- BRRDCorenDirebrew
			name = AL["Coren Direbrew"],
			npcID = 23872,
			DisplayIDs = {{21824}},
			AtlasMapBossID = 15,
			Level = 82,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  49116 }, -- Bitter Balebrew Charm
				{ 2,  49118 }, -- Bubbling Brightbrew Charm
				{ 3,  49074 }, -- Coren's Chromium Coaster
				{ 4,  49076 }, -- Mithril Pocketwatch
				{ 5,  49078 }, -- Ancient Pickled Egg
				{ 6,  49080 }, -- Brawler's Souvenir
				{ 8,  49120 }, -- Direbrew's Bloody Shanker
				{ 9,  48663 }, -- Tankard O' Terror
				{ 16,  33977 }, -- Swift Brewfest Ram
				{ 17,  37828 }, -- Great Brewfest Kodo
				{ 19,  37863 }, -- Direbrew's Remote
				{ 21,  38280 }, -- Direbrew's Dire Brew
			},
        }),
	},
}

data["LowerBlackrockSpire"] = {
	name = AL["Lower Blackrock Spire"],
	MapID = 1583,
	InstanceID = 229,
	SubAreaIDs = { 26683, 26718, 26711, 26713, 26686, 32528, 26688 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "LowerBlackrockSpire",
	AtlasMapFile = {"CL_BlackrockSpireLower", "CL_BlackrockMountainEnt"},
	AtlasMapFile_AL = {"BlackrockSpireLower", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({48, 55, 60}, {45, 54, 60}),
	items = {
		{ -- LBRSFelguard
			name = AL["Burning Felguard"],
			npcID = 10263,
			Level = {56, 57},
			DisplayIDs = {{5047}},
			AtlasMapBossID = 1,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 228554 }, -- Demonskin Gloves
				{ 2, 228555 }, -- Phase Blade
			},
			[NORMAL_DIFF] = {
				{ 1,  13181 }, -- Demonskin Gloves
				{ 2,  13182 }, -- Phase Blade
			},
		},
		{ -- LBRSSpirestoneButcher
			name = AL["Spirestone Butcher"],
			npcID = 9219,
			Level = 57,
			DisplayIDs = {{11574}},
			AtlasMapBossID = 4,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 228556 }, -- Butcher's Apron
				{ 2,  13286 }, -- Rivenspike
			},
			[NORMAL_DIFF] = {
				{ 1,  12608 }, -- Butcher's Apron
				{ 2,  13286 }, -- Rivenspike
			},
		},
		{ -- LBRSOmokk
			name = AL["Highlord Omokk"],
			npcID = 9196,
			Level = GetForVersion(59,57),
			SubAreaID = 26713,
			DisplayIDs = {{11565}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1, 226752 }, -- Boots of Elements
				{ 3,  13166 }, -- Slamshot Shoulders
				{ 4, 228571 }, -- Plate of the Shaman King
				{ 5,  13170 }, -- Skyshroud Leggings
				{ 6,  13169 }, -- Tressermane Leggings
				{ 7, 228570 }, -- Fist of Omokk
				{ 8,  12336 }, -- Gemstone of Spirestone
				{ 10, 12534 }, -- Omokk's Head
			},
			[NORMAL_DIFF] = {
				{ 1,  16670 }, -- Boots of Elements
				{ 3,  13166 }, -- Slamshot Shoulders
				{ 4,  13168 }, -- Plate of the Shaman King
				{ 5,  13170 }, -- Skyshroud Leggings
				{ 6,  13169 }, -- Tressermane Leggings
				{ 7,  13167 }, -- Fist of Omokk
				{ 8,  12336 }, -- Gemstone of Spirestone
				{ 10, 12534 }, -- Omokk's Head
			},
		},
		{ -- LBRSSpirestoneBattleLord
			name = AL["Spirestone Battle Lord"],
			npcID = 9218,
			Level = 58,
			DisplayIDs = {{11576}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 228557 }, -- Swiftdart Battleboots
				{ 2,  13285 }, -- The Nicker
			},
			[NORMAL_DIFF] = {
				{ 1,  13284 }, -- Swiftdart Battleboots
				{ 2,  13285 }, -- The Nicker
			},
		},
		{ -- LBRSSpirestoneLordMagus
			name = AL["Spirestone Lord Magus"],
			npcID = 9217,
			Level = {57, 58},
			DisplayIDs = {{11578}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 228564 }, -- Ogreseer Tower Boots
				{ 2,  13283 }, -- Magus Ring
				{ 3, 228563 }, -- Globe of D'sak
			},
			[NORMAL_DIFF] = {
				{ 1,  13282 }, -- Ogreseer Tower Boots
				{ 2,  13283 }, -- Magus Ring
				{ 3,  13261 }, -- Globe of D'sak
			},
		},
		{ -- LBRSVosh
			name = AL["Shadow Hunter Vosh'gajin"],
			npcID = 9236,
			Level = 58,
			SubAreaID = 26688,
			DisplayIDs = {{9732}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 226702 }, -- Shadowcraft Gloves
				{ 3, 228562 }, -- Demonic Runed Spaulders
				{ 4, 228558 }, -- Funeral Cuffs
				{ 5, 228561 }, -- Trueaim Gauntlets
				{ 6, 12653 }, -- Riphook
				{ 7, 228559 }, -- Blackcrow
				{ 8, 12654 }, -- Doomshot
			},
			[NORMAL_DIFF] = {
				{ 1,  16712 }, -- Shadowcraft Gloves
				{ 3,  13257 }, -- Demonic Runed Spaulders
				{ 4,  12626 }, -- Funeral Cuffs
				{ 5,  13255 }, -- Trueaim Gauntlets
				{ 6,  12653 }, -- Riphook
				{ 7,  12651 }, -- Blackcrow
				{ 8,  12654 }, -- Doomshot
			},
		},
		{ -- LBRSVoone
			name = AL["War Master Voone"],
			npcID = 9237,
			Level = GetForVersion(59,58),
			SubAreaID = 26688,
			DisplayIDs = {{9733}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1, 226721 }, -- Beaststalker's Gloves
				{ 3, 228574 }, -- Talisman of Evasion
				{ 4, 228572 }, -- Brazecore Armguards
				{ 5, 228594 }, -- Kayser's Boots of Precision
				{ 6, 13173 }, -- Flightblade Throwing Axe
				{ 7, 12582 }, -- Keris of Zul'Serak
				{ 9, 12335 }, -- Gemstone of Smolderthorn
			},
			[NORMAL_DIFF] = {
				{ 1,  16676 }, -- Beaststalker's Gloves
				{ 3,  13177 }, -- Talisman of Evasion
				{ 4,  13179 }, -- Brazecore Armguards
				{ 5,  22231 }, -- Kayser's Boots of Precision
				{ 6,  13173 }, -- Flightblade Throwing Axe
				{ 7,  12582 }, -- Keris of Zul'Serak
				{ 9,  12335 }, -- Gemstone of Smolderthorn
			},
		},
	{ -- LBRSGrimaxe
			name = AL["Bannok Grimaxe"],
			npcID = 9596,
			Level = 59,
			DisplayIDs = {{9668}},
			AtlasMapBossID = 12,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 228568 }, -- Backusarian Gauntlets
				{ 2, 228567 }, -- Chiselbrand Girdle
				{ 3,  12621 }, -- Demonfork
				{ 5,  12838 }, -- Plans: Arcanite Reaper
			},
			[NORMAL_DIFF] = {
				{ 1,  12637 }, -- Backusarian Gauntlets
				{ 2,  12634 }, -- Chiselbrand Girdle
				{ 3,  12621 }, -- Demonfork
				{ 5,  12838 }, -- Plans: Arcanite Reaper
			},
		},
		{ -- LBRSSmolderweb
			name = AL["Mother Smolderweb"],
			npcID = 10596,
			Level = 59,
			SubAreaID = 26686,
			DisplayIDs = {{9929}},
			AtlasMapBossID = 13,
			[SOD_DIFF] = {
				{ 1, 226713 }, -- Wildheart Boots
				{ 3, 228577 }, -- Gilded Gauntlets
				{ 4, 228576 }, -- Smolderweb's Eye
				{ 5, 228573 }, -- Venomspitter
			},
			[NORMAL_DIFF] = {
				{ 1,  16715 }, -- Wildheart Boots
				{ 3,  13244 }, -- Gilded Gauntlets
				{ 4,  13213 }, -- Smolderweb's Eye
				{ 5,  13183 }, -- Venomspitter
			},
		},
		{ -- LBRSCrystalFang
			name = AL["Crystal Fang"],
			npcID = 10376,
			Level = 60,
			SubAreaID = 26686,
			DisplayIDs = {{9755}},
			AtlasMapBossID = 14,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 228590 }, -- Sunderseer Mantle
				{ 2, 228592 }, -- Fang of the Crystal Spider
				{ 3,  13184 }, -- Fallbrush Handgrips
			},
			[NORMAL_DIFF] = {
				{ 1,  13185 }, -- Sunderseer Mantle
				{ 2,  13184 }, -- Fallbrush Handgrips
				{ 3,  13218 }, -- Fang of the Crystal Spider
			},
		},
		{ -- LBRSDoomhowl
			name = AL["Urok Doomhowl"],
			npcID = 10584,
			Level = 60,
			DisplayIDs = {{11583}},
			AtlasMapBossID = 15,
			[SOD_DIFF] = {
				{ 1, 228595 }, -- Marksman's Girdle
				{ 2,  13258 }, -- Slaghide Gauntlets
				{ 3,  13259 }, -- Ribsteel Footguards
				{ 4,  13178 }, -- Rosewine Circle
				{ 6,  18784 }, -- Top Half of Advanced Armorsmithing: Volume III
			},
			[NORMAL_DIFF] = {
				{ 1,  13258 }, -- Slaghide Gauntlets
				{ 2,  22232 }, -- Marksman's Girdle
				{ 3,  13259 }, -- Ribsteel Footguards
				{ 4,  13178 }, -- Rosewine Circle
				{ 6,  18784 }, -- Top Half of Advanced Armorsmithing: Volume III
			},
		},
		{ -- LBRSZigris
			name = AL["Quartermaster Zigris"],
			npcID = 9736,
			Level = 59,
			SubAreaID = 32528,
			DisplayIDs = {{9738}},
			AtlasMapBossID = 16,
			[SOD_DIFF] = {
				{ 1,  13247 }, -- Quartermaster Zigris' Footlocker
				{ 3,  13253 }, -- Hands of Power
				{ 4,  13252 }, -- Cloudrunner Girdle
				{ 6,  12835 }, -- Plans: Annihilator
			},
			[NORMAL_DIFF] = {
				{ 1,  13247 }, -- Quartermaster Zigris' Footlocker
				{ 3,  13253 }, -- Hands of Power
				{ 4,  13252 }, -- Cloudrunner Girdle
				{ 6,  12835 }, -- Plans: Annihilator
			},
		},
		{ -- LBRSHalycon
			name = AL["Halycon"],
			npcID = 10220,
			Level = 59,
			SubAreaID = 26711,
			DisplayIDs = {{9567}},
			AtlasMapBossID = 17,
			[SOD_DIFF] = {
				{ 1, 228598 }, -- Ironweave Bracers
				{ 2, 228575 }, -- Slashclaw Bracers
				{ 3,  13210 }, -- Pads of the Dread Wolf
				{ 4,  13212 }, -- Halycon's Spiked Collar
			},
			[NORMAL_DIFF] = {
				{ 1,  13212 }, -- Halycon's Spiked Collar
				{ 2,  22313 }, -- Ironweave Bracers
				{ 3,  13211 }, -- Slashclaw Bracers
				{ 4,  13210 }, -- Pads of the Dread Wolf
			},
		},
		{ -- LBRSSlavener
			name = AL["Gizrul the Slavener"],
			npcID = 10268,
			Level = 60,
			SubAreaID = 26711,
			DisplayIDs = {{9564}},
			AtlasMapBossID = 17,
			[SOD_DIFF] = {
				{ 1, 226710 }, -- Wildheart Spaulders
				{ 3,  13208 }, -- Bleak Howler Armguards
				{ 4,  13206 }, -- Wolfshear Leggings
				{ 5, 228591 }, -- Rhombeard Protector
			},
			[NORMAL_DIFF] = {
				{ 1,  16718 }, -- Wildheart Spaulders
				{ 3,  13208 }, -- Bleak Howler Armguards
				{ 4,  13206 }, -- Wolfshear Leggings
				{ 5,  13205 }, -- Rhombeard Protector
			},
		},
		{ -- LBRSBashguud
			name = AL["Ghok Bashguud"],
			npcID = 9718,
			Level = 59,
			DisplayIDs = {{11809}},
			AtlasMapBossID = 18,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1,  13203 }, -- Armswake Cloak
				{ 2,  13198 }, -- Hurd Smasher
				{ 3,  13204 }, -- Bashguuder
			},
			[NORMAL_DIFF] = {
				{ 1,  13203 }, -- Armswake Cloak
				{ 2,  13198 }, -- Hurd Smasher
				{ 3,  13204 }, -- Bashguuder
			},
		},
		{ -- LBRSWyrmthalak
			name = AL["Overlord Wyrmthalak"],
			npcID = 9568,
			Level = 60,
			SubAreaID = 26718,
			DisplayIDs = {{8711}},
			AtlasMapBossID = 19,
			[SOD_DIFF] = {
				{ 1, 228585 }, -- Mark of the Dragon Lord
				{ 3, 226716 }, -- Beaststalker's Mantle
				{ 5, 228588 }, -- Reiver Claws
				{ 6, 228589 }, -- Heart of the Scale
				{ 7,  22321 }, -- Heart of Wyrmthalak
				{ 8, 228601 }, -- Relentless Scythe
				{ 9, 228586 }, -- Chillpike
				{ 10, 228587 }, -- Trindlehaven Staff
				{ 12, 12337 }, -- Gemstone of Bloodaxe
				{ 14, 12780 }, -- General Drakkisath's Command
			},
			[NORMAL_DIFF] = {
				{ 1,  13143 }, -- Mark of the Dragon Lord
				{ 3,  16679 }, -- Beaststalker's Mantle
				{ 5,  13162 }, -- Reiver Claws
				{ 6,  13164 }, -- Heart of the Scale
				{ 7,  22321 }, -- Heart of Wyrmthalak
				{ 8,  13163 }, -- Relentless Scythe
				{ 9,  13148 }, -- Chillpike
				{ 10, 13161 }, -- Trindlehaven Staff
				{ 12, 12337 }, -- Gemstone of Bloodaxe
				{ 14, 12780 }, -- General Drakkisath's Command
			},
		},
		{ -- LBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  14513 }, -- Pattern: Robe of the Archmage
				{ 3, 226744 }, -- Devout Belt
				{ 4, 226724 }, -- Magister's Belt
				{ 5, 226725 }, -- Magister's Bindings
				{ 6, 226759 }, -- Dreadmist Bracers
				{ 7, 226701 }, -- Shadowcraft Belt
				{ 8, 226712 }, -- Wildheart Belt
				{ 9, 226718 }, -- Beaststalker's Belt
				{ 10, 226754 }, -- Cord of Elements
				{ 11, 226765 }, -- Belt of Valor
				{ 12, 226766 }, -- Bracers of Valor
				{ 17, 15749 }, -- Pattern: Volcanic Breastplate
				{ 18, 15775 }, -- Pattern: Volcanic Shoulders
				{ 19, 13494 }, -- Recipe: Greater Fire Protection Potion
				{ 20, 16250 }, -- Formula: Enchant Weapon - Superior Striking
				{ 21, 16244 }, -- Formula: Enchant Gloves - Greater Strength
				{ 22, 9214 }, -- Grimoire of Inferno
				{ 24, 12219 }, -- Unadorned Seal of Ascension
				{ 25, 12586 }, -- Immature Venom Sac
			},
			[NORMAL_DIFF] = {
				{ 1,  14513 }, -- Pattern: Robe of the Archmage
				{ 3,  16696 }, -- Devout Belt
				{ 4,  16685 }, -- Magister's Belt
				{ 5,  16683 }, -- Magister's Bindings
				{ 6,  16703 }, -- Dreadmist Bracers
				{ 7,  16713 }, -- Shadowcraft Belt
				{ 8,  16716 }, -- Wildheart Belt
				{ 9,  16680 }, -- Beaststalker's Belt
				{ 10, 16673 }, -- Cord of Elements
				{ 11, 16736 }, -- Belt of Valor
				{ 12, 16735 }, -- Bracers of Valor
				{ 17, 15749 }, -- Pattern: Volcanic Breastplate
				{ 18, 15775 }, -- Pattern: Volcanic Shoulders
				{ 19, 13494 }, -- Recipe: Greater Fire Protection Potion
				{ 20, 16250 }, -- Formula: Enchant Weapon - Superior Striking
				{ 21, 16244 }, -- Formula: Enchant Gloves - Greater Strength
				{ 22, 9214 }, -- Grimoire of Inferno
				{ 24, 12219 }, -- Unadorned Seal of Ascension
				{ 25, 12586 }, -- Immature Venom Sac
			},
		},
		{ -- LBRSGrayhoof
			name = AL["Mor Grayhoof"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16080,
			DisplayIDs = {{15997}},
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1, 228596 }, -- Ironweave Belt
				{ 2,  22325 }, -- Belt of the Trickster
				{ 3,  22319 }, -- Tome of Divine Right
				{ 4,  22398 }, -- Idol of Rejuvenation
				{ 5, 228600 }, -- The Jaw Breaker
			},
			[NORMAL_DIFF] = {
				{ 1,  22306 }, -- Ironweave Belt
				{ 2,  22325 }, -- Belt of the Trickster
				{ 3,  22319 }, -- Tome of Divine Right
				{ 4,  22398 }, -- Idol of Rejuvenation
				{ 5,  22322 }, -- The Jaw Breaker
			},
		},
	},
}

data["UpperBlackrockSpire"] = {
	name = AL["Upper Blackrock Spire"],
	MapID = 1583,
	InstanceID = 229,
	SubAreaIDs = { 26670, 26668, 26684, 26662, 26642, 26683, 15492, 26666, 26715 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "UpperBlackrockSpire",
	AtlasMapFile = {"CL_BlackrockSpireUpper", "CL_BlackrockMountainEnt"},
	AtlasMapFile_AL = {"BlackrockSpireUpper", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({48, 55, 60}, {45, 58, 60}),
	items = {
		{ -- UBRSEmberseer
			name = AL["Pyroguard Emberseer"],
			npcID = 9816,
			Level = 60,
			SubAreaID = 26662,
			DisplayIDs = {{2172}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1, 226748 }, -- Gauntlets of Elements
				{ 3, 228584 }, -- Emberfury Talisman
				{ 4, 228583 }, -- Truestrike Shoulders
				{ 5,  12905 }, -- Wildfire Cape
				{ 6,  12926 }, -- Flaming Band
				{ 8,  23320 }, -- Tablet of Flame Shock VI
			},
			[NORMAL_DIFF] = {
				{ 1,  16672 }, -- Gauntlets of Elements
				{ 3,  12929 }, -- Emberfury Talisman
				{ 4,  12927 }, -- Truestrike Shoulders
				{ 5,  12905 }, -- Wildfire Cape
				{ 6,  12926 }, -- Flaming Band
				{ 8,  23320 }, -- Tablet of Flame Shock VI
			},
		},
		{ -- UBRSSolakar
			name = AL["Solakar Flamewreath"],
			npcID = 10264,
			Level = 60,
			SubAreaID = 26666,
			DisplayIDs = {{9581}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1, 226741 }, -- Devout Mantle
				{ 3,  12609 }, -- Polychromatic Visionwrap
				{ 4,  12603 }, -- Nightbrace Tunic
				{ 5, 228578 }, -- Dustfeather Sash
				{ 6, 228579 }, -- Crystallized Girdle
				{ 8,  18657 }, -- Schematic: Hyper-Radiant Flame Reflector
			},
			[NORMAL_DIFF] = {
				{ 1,  16695 }, -- Devout Mantle
				{ 3,  12609 }, -- Polychromatic Visionwrap
				{ 4,  12603 }, -- Nightbrace Tunic
				{ 5,  12589 }, -- Dustfeather Sash
				{ 6,  12606 }, -- Crystallized Girdle
				{ 8,  18657 }, -- Schematic: Hyper-Radiant Flame Reflector
			},
		},
		{ -- UBRSRunewatcher
			name = AL["Jed Runewatcher"],
			npcID = 10509,
			Level = 59,
			SubAreaID = 26642,
			DisplayIDs = {{9686}},
			AtlasMapBossID = 4,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 228566 }, -- Starfire Tiara
				{ 2,  12930 }, -- Briarwood Reed
				{ 3,  12605 }, -- Serpentine Skuller
			},
			[NORMAL_DIFF] = {
				{ 1,  12604 }, -- Starfire Tiara
				{ 2,  12930 }, -- Briarwood Reed
				{ 3,  12605 }, -- Serpentine Skuller
			},
		},
		{ -- UBRSAnvilcrack
			name = AL["Goraluk Anvilcrack "],
			npcID = 10899,
			Level = 61,
			SubAreaID = 26642,
			DisplayIDs = {{10222}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1,  13502 }, -- Handcrafted Mastersmith Girdle
				{ 2,  13498 }, -- Handcrafted Mastersmith Leggings
				{ 3, 228602 }, -- Flame Walkers
				{ 4,  18048 }, -- Mastersmith's Hammer
				{ 6,  12834 }, -- Plans: Arcanite Champion
				{ 7,  12837 }, -- Plans: Masterwork Stormhammer
				{ 9, 18779 }, -- Bottom Half of Advanced Armorsmithing: Volume I
				{ 11, "INV_Box_01", nil, AL["Unforged Rune Covered Breastplate"], nil },
				{ 12, 12806 }, -- Unforged Rune Covered Breastplate
				{ 13, 12696 }, -- Plans: Demon Forged Breastplate
			},
			[NORMAL_DIFF] = {
				{ 1,  13502 }, -- Handcrafted Mastersmith Girdle
				{ 2,  13498 }, -- Handcrafted Mastersmith Leggings
				{ 3,  18047 }, -- Flame Walkers
				{ 4,  18048 }, -- Mastersmith's Hammer
				{ 6,  12834 }, -- Plans: Arcanite Champion
				{ 7,  12837 }, -- Plans: Masterwork Stormhammer
				{ 9, 18779 }, -- Bottom Half of Advanced Armorsmithing: Volume I
				{ 11, "INV_Box_01", nil, AL["Unforged Rune Covered Breastplate"], nil },
				{ 12, 12806 }, -- Unforged Rune Covered Breastplate
				{ 13, 12696 }, -- Plans: Demon Forged Breastplate
			},
		},
		{ -- UBRSGyth
			name = AL["Gyth"],
			npcID = 10339,
			Level = 62,
			SubAreaID = 26670,
			DisplayIDs = {{9806}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  12871 }, -- Chromatic Carapace
				{ 3, 226753 }, -- Pauldrons of Elements
				{ 5,  22225 }, -- Dragonskin Cowl
				{ 6,  12960 }, -- Tribal War Feathers
				{ 7,  12953 }, -- Dragoneye Coif
				{ 8,  12952 }, -- Gyth's Skull
				{ 10,  13522 }, -- Recipe: Flask of Chromatic Resistance
			},
			[NORMAL_DIFF] = {
				{ 1,  12871 }, -- Chromatic Carapace
				{ 3,  16669 }, -- Pauldrons of Elements
				{ 5,  22225 }, -- Dragonskin Cowl
				{ 6,  12960 }, -- Tribal War Feathers
				{ 7,  12953 }, -- Dragoneye Coif
				{ 8,  12952 }, -- Gyth's Skull
				{ 10, 13522 }, -- Recipe: Flask of Chromatic Resistance
			},
		},
		{ -- UBRSRend
			name = AL["Warchief Rend Blackhand"],
			npcID = 10429,
			Level = 62,
			SubAreaID = 26670,
			DisplayIDs = {{9778}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 228757 }, -- Felstriker
				{ 3, 226768 }, -- Spaulders of Valor
				{ 5, 228604 }, -- Eye of Rend
				{ 6, 228605 }, -- Bonespike Shoulder
				{ 7,  12936 }, -- Battleborn Armbraces
				{ 8,  18104 }, -- Feralsurge Girdle
				{ 9,  12935 }, -- Warmaster Legguards
				{ 10, 18102 }, -- Dragonrider Boots
				{ 11, 22247 }, -- Faith Healer's Boots
				{ 12, 18103 }, -- Band of Rumination
				{ 13, 12940 }, -- Dal'Rend's Sacred Charge
				{ 14, 12939 }, -- Dal'Rend's Tribal Guardian
				{ 15, 228603 }, -- Blackhand Doomsaw
			},
			[NORMAL_DIFF] = {
				{ 1,  12590 }, -- Felstriker
				{ 3,  16733 }, -- Spaulders of Valor
				{ 5,  12587 }, -- Eye of Rend
				{ 6,  12588 }, -- Bonespike Shoulder
				{ 7,  12936 }, -- Battleborn Armbraces
				{ 8,  18104 }, -- Feralsurge Girdle
				{ 9,  12935 }, -- Warmaster Legguards
				{ 10, 18102 }, -- Dragonrider Boots
				{ 11, 22247 }, -- Faith Healer's Boots
				{ 12, 18103 }, -- Band of Rumination
				{ 13, 12940 }, -- Dal'Rend's Sacred Charge
				{ 14, 12939 }, -- Dal'Rend's Tribal Guardian
				{ 15, 12583 }, -- Blackhand Doomsaw
			},
		},
		{ -- UBRSBeast
			name = AL["The Beast"],
			npcID = 10430,
			Level = 62,
			SubAreaID = 26684,
			DisplayIDs = {{10193}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1,  12731 }, -- Pristine Hide of the Beast
				{ 2, 226735 }, -- Lightforge Spaulders
				{ 4,  12967 }, -- Bloodmoon Cloak
				{ 5,  12968 }, -- Frostweaver Cape
				{ 6,  12966 }, -- Blackmist Armguards
				{ 7,  12965 }, -- Spiritshroud Leggings
				{ 8,  12963 }, -- Blademaster Leggings
				{ 9, 12964 }, -- Tristam Legguards
				{ 10, 228597 }, -- Ironweave Boots
				{ 11, 12709 }, -- Finkle's Skinner
				{ 12, 12969 }, -- Seeping Willow
				{ 14, 24101 }, -- Book of Ferocious Bite V
				{ 15, 19227 }, -- Ace of Beasts
			},
			[NORMAL_DIFF] = {
				{ 1,  12731 }, -- Pristine Hide of the Beast
				{ 2,  16729 }, -- Lightforge Spaulders
				{ 4,  12967 }, -- Bloodmoon Cloak
				{ 5,  12968 }, -- Frostweaver Cape
				{ 6,  12966 }, -- Blackmist Armguards
				{ 7,  12965 }, -- Spiritshroud Leggings
				{ 8,  12963 }, -- Blademaster Leggings
				{ 9, 12964 }, -- Tristam Legguards
				{ 10, 22311 }, -- Ironweave Boots
				{ 11, 12709 }, -- Finkle's Skinner
				{ 12, 12969 }, -- Seeping Willow
				{ 14, 24101 }, -- Book of Ferocious Bite V
				{ 15, 19227 }, -- Ace of Beasts
			},
		},
		{ -- UBRSDrakkisath
			name = AL["General Drakkisath"],
			npcID = 10363,
			Level = 62,
			SubAreaID = 26715,
			DisplayIDs = {{10115}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1, 228606 }, -- Blackblade of Shahram
				{ 3,  22267 }, -- Spellweaver's Turban
				{ 4,  13141 }, -- Tooth of Gnarr
				{ 5,  22269 }, -- Shadow Prowler's Cloak
				{ 6,  13142 }, -- Brigam Girdle
				{ 7,  13098 }, -- Painweaver Band
				{ 8,  22268 }, -- Draconic Infused Emblem
				{ 9,  22253 }, -- Tome of the Lost
				{ 10, 12602 }, -- Draconian Deflector
				{ 12, 15730 }, -- Pattern: Red Dragonscale Breastplate
				{ 14, 13519 }, -- Recipe: Flask of the Titans
				{ 19, 226745 }, -- Devout Robe
				{ 20, 226729 }, -- Magister's Robes
				{ 21, 226757 }, -- Dreadmist Robe
				{ 22, 226700 }, -- Shadowcraft Tunic
				{ 23, 226715 }, -- Wildheart Vest
				{ 24, 226723 }, -- Beaststalker's Tunic
				{ 25, 226749 }, -- Vest of Elements
				{ 26, 226734 }, -- Lightforge Breastplate
				{ 27, 226770 }, -- Breastplate of Valor
			},
			[NORMAL_DIFF] = {
				{ 1,  12592 }, -- Blackblade of Shahram
				{ 3,  22267 }, -- Spellweaver's Turban
				{ 4,  13141 }, -- Tooth of Gnarr
				{ 5,  22269 }, -- Shadow Prowler's Cloak
				{ 6,  13142 }, -- Brigam Girdle
				{ 7,  13098 }, -- Painweaver Band
				{ 8,  22268 }, -- Draconic Infused Emblem
				{ 9,  22253 }, -- Tome of the Lost
				{ 10, 12602 }, -- Draconian Deflector
				{ 12, 15730 }, -- Pattern: Red Dragonscale Breastplate
				{ 14, 13519 }, -- Recipe: Flask of the Titans
				{ 19, 16690 }, -- Devout Robe
				{ 20, 16688 }, -- Magister's Robes
				{ 21, 16700 }, -- Dreadmist Robe
				{ 22, 16721 }, -- Shadowcraft Tunic
				{ 23, 16706 }, -- Wildheart Vest
				{ 24, 16674 }, -- Beaststalker's Tunic
				{ 25, 16666 }, -- Vest of Elements
				{ 26, 16726 }, -- Lightforge Breastplate
				{ 27, 16730 }, -- Breastplate of Valor
			},
		},
		{ -- UBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  24102 }, -- Manual of Eviscerate IX
				{ 2, 228593 }, -- Wind Dancer Boots
				{ 4, 226744 }, -- Devout Belt
				{ 5, 226725 }, -- Magister's Bindings
				{ 6, 226759 }, -- Dreadmist Bracers
				{ 7, 226701 }, -- Shadowcraft Belt
				{ 8, 226717 }, -- Beaststalker's Bindings
				{ 9, 226718 }, -- Beaststalker's Belt
				{ 10, 226754 }, -- Cord of Elements
				{ 11, 226766 }, -- Bracers of Valor
				{ 13, 16247 }, -- Formula: Enchant 2H Weapon - Superior Impact
			},
			[NORMAL_DIFF] = {
				{ 1,  24102 }, -- Manual of Eviscerate IX
				{ 2,  13260 }, -- Wind Dancer Boots
				{ 4,  16696 }, -- Devout Belt
				{ 5,  16683 }, -- Magister's Bindings
				{ 6,  16703 }, -- Dreadmist Bracers
				{ 7,  16713 }, -- Shadowcraft Belt
				{ 8,  16681 }, -- Beaststalker's Bindings
				{ 9,  16680 }, -- Beaststalker's Belt
				{ 10, 16673 }, -- Cord of Elements
				{ 11, 16735 }, -- Bracers of Valor
				{ 13, 16247 }, -- Formula: Enchant 2H Weapon - Superior Impact
			},
		},
		{
			name = AL["Darkstone Tablet"],
			ExtraList = true,
			AtlasMapBossID = 3,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  12358 }, -- Darkstone Tablet
			},
		},
		{ -- UBRSValthalak
			name = AL["Lord Valthalak"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16042,
			DisplayIDs = {{14308}},
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1, 228681 }, -- Ironweave Cowl
				{ 2,  22340 }, -- Pendant of Celerity
				{ 3,  22337 }, -- Shroud of Domination
				{ 4,  22343 }, -- Handguards of Savagery
				{ 5,  22342 }, -- Leggings of Torment
				{ 6,  22339 }, -- Rune Band of Wizardry
				{ 7,  22336 }, -- Draconian Aegis of the Legion
				{ 8,  22335 }, -- Lord Valthalak's Staff of Command
			},
			[NORMAL_DIFF] = {
				{ 1,  22302 }, -- Ironweave Cowl
				{ 2,  22340 }, -- Pendant of Celerity
				{ 3,  22337 }, -- Shroud of Domination
				{ 4,  22343 }, -- Handguards of Savagery
				{ 5,  22342 }, -- Leggings of Torment
				{ 6,  22339 }, -- Rune Band of Wizardry
				{ 7,  22336 }, -- Draconian Aegis of the Legion
				{ 8,  22335 }, -- Lord Valthalak's Staff of Command
			},
		},
	},
}

data["DireMaulEast"] = {
	name = AL["Dire Maul East"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 34776, 33730 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaul",
	AtlasMapFile = {"DireMaulEast", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = {31, 55, 60},
	items = {
		{ -- DMEPusillin
			name = AL["Pusillin"],
			npcID = 14354,
			Level = 57,
			DisplayIDs = {{7552}},
			AtlasMapBossID = "1-2",
			[SOD_DIFF] = {
				{ 1,  18267 }, -- Recipe: Runn Tum Tuber Surprise
				{ 3,  18249 }, -- Crescent Key
			},
			[NORMAL_DIFF] = {
				{ 1,  18267 }, -- Recipe: Runn Tum Tuber Surprise
				{ 3,  18249 }, -- Crescent Key
			},
		},
		{ -- DMEZevrimThornhoof
			name = AL["Zevrim Thornhoof"],
			npcID = 11490,
			Level = 57,
			DisplayIDs = {{11335}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 228053 }, -- Fervent Helm
				{ 2, 18313 }, -- Helm of Awareness
				{ 3, 228050 }, -- Satyr's Bow
				{ 5, 18308 }, -- Clever Hat
				{ 6, 18306 }, -- Gloves of Shadowy Mist
			},
			[NORMAL_DIFF] = {
				{ 1,  18319 }, -- Fervent Helm
				{ 2,  18313 }, -- Helm of Awareness
				{ 3,  18323 }, -- Satyr's Bow
				{ 5,  18308 }, -- Clever Hat
				{ 6,  18306 }, -- Gloves of Shadowy Mist
			},
		},
		{ -- DMEHydro
			name = AL["Hydrospawn"],
			npcID = 13280,
			Level = 57,
			DisplayIDs = {{5489}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 228054 }, -- Tempest Talisman
				{ 2, 18322 }, -- Waterspout Boots
				{ 3, 228052 }, -- Waveslicer
				{ 5, 19268 }, -- Ace of Elementals
				{ 7, 18305 }, -- Breakwater Legguards
				{ 8, 18307 }, -- Riptide Shoes
			},
			[NORMAL_DIFF] = {
				{ 1,  18317 }, -- Tempest Talisman
				{ 2,  18322 }, -- Waterspout Boots
				{ 3,  18324 }, -- Waveslicer
				{ 5,  19268 }, -- Ace of Elementals
				{ 7,  18305 }, -- Breakwater Legguards
				{ 8,  18307 }, -- Riptide Shoes
			},
		},
		{ -- DMELethtendris
			name = AL["Lethtendris"],
			npcID = 14327,
			Level = 57,
			DisplayIDs = {{14378}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 18325 }, -- Felhide Cap
				{ 2, 228051 }, -- Quel'dorai Channeling Rod
				{ 4, 18301 }, -- Lethtendris's Wand
				{ 5, 18302 }, -- Band of Vigor
			},
			[NORMAL_DIFF] = {
				{ 1,  18325 }, -- Felhide Cap
				{ 2,  18311 }, -- Quel'dorai Channeling Rod
				{ 4,  18301 }, -- Lethtendris's Wand
				{ 5,  18302 }, -- Band of Vigor
			},
		},
		{ -- DMEAlzzin
			name = AL["Alzzin the Wildshaper"],
			npcID = 11492,
			Level = 58,
			DisplayIDs = {{14416}},
			AtlasMapBossID = 5,
			SubAreaID = 33730,
			[SOD_DIFF] = {
				{ 1, 18328 }, -- Shadewood Cloak
				{ 2, 228055 }, -- Energized Chestplate
				{ 3, 18309 }, -- Gloves of Restoration
				{ 4, 18326 }, -- Razor Gauntlets
				{ 5, 18327 }, -- Whipvine Cord
				{ 6, 18318 }, -- Merciful Greaves
				{ 7, 18321 }, -- Energetic Rod
				{ 8, 228056 }, -- Fiendish Machete
				{ 9, 18314 }, -- Ring of Demonic Guile
				{ 10, 228057 }, -- Ring of Demonic Potency
			},
			[NORMAL_DIFF] = {
				{ 1,  18328 }, -- Shadewood Cloak
				{ 2,  18312 }, -- Energized Chestplate
				{ 3,  18309 }, -- Gloves of Restoration
				{ 4,  18326 }, -- Razor Gauntlets
				{ 5,  18327 }, -- Whipvine Cord
				{ 6,  18318 }, -- Merciful Greaves
				{ 7,  18321 }, -- Energetic Rod
				{ 8,  18310 }, -- Fiendish Machete
				{ 9,  18314 }, -- Ring of Demonic Guile
				{ 10, 18315 }, -- Ring of Demonic Potency
			},
		},
		{ -- DMETrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 18289 }, -- Barbed Thorn Necklace
				{ 2, 18296 }, -- Marksman Bands
				{ 3, 18298 }, -- Unbridled Leggings
				{ 4, 18295 }, -- Phasing Boots
				{ 6, 18333 }, -- Libram of Focus
				{ 7, 18334 }, -- Libram of Protection
				{ 8, 18332 }, -- Libram of Rapidity
				{ 10, 18255 }, -- Runn Tum Tuber
				{ 11, 18297 }, -- Thornling Seed
			},
			[NORMAL_DIFF] = {
				{ 1,  18289 }, -- Barbed Thorn Necklace
				{ 2,  18296 }, -- Marksman Bands
				{ 3,  18298 }, -- Unbridled Leggings
				{ 4,  18295 }, -- Phasing Boots
				{ 6,  18333 }, -- Libram of Focus
				{ 7,  18334 }, -- Libram of Protection
				{ 8,  18332 }, -- Libram of Rapidity
				{ 10, 18255 }, -- Runn Tum Tuber
				{ 11, 18297 }, -- Thornling Seed
			},
		},
		{ -- DMEIsalien
			name = AL["Isalien"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16097,
			DisplayIDs = {{16000}},
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1, 228066 }, -- Ironweave Gloves
				{ 2, 22472 }, -- Boots of Ferocity
				{ 3, 22401 }, -- Libram of Hope
				{ 4, 22345 }, -- Totem of Rebirth
				{ 5, 22315 }, -- Hammer of Revitalization
				{ 6, 22314 }, -- Huntsman's Harpoon
			},
			[NORMAL_DIFF] = {
				{ 1,  22304 }, -- Ironweave Gloves
				{ 2,  22472 }, -- Boots of Ferocity
				{ 3,  22401 }, -- Libram of Hope
				{ 4,  22345 }, -- Totem of Rebirth
				{ 5,  22315 }, -- Hammer of Revitalization
				{ 6,  22314 }, -- Huntsman's Harpoon
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["DireMaulWest"] = {
	name = AL["Dire Maul West"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 33748, 33749, 33750, 33710 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaul",
	AtlasMapFile = {"DireMaulWest", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = {31, 58, 60},
	items = {
		{ -- DMWTendrisWarpwood
			name = AL["Tendris Warpwood"],
			npcID = 11489,
			Level = 60,
			DisplayIDs = {{14383}},
			AtlasMapBossID = 2,
			SubAreaID = 33748,
			[SOD_DIFF] = {
				{ 1, 228063 }, -- Warpwood Binding
				{ 2, 18390 }, -- Tanglemoss Leggings
				{ 4, 18352 }, -- Petrified Bark Shield
				{ 5, 18353 }, -- Stoneflower Staff
			},
			[NORMAL_DIFF] = {
				{ 1, 18393 }, -- Warpwood Binding
				{ 2, 18390 }, -- Tanglemoss Leggings
				{ 4, 18352 }, -- Petrified Bark Shield
				{ 5, 18353 }, -- Stoneflower Staff
			},
		},
		{ -- DMWIllyannaRavenoak
			name = AL["Illyanna Ravenoak"],
			npcID = 11488,
			Level = 60,
			DisplayIDs = {{11270}},
			SubAreaID = 33749,
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 18383 }, -- Force Imbued Gauntlets
				{ 2, 18386 }, -- Padre's Trousers
				{ 4, 18349 }, -- Gauntlets of Accuracy
				{ 5, 18347 }, -- Well Balanced Axe
			},
			[NORMAL_DIFF] = {
				{ 1, 18383 }, -- Force Imbued Gauntlets
				{ 2, 18386 }, -- Padre's Trousers
				{ 4, 18349 }, -- Gauntlets of Accuracy
				{ 5, 18347 }, -- Well Balanced Axe
			},
		},
		{ -- DMWMagisterKalendris
			name = AL["Magister Kalendris"],
			npcID = 11487,
			Level = 60,
			DisplayIDs = {{14384}},
			AtlasMapBossID = 4,
			SubAreaID = 33749,
			[SOD_DIFF] = {
				{ 1, 18374 }, -- Flamescarred Shoulders
				{ 2, 228067 }, -- Elder Magus Pendant
				{ 3, 18371 }, -- Mindtap Talisman
				{ 5, 18350 }, -- Amplifying Cloak
				{ 6, 18351 }, -- Magically Sealed Bracers
				{ 8, 22309 }, -- Pattern: Big Bag of Enchantment
			},
			[NORMAL_DIFF] = {
				{ 1, 18374 }, -- Flamescarred Shoulders
				{ 2, 18397 }, -- Elder Magus Pendant
				{ 3, 18371 }, -- Mindtap Talisman
				{ 5, 18350 }, -- Amplifying Cloak
				{ 6, 18351 }, -- Magically Sealed Bracers
				{ 8, 22309 }, -- Pattern: Big Bag of Enchantment
				--{ 9, 22249 }, -- Big Bag of Enchantment
			},
		},
		{ -- DMWTsuzee
			name = AL["Tsu'zee"],
			npcID = 11467,
			Level = 60,
			DisplayIDs = {{11250}},
			specialType = "rare",
			AtlasMapBossID = 5,
			SubAreaID = 33749,
			[SOD_DIFF] = {
				{ 1, 228061 }, -- Brightspark Gloves
				{ 3, 18346 }, -- Threadbare Trousers
				{ 4, 18345 }, -- Murmuring Ring
			},
			[NORMAL_DIFF] = {
				{ 1, 18387 }, -- Brightspark Gloves
				{ 3, 18346 }, -- Threadbare Trousers
				{ 4, 18345 }, -- Murmuring Ring
			},
		},
		{ -- DMWImmolthar
			name = AL["Immol'thar"],
			npcID = 11496,
			Level = 61,
			DisplayIDs = {{14173}},
			AtlasMapBossID = 6,
			SubAreaID = 33750,
			[SOD_DIFF] = {
				{ 1, 18381 }, -- Evil Eye Pendant
				{ 2, 18384 }, -- Bile-etched Spaulders
				{ 3, 18389 }, -- Cloak of the Cosmos
				{ 4, 18385 }, -- Robe of Everlasting Night
				{ 5, 18394 }, -- Demon Howl Wristguards
				{ 6, 18377 }, -- Quickdraw Gloves
				{ 7, 18391 }, -- Eyestalk Cord
				{ 8, 18379 }, -- Odious Greaves
				{ 9, 18370 }, -- Vigilance Charm
				{ 10, 18372 }, -- Blade of the New Moon
			},
			[NORMAL_DIFF] = {
				{ 1, 18381 }, -- Evil Eye Pendant
				{ 2, 18384 }, -- Bile-etched Spaulders
				{ 3, 18389 }, -- Cloak of the Cosmos
				{ 4, 18385 }, -- Robe of Everlasting Night
				{ 5, 18394 }, -- Demon Howl Wristguards
				{ 6, 18377 }, -- Quickdraw Gloves
				{ 7, 18391 }, -- Eyestalk Cord
				{ 8, 18379 }, -- Odious Greaves
				{ 9, 18370 }, -- Vigilance Charm
				{ 10, 18372 }, -- Blade of the New Moon
			},
		},
		{ -- DMWPrinceTortheldrin
			name = AL["Prince Tortheldrin"],
			npcID = 11486,
			Level = 61,
			DisplayIDs = {{11256}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 18382 }, -- Fluctuating Cloak
				{ 2, 18373 }, -- Chestplate of Tranquility
				{ 3, 18375 }, -- Bracers of the Eclipse
				{ 4, 18378 }, -- Silvermoon Leggings
				{ 5, 228069 }, -- Eldritch Reinforced Legplates
				{ 6, 18395 }, -- Emerald Flame Ring
				{ 7, 228471 }, -- Stoneshatter
				{ 8, 18396 }, -- Mind Carver
				{ 9, 18376 }, -- Timeworn Mace
				{ 10, 228472 }, -- Distracting Dagger
			},
			[NORMAL_DIFF] = {
				{ 1, 18382 }, -- Fluctuating Cloak
				{ 2, 18373 }, -- Chestplate of Tranquility
				{ 3, 18375 }, -- Bracers of the Eclipse
				{ 4, 18378 }, -- Silvermoon Leggings
				{ 5, 18380 }, -- Eldritch Reinforced Legplates
				{ 6, 18395 }, -- Emerald Flame Ring
				{ 7, 18388 }, -- Stoneshatter
				{ 8, 18396 }, -- Mind Carver
				{ 9, 18376 }, -- Timeworn Mace
				{ 10, 18392 }, -- Distracting Dagger
			},
		},
		{ -- DMWTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 18340 }, -- Eidolon Talisman
				{ 2, 18344 }, -- Stonebark Gauntlets
				{ 3, 18338 }, -- Wand of Arcane Potency
				{ 5, 18333 }, -- Libram of Focus
				{ 6, 18334 }, -- Libram of Protection
				{ 7, 18332 }, -- Libram of Rapidity
			},
			[NORMAL_DIFF] = {
				{ 1, 18340 }, -- Eidolon Talisman
				{ 2, 18344 }, -- Stonebark Gauntlets
				{ 3, 18338 }, -- Wand of Arcane Potency
				{ 5, 18333 }, -- Libram of Focus
				{ 6, 18334 }, -- Libram of Protection
				{ 7, 18332 }, -- Libram of Rapidity
			},
		},
		{ -- DMWRevanchion
			name = AL["Revanchion"],
			npcID = 14690,
			DisplayIDs = {{14695}},
			AtlasMapBossID = 2,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 23127 }, -- Cloak of Revanchion
				{ 2, 23129 }, -- Bracers of Mending
				{ 3, 23128 }, -- The Shadow's Grasp
			},
			[NORMAL_DIFF] = {
				{ 1, 23127 }, -- Cloak of Revanchion
				{ 2, 23129 }, -- Bracers of Mending
				{ 3, 23128 }, -- The Shadow's Grasp
			},
		},
		{ -- DMWShendralarProvisioner
			name = AL["Shen'dralar Provisioner"],
			npcID = 14371,
			DisplayIDs = {{14412}},
			ExtraList = true,
			AtlasMapBossID = "1'",
			IgnoreAsSource = true,
			[SOD_DIFF] = {
				{ 1, 18487, [PRICE_EXTRA_ITTYPE] = "money:40000" }, -- Pattern: Mooncloth Robe
			},
			[NORMAL_DIFF] = {
				{ 1, 18487, [PRICE_EXTRA_ITTYPE] = "money:40000" }, -- Pattern: Mooncloth Robe
			},
		},
		{ -- DMWHelnurath
			name = AL["Lord Hel'nurath"],
			npcID = 14506,
			DisplayIDs = {{14556}},
			ExtraList = true,
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 228475 }, -- Diabolic Mantle
				{ 2, 18754 }, -- Fel Hardened Bracers
				{ 3, 18755 }, -- Xorothian Firestick
				{ 4, 18756 }, -- Dreadguard's Protector
			},
			[NORMAL_DIFF] = {
				{ 1, 18757 }, -- Diabolic Mantle
				{ 2, 18754 }, -- Fel Hardened Bracers
				{ 3, 18755 }, -- Xorothian Firestick
				{ 4, 18756 }, -- Dreadguard's Protector
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["DireMaulNorth"] = {
	name = AL["Dire Maul North"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 33774, 33775 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaulNorth",
	AtlasMapFile = {"DireMaulNorth", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LevelRange = {31, 58, 60},
	items = {
		{ -- DMNGuardMoldar
			name = AL["Guard Mol'dar"],
			npcID = 14326,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1, 228058 }, -- Bulky Iron Spaulders
				{ 2, 228059 }, -- Denwatcher's Shoulders
				{ 3, 228060 }, -- Heliotrope Cloak
				{ 4, 18497 }, -- Sublime Wristguards
				{ 5, 18498 }, -- Hedgecutter
				{ 6, 18450 }, -- Robe of Combustion
				{ 7, 18458 }, -- Modest Armguards
				{ 8, 18459 }, -- Gallant's Wristguards
				{ 9, 18451 }, -- Hyena Hide Belt
				{ 10, 18462 }, -- Jagged Bone Fist
				{ 11, 18463 }, -- Ogre Pocket Knife
				{ 12, 18464 }, -- Gordok Nose Ring
				{ 13, 18460 }, -- Unsophisticated Hand Cannon
				{ 14, 18250 }, -- Gordok Shackle Key
				{ 15, 18268 }, -- Gordok Inner Door Key
			},
			[NORMAL_DIFF] = {
				{ 1, 18494 }, -- Denwatcher's Shoulders
				{ 2, 18493 }, -- Bulky Iron Spaulders
				{ 3, 18496 }, -- Heliotrope Cloak
				{ 4, 18497 }, -- Sublime Wristguards
				{ 5, 18498 }, -- Hedgecutter
				{ 6, 18450 }, -- Robe of Combustion
				{ 7, 18458 }, -- Modest Armguards
				{ 8, 18459 }, -- Gallant's Wristguards
				{ 9, 18451 }, -- Hyena Hide Belt
				{ 10, 18462 }, -- Jagged Bone Fist
				{ 11, 18463 }, -- Ogre Pocket Knife
				{ 12, 18464 }, -- Gordok Nose Ring
				{ 13, 18460 }, -- Unsophisticated Hand Cannon
				{ 14, 18250 }, -- Gordok Shackle Key
				{ 15, 18268 }, -- Gordok Inner Door Key
			},
		},
		{ -- DMNStomperKreeg
			name = AL["Stomper Kreeg"],
			npcID = 14322,
			Level = 59,
			DisplayIDs = {{11545}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1, 18425 }, -- Kreeg's Mug
				{ 16, "INV_Box_01", nil, AL["Sells:"], nil },
				{ 17, 18269, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Gordok Green Grog
				{ 18, 18284, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Kreeg's Stout Beatdown
				{ 19, 18287, [PRICE_EXTRA_ITTYPE] = "money:200" }, -- Evermurky
				{ 20, 18288, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Molasses Firewater
				{ 21, 9260, [PRICE_EXTRA_ITTYPE] = "money:1600" }, -- Volatile Rum
			},
			[NORMAL_DIFF] = {
				{ 1, 18425 }, -- Kreeg's Mug
				{ 16, "INV_Box_01", nil, AL["Sells:"], nil },
				{ 17, 18269, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Gordok Green Grog
				{ 18, 18284, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Kreeg's Stout Beatdown
				{ 19, 18287, [PRICE_EXTRA_ITTYPE] = "money:200" }, -- Evermurky
				{ 20, 18288, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Molasses Firewater
				{ 21, 9260, [PRICE_EXTRA_ITTYPE] = "money:1600" }, -- Volatile Rum
			},
		},
		{ -- DMNGuardFengus
			name = AL["Guard Fengus"],
			npcID = 14321,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 18450 }, -- Robe of Combustion
				{ 2, 18458 }, -- Modest Armguards
				{ 3, 18459 }, -- Gallant's Wristguards
				{ 4, 18451 }, -- Hyena Hide Belt
				{ 5, 18462 }, -- Jagged Bone Fist
				{ 6, 18463 }, -- Ogre Pocket Knife
				{ 7, 18464 }, -- Gordok Nose Ring
				{ 8, 18460 }, -- Unsophisticated Hand Cannon
				{ 10, 18250 }, -- Gordok Shackle Key
				{ 16, "INV_Box_01", nil, AL["Fengus's Chest"], nil },
				{ 17, 18266 }, -- Gordok Courtyard Key
			},
			[NORMAL_DIFF] = {
				{ 1, 18450 }, -- Robe of Combustion
				{ 2, 18458 }, -- Modest Armguards
				{ 3, 18459 }, -- Gallant's Wristguards
				{ 4, 18451 }, -- Hyena Hide Belt
				{ 5, 18462 }, -- Jagged Bone Fist
				{ 6, 18463 }, -- Ogre Pocket Knife
				{ 7, 18464 }, -- Gordok Nose Ring
				{ 8, 18460 }, -- Unsophisticated Hand Cannon
				{ 10, 18250 }, -- Gordok Shackle Key
				{ 16, "INV_Box_01", nil, AL["Fengus's Chest"], nil },
				{ 17, 18266 }, -- Gordok Courtyard Key
			},
		},
		{ -- DMNGuardSlipkik
			name = AL["Guard Slip'kik"],
			npcID = 14323,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1, 228060 }, -- Heliotrope Cloak
				{ 2, 228059 }, -- Denwatcher's Shoulders
				{ 3, 228058 }, -- Bulky Iron Spaulders
				{ 4, 18497 }, -- Sublime Wristguards
				{ 5, 18498 }, -- Hedgecutter
				{ 6, 18450 }, -- Robe of Combustion
				{ 7, 18458 }, -- Modest Armguards
				{ 8, 18459 }, -- Gallant's Wristguards
				{ 9, 18451 }, -- Hyena Hide Belt
				{ 10, 18462 }, -- Jagged Bone Fist
				{ 11, 18463 }, -- Ogre Pocket Knife
				{ 12, 18464 }, -- Gordok Nose Ring
				{ 13, 18460 }, -- Unsophisticated Hand Cannon
				{ 15, 18250 }, -- Gordok Shackle Key
			},
			[NORMAL_DIFF] = {
				{ 1, 18494 }, -- Denwatcher's Shoulders
				{ 2, 18493 }, -- Bulky Iron Spaulders
				{ 3, 18496 }, -- Heliotrope Cloak
				{ 4, 18497 }, -- Sublime Wristguards
				{ 5, 18498 }, -- Hedgecutter
				{ 6, 18450 }, -- Robe of Combustion
				{ 7, 18458 }, -- Modest Armguards
				{ 8, 18459 }, -- Gallant's Wristguards
				{ 9, 18451 }, -- Hyena Hide Belt
				{ 10, 18462 }, -- Jagged Bone Fist
				{ 11, 18463 }, -- Ogre Pocket Knife
				{ 12, 18464 }, -- Gordok Nose Ring
				{ 13, 18460 }, -- Unsophisticated Hand Cannon
				{ 15, 18250 }, -- Gordok Shackle Key
			},
		},
		{ -- DMNThimblejack
			name = AL["Knot Thimblejack's Cache"],
			AtlasMapBossID = 4,
			npcID = 14338,
			ObjectID = 179501,
			[SOD_DIFF] = {
				{ 1, 18414 }, -- Pattern: Belt of the Archmage
				{ 2, 18415 }, -- Pattern: Felcloth Gloves
				{ 3, 18416 }, -- Pattern: Inferno Gloves
				{ 4, 18417 }, -- Pattern: Mooncloth Gloves
				{ 5, 18418 }, -- Pattern: Cloak of Warding
				{ 6, 18514 }, -- Pattern: Girdle of Insight
				{ 7, 18515 }, -- Pattern: Mongoose Boots
				{ 8, 18516 }, -- Pattern: Swift Flight Bracers
				{ 9, 18517 }, -- Pattern: Chromatic Cloak
				{ 10, 18518 }, -- Pattern: Hide of the Wild
				{ 11, 18519 }, -- Pattern: Shifting Cloak
				{ 12, 18258 }, -- Gordok Ogre Suit
				{ 13, 18240 }, -- Ogre Tannin
			},
			[NORMAL_DIFF] = {
				{ 1, 18414 }, -- Pattern: Belt of the Archmage
				{ 2, 18415 }, -- Pattern: Felcloth Gloves
				{ 3, 18416 }, -- Pattern: Inferno Gloves
				{ 4, 18417 }, -- Pattern: Mooncloth Gloves
				{ 5, 18418 }, -- Pattern: Cloak of Warding
				{ 6, 18514 }, -- Pattern: Girdle of Insight
				{ 7, 18515 }, -- Pattern: Mongoose Boots
				{ 8, 18516 }, -- Pattern: Swift Flight Bracers
				{ 9, 18517 }, -- Pattern: Chromatic Cloak
				{ 10, 18518 }, -- Pattern: Hide of the Wild
				{ 11, 18519 }, -- Pattern: Shifting Cloak
				{ 12, 18258 }, -- Gordok Ogre Suit
				{ 13, 18240 }, -- Ogre Tannin
			},
		},
		{ -- DMNCaptainKromcrush
			name = AL["Captain Kromcrush"],
			npcID = 14325,
			Level = 61,
			DisplayIDs = {{11564}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1, 228068 }, -- Mugger's Belt
				{ 2, 18503 }, -- Kromcrush's Chestplate
				{ 3, 18507 }, -- Boots of the Full Moon
				{ 4, 18502 }, -- Monstrous Glaive
			},
			[NORMAL_DIFF] = {
				{ 1, 18503 }, -- Kromcrush's Chestplate
				{ 2, 18505 }, -- Mugger's Belt
				{ 3, 18507 }, -- Boots of the Full Moon
				{ 4, 18502 }, -- Monstrous Glaive
			},
		},
		{ -- DMNChoRush
			name = AL["Cho'Rush the Observer"],
			npcID = 14324,
			Level = 60,
			DisplayIDs = {{11537}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 228062 }, -- Insightful Hood
				{ 2, 18483 }, -- Mana Channeling Wand
				{ 3, 228064 }, -- Observer's Shield
				{ 4, 18484 }, -- Cho'Rush's Blade
			},
			[NORMAL_DIFF] = {
				{ 1, 18490 }, -- Insightful Hood
				{ 2, 18483 }, -- Mana Channeling Wand
				{ 3, 18485 }, -- Observer's Shield
				{ 4, 18484 }, -- Cho'Rush's Blade
			},
		},
		{ -- DMNKingGordok
			name = AL["King Gordok"],
			npcID = 11501,
			Level = 62,
			DisplayIDs = {{11583}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 228480 }, -- Crown of the Ogre King
				{ 2, 18525 }, -- Bracers of Prosperity
				{ 3, 18527 }, -- Harmonious Gauntlets
				{ 4, 228479 }, -- Leggings of Destruction
				{ 5, 18521 }, -- Grimy Metal Boots
				{ 6, 18522 }, -- Band of the Ogre King
				{ 7, 18523 }, -- Brightly Glowing Stone
				{ 8, 228478 }, -- Barbarous Blade
				{ 10, 19258 }, -- Ace of Warlords
				{ 11, 18780 }, -- Top Half of Advanced Armorsmithing: Volume I
			},
			[NORMAL_DIFF] = {
				{ 1, 18526 }, -- Crown of the Ogre King
				{ 2, 18525 }, -- Bracers of Prosperity
				{ 3, 18527 }, -- Harmonious Gauntlets
				{ 4, 18524 }, -- Leggings of Destruction
				{ 5, 18521 }, -- Grimy Metal Boots
				{ 6, 18522 }, -- Band of the Ogre King
				{ 7, 18523 }, -- Brightly Glowing Stone
				{ 8, 18520 }, -- Barbarous Blade
				{ 10, 19258 }, -- Ace of Warlords
				{ 11, 18780 }, -- Top Half of Advanced Armorsmithing: Volume I
			},
		},
		{ -- DMNTRIBUTERUN
			name = AL["Tribute"],
			ExtraList = true,
			npcID = 14324,
			ObjectID = 179564,
			[SOD_DIFF] = {
				{ 1, 228486 }, -- Treant's Bane
				{ 3, 228065 }, -- Cyclone Spaulders
				{ 4, 18495 }, -- Redoubt Cloak
				{ 5, 228474 }, -- Mindsurge Robe
				{ 6, 228070 }, -- Ogre Forged Hauberk
				{ 7, 18533 }, -- Gordok Bracers of Power
				{ 8, 18529 }, -- Elemental Plate Girdle
				{ 9, 228469 }, -- Tarnished Elven Ring
				{ 10, 18537 }, -- Counterattack Lodestone
				{ 11, 18499 }, -- Barrier Shield
				{ 12, 228473 }, -- Unyielding Maul
				{ 13, 228484 }, -- Rod of the Ogre Magi
				{ 15, 18655 }, -- Schematic: Major Recombobulator
				{ 16, 18479 }, -- Carrion Scorpid Helm
				{ 17, 18480 }, -- Scarab Plate Helm
				{ 18, 18478 }, -- Hyena Hide Jerkin
				{ 19, 18475 }, -- Oddly Magical Belt
				{ 20, 18477 }, -- Shaggy Leggings
				{ 21, 18476 }, -- Mud Stained Boots
				{ 22, 18482 }, -- Ogre Toothpick Shooter
				{ 23, 18481 }, -- Skullcracking Mace
			},
			[NORMAL_DIFF] = {
				{ 1, 18538 }, -- Treant's Bane
				{ 3, 18528 }, -- Cyclone Spaulders
				{ 4, 18495 }, -- Redoubt Cloak
				{ 5, 18532 }, -- Mindsurge Robe
				{ 6, 18530 }, -- Ogre Forged Hauberk
				{ 7, 18533 }, -- Gordok Bracers of Power
				{ 8, 18529 }, -- Elemental Plate Girdle
				{ 9, 18500 }, -- Tarnished Elven Ring
				{ 10, 18537 }, -- Counterattack Lodestone
				{ 11, 18499 }, -- Barrier Shield
				{ 12, 18531 }, -- Unyielding Maul
				{ 13, 18534 }, -- Rod of the Ogre Magi
				{ 15, 18655 }, -- Schematic: Major Recombobulator
				{ 16, 18479 }, -- Carrion Scorpid Helm
				{ 17, 18480 }, -- Scarab Plate Helm
				{ 18, 18478 }, -- Hyena Hide Jerkin
				{ 19, 18475 }, -- Oddly Magical Belt
				{ 20, 18477 }, -- Shaggy Leggings
				{ 21, 18476 }, -- Mud Stained Boots
				{ 22, 18482 }, -- Ogre Toothpick Shooter
				{ 23, 18481 }, -- Skullcracking Mace
			},
		},
		{ -- DMNTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 18250 }, -- Gordok Shackle Key
				{ 3, 18333 }, -- Libram of Focus
				{ 4, 18334 }, -- Libram of Protection
				{ 5, 18332 }, -- Libram of Rapidity
				{ 7, 18640 }, -- Happy Fun Rock
			},
			[NORMAL_DIFF] = {
				{ 1, 18250 }, -- Gordok Shackle Key
				{ 3, 18333 }, -- Libram of Focus
				{ 4, 18334 }, -- Libram of Protection
				{ 5, 18332 }, -- Libram of Rapidity
				{ 7, 18640 }, -- Happy Fun Rock
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["Scholomance"] = {
	MapID = 2057,
	InstanceID = 289,
	SubAreaIDs = { 32549, 32574, 32567, 32577, 32566, 32565, 32581, 32579, 32573, 32568, 32576, 32569 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Scholomance",
	AtlasMapFile = "CL_Scholomance",
	AtlasMapFile_AL = "Scholomance",
	ContentType = DUNGEON_CONTENT,
	LevelRange = {45, 58, 60},
	items = {
		{ -- SCHOLOBlood
			name = AL["Blood Steward of Kirtonos"],
			npcID = 14861,
			Level = 61,
			SubAreaID = 32573,
			DisplayIDs = {{10925}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1, 13523 }, -- Blood of Innocents
			},
			[NORMAL_DIFF] = {
				{ 1, 13523 }, -- Blood of Innocents
			},
		},
		{ -- SCHOLOKirtonostheHerald
			name = AL["Kirtonos the Herald"],
			npcID = 10506,
			Level = 60,
			SubAreaID = 32574,
			DisplayIDs = {{7534}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1, 226764 }, -- Boots of Valor
				{ 3, 228015 }, -- Frightalon
				{ 4, 228019 }, -- Heart of the Fiend
				{ 5, 228001 }, -- Stoneform Shoulders
				{ 6,  13969 }, -- Loomguard Armbraces
				{ 7, 228007 }, -- Gargoyle Slashers
				{ 8, 228004 }, -- Windreaver Greaves
				{ 9, 228005 }, -- Clutch of Andros
				{ 10, 228029 }, -- Gravestone War Axe
			},
			[NORMAL_DIFF] = {
				{ 1, 16734 }, -- Boots of Valor
				{ 3, 13960 }, -- Heart of the Fiend
				{ 4, 13955 }, -- Stoneform Shoulders
				{ 5, 13969 }, -- Loomguard Armbraces
				{ 6, 13957 }, -- Gargoyle Slashers
				{ 7, 13956 }, -- Clutch of Andros
				{ 8, 13967 }, -- Windreaver Greaves
				{ 9, 14024 }, -- Frightalon
				{ 10, 13983 }, -- Gravestone War Axe
			},
		},
		{ -- SCHOLOJandiceBarov
			name = AL["Jandice Barov"],
			npcID = 10503,
			Level = 61,
			DisplayIDs = {{11073}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 226756 }, -- Dreadmist Mantle
				{ 3, 14548 }, -- Royal Cap Spaulders
				{ 4, 18689 }, -- Phantasmal Cloak
				{ 5, 228031 }, -- Darkshade Gloves
				{ 6, 228040 }, -- Ghostloom Leggings
				{ 7, 228041 }, -- Wraithplate Leggings
				{ 8, 227997 }, -- Barovian Family Sword
				{ 9, 22394 }, -- Staff of Metanoia
				{ 12, 13523 }, -- Blood of Innocents
			},
			[NORMAL_DIFF] = {
				{ 1, 16701 }, -- Dreadmist Mantle
				{ 3, 14548 }, -- Royal Cap Spaulders
				{ 4, 18689 }, -- Phantasmal Cloak
				{ 5, 14543 }, -- Darkshade Gloves
				{ 6, 14545 }, -- Ghostloom Leggings
				{ 7, 18690 }, -- Wraithplate Leggings
				{ 8, 14541 }, -- Barovian Family Sword
				{ 9, 22394 }, -- Staff of Metanoia
				{ 12, 13523 }, -- Blood of Innocents
			},
		},
		{ -- SCHOLORattlegore
			name = AL["Rattlegore"],
			npcID = 11622,
			Level = 61,
			SubAreaID = 32577,
			DisplayIDs = {{12073}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1, 226703 }, -- Shadowcraft Boots
				{ 3, 228032 }, -- Bone Ring Helm
				{ 4, 14538 }, -- Deadwalker Mantle
				{ 5, 18686 }, -- Bone Golem Shoulders
				{ 6, 14537 }, -- Corpselight Greaves
				{ 7, 228037 }, -- Rattlecage Buckler
				{ 8, 227994 }, -- Frightskull Shaft
				{ 10, 18782 }, -- Top Half of Advanced Armorsmithing: Volume II
				{ 12, 13873 }, -- Viewing Room Key
			},
			[NORMAL_DIFF] = {
				{ 1, 16711 }, -- Shadowcraft Boots
				{ 3, 14539 }, -- Bone Ring Helm
				{ 4, 14538 }, -- Deadwalker Mantle
				{ 5, 18686 }, -- Bone Golem Shoulders
				{ 6, 14537 }, -- Corpselight Greaves
				{ 7, 14528 }, -- Rattlecage Buckler
				{ 8, 14531 }, -- Frightskull Shaft
				{ 10, 18782 }, -- Top Half of Advanced Armorsmithing: Volume II
				{ 12, 13873 }, -- Viewing Room Key
			},
		},
		{ -- SCHOLODeathKnight
			name = AL["Death Knight Darkreaver"],
			npcID = 14516,
			Level = 61,
			SubAreaID = 32577,
			DisplayIDs = {{14591}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1, 228045 }, -- Necromantic Band
				{ 2, 18761 }, -- Oblivion's Touch
				{ 3, 18758 }, -- Specter's Blade
				{ 4, 228030 }, -- Malicious Axe
			},
			[NORMAL_DIFF] = {
				{ 1, 18760 }, -- Necromantic Band
				{ 2, 18761 }, -- Oblivion's Touch
				{ 3, 18758 }, -- Specter's Blade
				{ 4, 18759 }, -- Malicious Axe
			},
		},
		{ -- SCHOLOMarduk
			name = AL["Marduk Blackpool"],
			npcID = 10433,
			Level = 58,
			SubAreaID = 32576,
			DisplayIDs = {{10248}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 227992 }, -- Death Knight Sabatons
				{ 2, 227993 }, -- Ebon Hilt of Marduk
			},
			[NORMAL_DIFF] = {
				{ 1, 18692 }, -- Death Knight Sabatons
				{ 2, 14576 }, -- Ebon Hilt of Marduk
			},
		},
		{ -- SCHOLOVectus
			name = AL["Vectus"],
			npcID = 10432,
			Level = 60,
			SubAreaID = 32576,
			DisplayIDs = {{2606}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 228017 }, -- Skullsmoke Pants
				{ 2, 18691 }, -- Dark Advisor's Pendant
			},
			[NORMAL_DIFF] = {
				{ 1, 18691 }, -- Dark Advisor's Pendant
				{ 2, 14577 }, -- Skullsmoke Pants
			},
		},
		{ -- SCHOLORasFrostwhisper
			name = AL["Ras Frostwhisper"],
			npcID = 10508,
			Level = 62,
			SubAreaID = 32579,
			DisplayIDs = {{7919}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 228023 }, -- Alanna's Embrace
				{ 2, 226726 }, -- Magister's Mantle
				{ 4, 228036 }, -- Death's Clutch
				{ 5, 14340 }, -- Freezing Lich Robes
				{ 6, 228034 }, -- Shivery Handwraps
				{ 7, 14525 }, -- Boneclenched Gauntlets
				{ 8, 14502 }, -- Frostbite Girdle
				{ 9, 228044 }, -- Maelstrom Leggings
				{ 10, 18694 }, -- Shadowy Mail Greaves
				{ 11, 228039 }, -- Spellbound Tome
				{ 12, 18696 }, -- Intricately Runed Shield
				{ 13, 13952 }, -- Iceblade Hacker
				{ 14, 14487 }, -- Bonechill Hammer
				{ 15, 13521 }, -- Recipe: Flask of Supreme Power
			},
			[NORMAL_DIFF] = {
				{ 1, 13314 }, -- Alanna's Embrace
				{ 2, 16689 }, -- Magister's Mantle
				{ 4, 14503 }, -- Death's Clutch
				{ 5, 14340 }, -- Freezing Lich Robes
				{ 6, 18693 }, -- Shivery Handwraps
				{ 7, 14525 }, -- Boneclenched Gauntlets
				{ 8, 14502 }, -- Frostbite Girdle
				{ 9, 14522 }, -- Maelstrom Leggings
				{ 10, 18694 }, -- Shadowy Mail Greaves
				{ 11, 18695 }, -- Spellbound Tome
				{ 12, 18696 }, -- Intricately Runed Shield
				{ 13, 13952 }, -- Iceblade Hacker
				{ 14, 14487 }, -- Bonechill Hammer
				{ 15, 13521 }, -- Recipe: Flask of Supreme Power
			},
		},
		{ -- SCHOLOInstructorMalicia
			name = AL["Instructor Malicia"],
			npcID = 10505,
			Level = 60,
			SubAreaID = 32567,
			DisplayIDs = {{11069}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1, 227996 }, -- Ancient Bone Bow
				{ 2, 228010 }, -- Necropile Mantle
				{ 3, 228013 }, -- Necropile Robe
				{ 4, 228011 }, -- Necropile Cuffs
				{ 5, 228018 }, -- Necropile Leggings
				{ 6, 228009 }, -- Necropile Boots
				{ 7, 228012 }, -- Bloodmail Hauberk
				{ 8, 228020 }, -- Bloodmail Gauntlets
				{ 9, 228014 }, -- Bloodmail Belt
				{ 10, 228003 }, -- Bloodmail Legguards
				{ 11, 227998 }, -- Bloodmail Boots
				{ 12, 228000 }, -- Deathbone Chestplate
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 228002 }, -- Deathbone Girdle
				{ 15, 228008 }, -- Deathbone Legguards
				{ 16, 227999 }, -- Deathbone Sabatons
				{ 17, 228016 }, -- Dimly Opalescent Ring
				{ 18, 18683 }, -- Hammer of the Vesper
				{ 19, 18681 }, -- Burial Shawl
				{ 20, 18684 }, -- Dimly Opalescent Ring
				{ 21, 18682 }, -- Ghoul Skin Leggings
				{ 22, 226704 }, -- Shadowcraft Bracers
				{ 23, 23201 }, -- Libram of Divinity
				{ 24, 23200 }, -- Totem of Sustaining
			},
			[NORMAL_DIFF] = {
				{ 1, 18680 }, -- Ancient Bone Bow
				{ 2, 14633 }, -- Necropile Mantle
				{ 3, 14626 }, -- Necropile Robe
				{ 4, 14629 }, -- Necropile Cuffs
				{ 5, 14632 }, -- Necropile Leggings
				{ 6, 14631 }, -- Necropile Boots
				{ 7, 14611 }, -- Bloodmail Hauberk
				{ 8, 14615 }, -- Bloodmail Gauntlets
				{ 9, 14614 }, -- Bloodmail Belt
				{ 10, 14612 }, -- Bloodmail Legguards
				{ 11, 14616 }, -- Bloodmail Boots
				{ 12, 14624 }, -- Deathbone Chestplate
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14620 }, -- Deathbone Girdle
				{ 15, 14623 }, -- Deathbone Legguards
				{ 16, 14621 }, -- Deathbone Sabatons
				{ 17, 18684 }, -- Dimly Opalescent Ring
				{ 18, 18683 }, -- Hammer of the Vesper
				{ 19, 18681 }, -- Burial Shawl
				{ 20, 18684 }, -- Dimly Opalescent Ring
				{ 21, 18682 }, -- Ghoul Skin Leggings
				{ 22, 16710 }, -- Shadowcraft Bracers
				{ 23, 23201 }, -- Libram of Divinity
				{ 24, 23200 }, -- Totem of Sustaining
			},
		},
		{ -- SCHOLODoctorTheolenKrastinov
			name = AL["Doctor Theolen Krastinov"],
			npcID = 11261,
			Level = 60,
			SubAreaID = 32565,
			DisplayIDs = {{10901}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1, 227996 }, -- Ancient Bone Bow
				{ 2, 228010 }, -- Necropile Mantle
				{ 3, 228013 }, -- Necropile Robe
				{ 4, 228011 }, -- Necropile Cuffs
				{ 5, 228018 }, -- Necropile Leggings
				{ 6, 228009 }, -- Necropile Boots
				{ 7, 228012 }, -- Bloodmail Hauberk
				{ 8, 228020 }, -- Bloodmail Gauntlets
				{ 9, 228014 }, -- Bloodmail Belt
				{ 10, 228003 }, -- Bloodmail Legguards
				{ 11, 227998 }, -- Bloodmail Boots
				{ 12, 228000 }, -- Deathbone Chestplate
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 228002 }, -- Deathbone Girdle
				{ 15, 228008 }, -- Deathbone Legguards
				{ 16, 227999 }, -- Deathbone Sabatons
				{ 17, 228016 }, -- Dimly Opalescent Ring
				{ 19, 18683 }, -- Hammer of the Vesper
				{ 20, 18681 }, -- Burial Shawl
				{ 21, 18682 }, -- Ghoul Skin Leggings
				{ 22, 226731 }, -- Magister's Gloves
				{ 23, 23201 }, -- Libram of Divinity
				{ 24, 23200 }, -- Totem of Sustaining
				{ 25, 14617 }, -- Sawbones Shirt
			},
			[NORMAL_DIFF] = {
				{ 1, 18680 }, -- Ancient Bone Bow
				{ 2, 14633 }, -- Necropile Mantle
				{ 3, 14626 }, -- Necropile Robe
				{ 4, 14629 }, -- Necropile Cuffs
				{ 5, 14632 }, -- Necropile Leggings
				{ 6, 14631 }, -- Necropile Boots
				{ 7, 14611 }, -- Bloodmail Hauberk
				{ 8, 14615 }, -- Bloodmail Gauntlets
				{ 9, 14614 }, -- Bloodmail Belt
				{ 10, 14612 }, -- Bloodmail Legguards
				{ 11, 14616 }, -- Bloodmail Boots
				{ 12, 14624 }, -- Deathbone Chestplate
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14620 }, -- Deathbone Girdle
				{ 15, 14623 }, -- Deathbone Legguards
				{ 16, 14621 }, -- Deathbone Sabatons
				{ 17, 18684 }, -- Dimly Opalescent Ring
				{ 19, 18683 }, -- Hammer of the Vesper
				{ 20, 18681 }, -- Burial Shawl
				{ 21, 18682 }, -- Ghoul Skin Leggings
				{ 22, 16684 }, -- Magister's Gloves
				{ 23, 23201 }, -- Libram of Divinity
				{ 24, 23200 }, -- Totem of Sustaining
				{ 25, 14617 }, -- Sawbones Shirt
			},
		},
		{ -- SCHOLOLorekeeperPolkelt
			name = AL["Lorekeeper Polkelt"],
			npcID = 10901,
			Level = 60,
			SubAreaID = 32566,
			DisplayIDs = {{11492}},
			AtlasMapBossID = 10,
			[SOD_DIFF] = {
				{ 1, 227996 }, -- Ancient Bone Bow
				{ 2, 228010 }, -- Necropile Mantle
				{ 3, 228013 }, -- Necropile Robe
				{ 4, 228011 }, -- Necropile Cuffs
				{ 5, 228018 }, -- Necropile Leggings
				{ 6, 228009 }, -- Necropile Boots
				{ 7, 228012 }, -- Bloodmail Hauberk
				{ 8, 228020 }, -- Bloodmail Gauntlets
				{ 9, 228014 }, -- Bloodmail Belt
				{ 10, 228003 }, -- Bloodmail Legguards
				{ 11, 227998 }, -- Bloodmail Boots
				{ 12, 228000 }, -- Deathbone Chestplate
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 228002 }, -- Deathbone Girdle
				{ 15, 228008 }, -- Deathbone Legguards
				{ 16, 227999 }, -- Deathbone Sabatons
				{ 17, 228016 }, -- Dimly Opalescent Ring
				{ 18, 226758 }, -- Dreadmist Wraps
				{ 19, 23201 }, -- Libram of Divinity
				{ 20, 23200 }, -- Totem of Sustaining
				{ 21, 18683 }, -- Hammer of the Vesper
				{ 22, 18682 }, -- Ghoul Skin Leggings
				{ 23, 18681 }, -- Burial Shawl
			},
			[NORMAL_DIFF] = {
				{ 1, 18680 }, -- Ancient Bone Bow
				{ 2, 14633 }, -- Necropile Mantle
				{ 3, 14626 }, -- Necropile Robe
				{ 4, 14629 }, -- Necropile Cuffs
				{ 5, 14632 }, -- Necropile Leggings
				{ 6, 14631 }, -- Necropile Boots
				{ 7, 14611 }, -- Bloodmail Hauberk
				{ 8, 14615 }, -- Bloodmail Gauntlets
				{ 9, 14614 }, -- Bloodmail Belt
				{ 10, 14612 }, -- Bloodmail Legguards
				{ 11, 14616 }, -- Bloodmail Boots
				{ 12, 14624 }, -- Deathbone Chestplate
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14620 }, -- Deathbone Girdle
				{ 15, 14623 }, -- Deathbone Legguards
				{ 16, 14621 }, -- Deathbone Sabatons
				{ 17, 18684 }, -- Dimly Opalescent Ring
				{ 18, 16705 }, -- Dreadmist Wraps
				{ 19, 23201 }, -- Libram of Divinity
				{ 20, 23200 }, -- Totem of Sustaining
				{ 21, 18683 }, -- Hammer of the Vesper
				{ 22, 18682 }, -- Ghoul Skin Leggings
				{ 23, 18681 }, -- Burial Shawl
			},
		},
		{ -- SCHOLOTheRavenian
			name = AL["The Ravenian"],
			npcID = 10507,
			Level = 60,
			SubAreaID = 32569,
			DisplayIDs = {{10433}},
			AtlasMapBossID = 11,
			[SOD_DIFF] = {
				{ 1, 227996 }, -- Ancient Bone Bow
				{ 2, 228010 }, -- Necropile Mantle
				{ 3, 228013 }, -- Necropile Robe
				{ 4, 228011 }, -- Necropile Cuffs
				{ 5, 228018 }, -- Necropile Leggings
				{ 6, 228009 }, -- Necropile Boots
				{ 8, 228012 }, -- Bloodmail Hauberk
				{ 9, 228020 }, -- Bloodmail Gauntlets
				{ 10, 228014 }, -- Bloodmail Belt
				{ 11, 228003 }, -- Bloodmail Legguards
				{ 12, 227998 }, -- Bloodmail Boots
				{ 13, 228000 }, -- Deathbone Chestplate
				{ 14, 228006 }, -- Deathbone Gauntlets
				{ 15, 228002 }, -- Deathbone Girdle
				{ 16, 228008 }, -- Deathbone Legguards
				{ 17, 227999 }, -- Deathbone Sabatons
				{ 18, 228016 }, -- Dimly Opalescent Ring
				{ 19, 226712 }, -- Wildheart Belt
				{ 20, 14637 }, -- Cadaverous Armor
				{ 21, 14640 }, -- Cadaverous Gloves
				{ 22, 14636 }, -- Cadaverous Belt
				{ 23, 14638 }, -- Cadaverous Leggings
				{ 24, 14641 }, -- Cadaverous Walkers
				{ 25, 23201 }, -- Libram of Divinity
				{ 26, 23200 }, -- Totem of Sustaining
				{ 27, 18683 }, -- Hammer of the Vesper
				{ 28, 18682 }, -- Ghoul Skin Leggings
				{ 29, 18681 }, -- Burial Shawl
			},
			[NORMAL_DIFF] = {
				{ 1, 18680 }, -- Ancient Bone Bow
				{ 2, 14633 }, -- Necropile Mantle
				{ 3, 14626 }, -- Necropile Robe
				{ 4, 14629 }, -- Necropile Cuffs
				{ 5, 14632 }, -- Necropile Leggings
				{ 6, 14631 }, -- Necropile Boots
				{ 8, 14611 }, -- Bloodmail Hauberk
				{ 9, 14615 }, -- Bloodmail Gauntlets
				{ 10, 14614 }, -- Bloodmail Belt
				{ 11, 14612 }, -- Bloodmail Legguards
				{ 12, 14616 }, -- Bloodmail Boots
				{ 13, 14624 }, -- Deathbone Chestplate
				{ 14, 14622 }, -- Deathbone Gauntlets
				{ 15, 14620 }, -- Deathbone Girdle
				{ 16, 14623 }, -- Deathbone Legguards
				{ 17, 14621 }, -- Deathbone Sabatons
				{ 18, 18684 }, -- Dimly Opalescent Ring
				{ 19, 16716 }, -- Wildheart Belt
				{ 20, 14637 }, -- Cadaverous Armor
				{ 21, 14640 }, -- Cadaverous Gloves
				{ 22, 14636 }, -- Cadaverous Belt
				{ 23, 14638 }, -- Cadaverous Leggings
				{ 24, 14641 }, -- Cadaverous Walkers
				{ 25, 23201 }, -- Libram of Divinity
				{ 26, 23200 }, -- Totem of Sustaining
				{ 27, 18683 }, -- Hammer of the Vesper
				{ 28, 18682 }, -- Ghoul Skin Leggings
				{ 29, 18681 }, -- Burial Shawl
			},
		},
		{ -- SCHOLOLordAlexeiBarov
			name = AL["Lord Alexei Barov"],
			npcID = 10504,
			Level = 60,
			SubAreaID = 32549,
			DisplayIDs = {{11072}},
			AtlasMapBossID = 12,
			[SOD_DIFF] = {
				{ 1, 227996 }, -- Ancient Bone Bow
				{ 2, 228010 }, -- Necropile Mantle
				{ 3, 228013 }, -- Necropile Robe
				{ 4, 228011 }, -- Necropile Cuffs
				{ 5, 228018 }, -- Necropile Leggings
				{ 6, 228009 }, -- Necropile Boots
				{ 8, 228012 }, -- Bloodmail Hauberk
				{ 9, 228020 }, -- Bloodmail Gauntlets
				{ 10, 228014 }, -- Bloodmail Belt
				{ 11, 228003 }, -- Bloodmail Legguards
				{ 12, 227998 }, -- Bloodmail Boots
				{ 13, 228000 }, -- Deathbone Chestplate
				{ 14, 228006 }, -- Deathbone Gauntlets
				{ 15, 228002 }, -- Deathbone Girdle
				{ 16, 228008 }, -- Deathbone Legguards
				{ 17, 227999 }, -- Deathbone Sabatons
				{ 18, 228016 }, -- Dimly Opalescent Ring
				{ 19, 226739 }, -- Lightforge Bracers
				{ 20, 14637 }, -- Cadaverous Armor
				{ 21, 14640 }, -- Cadaverous Gloves
				{ 22, 14636 }, -- Cadaverous Belt
				{ 23, 14638 }, -- Cadaverous Leggings
				{ 24, 14641 }, -- Cadaverous Walkers
				{ 25, 23201 }, -- Libram of Divinity
				{ 26, 23200 }, -- Totem of Sustaining
				{ 27, 18683 }, -- Hammer of the Vesper
				{ 28, 18682 }, -- Ghoul Skin Leggings
				{ 29, 18681 }, -- Burial Shawl
			},
			[NORMAL_DIFF] = {
				{ 1, 18680 }, -- Ancient Bone Bow
				{ 2, 14633 }, -- Necropile Mantle
				{ 3, 14626 }, -- Necropile Robe
				{ 4, 14629 }, -- Necropile Cuffs
				{ 5, 14632 }, -- Necropile Leggings
				{ 6, 14631 }, -- Necropile Boots
				{ 8, 14611 }, -- Bloodmail Hauberk
				{ 9, 14615 }, -- Bloodmail Gauntlets
				{ 10, 14614 }, -- Bloodmail Belt
				{ 11, 14612 }, -- Bloodmail Legguards
				{ 12, 14616 }, -- Bloodmail Boots
				{ 13, 14624 }, -- Deathbone Chestplate
				{ 14, 14622 }, -- Deathbone Gauntlets
				{ 15, 14620 }, -- Deathbone Girdle
				{ 16, 14623 }, -- Deathbone Legguards
				{ 17, 14621 }, -- Deathbone Sabatons
				{ 18, 18684 }, -- Dimly Opalescent Ring
				{ 19, 16722 }, -- Lightforge Bracers
				{ 20, 14637 }, -- Cadaverous Armor
				{ 21, 14640 }, -- Cadaverous Gloves
				{ 22, 14636 }, -- Cadaverous Belt
				{ 23, 14638 }, -- Cadaverous Leggings
				{ 24, 14641 }, -- Cadaverous Walkers
				{ 25, 23201 }, -- Libram of Divinity
				{ 26, 23200 }, -- Totem of Sustaining
				{ 27, 18683 }, -- Hammer of the Vesper
				{ 28, 18682 }, -- Ghoul Skin Leggings
				{ 29, 18681 }, -- Burial Shawl
			},
		},
		{ -- SCHOLOLadyIlluciaBarov
			name = AL["Lady Illucia Barov"],
			npcID = 10502,
			Level = 60,
			SubAreaID = 32568,
			DisplayIDs = {{11835}},
			AtlasMapBossID = 13,
			[SOD_DIFF] = {
				{ 1, 227996 }, -- Ancient Bone Bow
				{ 2, 228010 }, -- Necropile Mantle
				{ 3, 228013 }, -- Necropile Robe
				{ 4, 228011 }, -- Necropile Cuffs
				{ 5, 228018 }, -- Necropile Leggings
				{ 6, 228009 }, -- Necropile Boots
				{ 8, 228012 }, -- Bloodmail Hauberk
				{ 9, 228020 }, -- Bloodmail Gauntlets
				{ 10, 228014 }, -- Bloodmail Belt
				{ 11, 228003 }, -- Bloodmail Legguards
				{ 12, 227998 }, -- Bloodmail Boots
				{ 13, 228000 }, -- Deathbone Chestplate
				{ 14, 228006 }, -- Deathbone Gauntlets
				{ 15, 228002 }, -- Deathbone Girdle
				{ 16, 228008 }, -- Deathbone Legguards
				{ 17, 227999 }, -- Deathbone Sabatons
				{ 18, 228016 }, -- Dimly Opalescent Ring
				{ 20, 14637 }, -- Cadaverous Armor
				{ 21, 14640 }, -- Cadaverous Gloves
				{ 22, 14636 }, -- Cadaverous Belt
				{ 23, 14638 }, -- Cadaverous Leggings
				{ 24, 14641 }, -- Cadaverous Walkers
				{ 25, 23201 }, -- Libram of Divinity
				{ 26, 23200 }, -- Totem of Sustaining
				{ 27, 18683 }, -- Hammer of the Vesper
				{ 28, 18682 }, -- Ghoul Skin Leggings
				{ 29, 18681 }, -- Burial Shawl
			},
			[NORMAL_DIFF] = {
				{ 1, 18680 }, -- Ancient Bone Bow
				{ 2, 14633 }, -- Necropile Mantle
				{ 3, 14626 }, -- Necropile Robe
				{ 4, 14629 }, -- Necropile Cuffs
				{ 5, 14632 }, -- Necropile Leggings
				{ 6, 14631 }, -- Necropile Boots
				{ 8, 14611 }, -- Bloodmail Hauberk
				{ 9, 14615 }, -- Bloodmail Gauntlets
				{ 10, 14614 }, -- Bloodmail Belt
				{ 11, 14612 }, -- Bloodmail Legguards
				{ 12, 14616 }, -- Bloodmail Boots
				{ 13, 14624 }, -- Deathbone Chestplate
				{ 14, 14622 }, -- Deathbone Gauntlets
				{ 15, 14620 }, -- Deathbone Girdle
				{ 16, 14623 }, -- Deathbone Legguards
				{ 17, 14621 }, -- Deathbone Sabatons
				{ 18, 18684 }, -- Dimly Opalescent Ring
				{ 20, 14637 }, -- Cadaverous Armor
				{ 21, 14640 }, -- Cadaverous Gloves
				{ 22, 14636 }, -- Cadaverous Belt
				{ 23, 14638 }, -- Cadaverous Leggings
				{ 24, 14641 }, -- Cadaverous Walkers
				{ 25, 23201 }, -- Libram of Divinity
				{ 26, 23200 }, -- Totem of Sustaining
				{ 27, 18683 }, -- Hammer of the Vesper
				{ 28, 18682 }, -- Ghoul Skin Leggings
				{ 29, 18681 }, -- Burial Shawl
			},
		},
		{ -- SCHOLODarkmasterGandling
			name = AL["Darkmaster Gandling"],
			npcID = 1853,
			Level = 61,
			SubAreaID = 32581,
			DisplayIDs = {{11070}},
			AtlasMapBossID = 14,
			[SOD_DIFF] = {
				{ 1, 228021 }, -- Witchblade
				{ 2, 228024 }, -- Silent Fang
				{ 3, 228022 }, -- Headmaster's Charge
				{ 4, 228025 }, -- Tombstone Breastplate
				{ 5, 228042 }, -- Detention Strap
				{ 6, 228046 }, -- Don Mauricio's Band of Domination
				{ 7, 226746 }, -- Devout Crown
				{ 8, 226728 }, -- Magister's Crown
				{ 9, 226762 }, -- Dreadmist Mask
				{ 10, 226707 }, -- Shadowcraft Cap
				{ 11, 226708 }, -- Wildheart Cowl
				{ 12, 226720 }, -- Beaststalker's Cap
				{ 13, 226755 }, -- Coif of Elements
				{ 14, 226733 }, -- Lightforge Helm
				{ 15, 226769 }, -- Helm of Valor
				{ 16, 13951 }, -- Vigorsteel Vambraces
				{ 17, 13398 }, -- Boots of the Shrieker
				{ 18, 13938 }, -- Bonecreeper Stylus
				{ 19, 19276 }, -- Ace of Portals
				{ 20, 13501 }, -- Recipe: Major Mana Potion
				{ 21, 14514 }, -- Pattern: Robe of the Void
			},
			[NORMAL_DIFF] = {
				{ 1, 13964 }, -- Witchblade
				{ 2, 13953 }, -- Silent Fang
				{ 3, 13937 }, -- Headmaster's Charge
				{ 4, 13944 }, -- Tombstone Breastplate
				{ 5, 13950 }, -- Detention Strap
				{ 6, 22433 }, -- Don Mauricio's Band of Domination
				{ 7, 16693 }, -- Devout Crown
				{ 8, 16686 }, -- Magister's Crown
				{ 9, 16698 }, -- Dreadmist Mask
				{ 10, 16707 }, -- Shadowcraft Cap
				{ 11, 16720 }, -- Wildheart Cowl
				{ 12, 16677 }, -- Beaststalker's Cap
				{ 13, 16667 }, -- Coif of Elements
				{ 14, 16727 }, -- Lightforge Helm
				{ 15, 16731 }, -- Helm of Valor
				{ 16, 13951 }, -- Vigorsteel Vambraces
				{ 17, 13398 }, -- Boots of the Shrieker
				{ 18, 13938 }, -- Bonecreeper Stylus
				{ 19, 19276 }, -- Ace of Portals
				{ 20, 13501 }, -- Recipe: Major Mana Potion
				{ 21, 14514 }, -- Pattern: Robe of the Void
			},
		},
		{ -- SCHOLOTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 226724 }, -- Magister's Belt
				{ 2, 226761 }, -- Dreadmist Belt
				{ 3, 226704 }, -- Shadowcraft Bracers
				{ 4, 226714 }, -- Wildheart Bracers
				{ 5, 226712 }, -- Wildheart Belt
				{ 6, 226751 }, -- Bindings of Elements
				{ 7, 226739 }, -- Lightforge Bracers
				{ 8, 18698 }, -- Tattered Leather Hood
				{ 9, 18699 }, -- Icy Tomb Spaulders
				{ 10, 14536 }, -- Bonebrace Hauberk
				{ 11, 18700 }, -- Malefic Bracers
				{ 12, 18702 }, -- Belt of the Ordained
				{ 13, 18697 }, -- Coldstone Slippers
				{ 14, 18701 }, -- Innervating Band
				{ 15, 16254 }, -- Formula: Enchant Weapon - Lifestealing
				{ 16, 16255 }, -- Formula: Enchant 2H Weapon - Major Spirit
				{ 17, 15773 }, -- Pattern: Wicked Leather Armor
				{ 18, 15776 }, -- Pattern: Runic Leather Armor
				{ 19, 13920 }, -- Healthy Dragon Scale
				{ 20, 12843 }, -- Corruptor's Scourgestone
				{ 21, 12841 }, -- Invader's Scourgestone
				{ 22, 12840 }, -- Minion's Scourgestone
				{ 23, 20520 }, -- Dark Rune
				{ 24, 12753 }, -- Skin of Shadow
			},
			[NORMAL_DIFF] = {
				{ 1, 16685 }, -- Magister's Belt
				{ 2, 16702 }, -- Dreadmist Belt
				{ 3, 16710 }, -- Shadowcraft Bracers
				{ 4, 16714 }, -- Wildheart Bracers
				{ 5, 16716 }, -- Wildheart Belt
				{ 6, 16671 }, -- Bindings of Elements
				{ 7, 16722 }, -- Lightforge Bracers
				{ 8, 18698 }, -- Tattered Leather Hood
				{ 9, 18699 }, -- Icy Tomb Spaulders
				{ 10, 14536 }, -- Bonebrace Hauberk
				{ 11, 18700 }, -- Malefic Bracers
				{ 12, 18702 }, -- Belt of the Ordained
				{ 13, 18697 }, -- Coldstone Slippers
				{ 14, 18701 }, -- Innervating Band
				{ 15, 16254 }, -- Formula: Enchant Weapon - Lifestealing
				{ 16, 16255 }, -- Formula: Enchant 2H Weapon - Major Spirit
				{ 17, 15773 }, -- Pattern: Wicked Leather Armor
				{ 18, 15776 }, -- Pattern: Runic Leather Armor
				{ 19, 13920 }, -- Healthy Dragon Scale
				{ 20, 12843 }, -- Corruptor's Scourgestone
				{ 21, 12841 }, -- Invader's Scourgestone
				{ 22, 12840 }, -- Minion's Scourgestone
				{ 23, 20520 }, -- Dark Rune
				{ 24, 12753 }, -- Skin of Shadow
			},
		},
		{ -- SCHOLOLordB
			name = AL["Lord Blackwood"],
			npcID = 14695,
			DisplayIDs = {{14699}},
			AtlasMapBossID = 2,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 23132 }, -- Lord Blackwood's Blade
				{ 2, 23156 }, -- Blackwood's Thigh
				{ 3, 23139 }, -- Lord Blackwood's Buckler
			},
			[NORMAL_DIFF] = {
				{ 1, 23132 }, -- Lord Blackwood's Blade
				{ 2, 23156 }, -- Blackwood's Thigh
				{ 3, 23139 }, -- Lord Blackwood's Buckler
			},
		},
		{ -- SCHOLOKormok
			name = AL["Kormok"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16118,
			DisplayIDs = {{16020}},
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 228038 }, -- Ironweave Pants
				{ 2, 228047 }, -- Amalgam's Band
				{ 3, 22331 }, -- Band of the Steadfast Hero
				{ 4, 228028 }, -- Blade of Necromancy
				{ 5, 228033 }, -- Hammer of Divine Might
			},
			[NORMAL_DIFF] = {
				{ 1, 22303 }, -- Ironweave Pants
				{ 2, 22326 }, -- Amalgam's Band
				{ 3, 22331 }, -- Band of the Steadfast Hero
				{ 4, 22332 }, -- Blade of Necromancy
				{ 5, 22333 }, -- Hammer of Divine Might
			},
		},
		KEYS,
	},
}

data["Stratholme"] = {
	MapID = 2017,
	InstanceID = 329,
	SubAreaIDs = {
		-- Living
		32319, 32320, 32367, 32331, 32357, 32281, 32285, 32277,
		-- Undead
		32342, 32322, 32303, 32301, 32352,
		-- Ziggurats
		32344, 32345, 32349,
	},
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Stratholme",
	AtlasMapFile = "CL_Stratholme",
	AtlasMapFile_AL = "Stratholme",
	ContentType = DUNGEON_CONTENT,
	LevelRange = GetForVersion({37, 58, 60}, {45, 58, 60}),
	items = {
		{ -- STRATSkull
			name = AL["Skul"],
			NameColor = GREEN,
			npcID = 10393,
			Level = 58,
			DisplayIDs = {{2606}},
			AtlasMapBossID = 1,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 13395 }, -- Skul's Fingerbone Claws
				{ 2, 13394 }, -- Skul's Cold Embrace
				{ 3, 13396 }, -- Skul's Ghastly Touch
			},
			[NORMAL_DIFF] = {
				{ 1, 13395 }, -- Skul's Fingerbone Claws
				{ 2, 13394 }, -- Skul's Cold Embrace
				{ 3, 13396 }, -- Skul's Ghastly Touch
			},
		},
		{ -- STRATStratholmeCourier
			name = AL["Stratholme Courier"],
			NameColor = GREEN,
			npcID = 11082,
			Level = 57,
			DisplayIDs = {{10547}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1, 13303 }, -- Crusaders' Square Postbox Key
				{ 2, 13305 }, -- Elders' Square Postbox Key
				{ 3, 13304 }, -- Festival Lane Postbox Key
				{ 4, 13307 }, -- Fras Siabi's Postbox Key
				{ 5, 13306 }, -- King's Square Postbox Key
				{ 6, 13302 }, -- Market Row Postbox Key
			},
			[NORMAL_DIFF] = {
				{ 1, 13303 }, -- Crusaders' Square Postbox Key
				{ 2, 13305 }, -- Elders' Square Postbox Key
				{ 3, 13304 }, -- Festival Lane Postbox Key
				{ 4, 13307 }, -- Fras Siabi's Postbox Key
				{ 5, 13306 }, -- King's Square Postbox Key
				{ 6, 13302 }, -- Market Row Postbox Key
			},
		},
		{ -- STRATHearthsingerForresten
			name = AL["Hearthsinger Forresten"],
			NameColor = GREEN,
			npcID = 10558,
			Level = 57,
			SubAreaID = 32277,
			DisplayIDs = {{10482}},
			AtlasMapBossID = 3,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 226730 }, -- Magister's Boots
				{ 3, 228501 }, -- Songbird Blouse
				{ 4, 228504 }, -- Rainbow Girdle
				{ 5, 228503 }, -- Woollies of the Prancing Minstrel
				{ 6, 13379 }, -- Piccolo of the Flaming Fire
			},
			[NORMAL_DIFF] = {
				{ 1, 16682 }, -- Magister's Boots
				{ 3, 13378 }, -- Songbird Blouse
				{ 4, 13384 }, -- Rainbow Girdle
				{ 5, 13383 }, -- Woollies of the Prancing Minstrel
				{ 6, 13379 }, -- Piccolo of the Flaming Fire
			},
		},
		{ -- STRATTheUnforgiven
			name = AL["The Unforgiven"],
			NameColor = GREEN,
			npcID = 10516,
			Level = 57,
			SubAreaID = 32281,
			DisplayIDs = {{10771}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1, 226711 }, -- Wildheart Gloves
				{ 3, 228500 }, -- Mask of the Unforgiven
				{ 4, 13405 }, -- Wailing Nightbane Pauldrons
				{ 5, 13409 }, -- Tearfall Bracers
				{ 6, 13408 }, -- Soul Breaker
			},
			[NORMAL_DIFF] = {
				{ 1, 16717 }, -- Wildheart Gloves
				{ 3, 13404 }, -- Mask of the Unforgiven
				{ 4, 13405 }, -- Wailing Nightbane Pauldrons
				{ 5, 13409 }, -- Tearfall Bracers
				{ 6, 13408 }, -- Soul Breaker
			},
		},
		{ -- STRATPostmaster
			name = AL["Postmaster Malown"],
			NameColor = GREEN,
			npcID = 11143,
			Level = 60,
			DisplayIDs = {{10669}},
			AtlasMapBossID = "6'",
			[SOD_DIFF] = {
				{ 1, 228528 }, -- The Postmaster's Band
				{ 2, 228525 }, -- The Postmaster's Tunic
				{ 3, 228527 }, -- The Postmaster's Trousers
				{ 4, 228529 }, -- The Postmaster's Treads
				{ 5, 228524 }, -- The Postmaster's Seal
				{ 6, 13393 }, -- Malown's Slam
			},
			[NORMAL_DIFF] = {
				{ 1, 13390 }, -- The Postmaster's Band
				{ 2, 13388 }, -- The Postmaster's Tunic
				{ 3, 13389 }, -- The Postmaster's Trousers
				{ 4, 13391 }, -- The Postmaster's Treads
				{ 5, 13392 }, -- The Postmaster's Seal
				{ 6, 13393 }, -- Malown's Slam
			},
		},
		{ -- STRATTimmytheCruel
			name = AL["Timmy the Cruel"],
			NameColor = GREEN,
			npcID = 10808,
			Level = 58,
			SubAreaID = 32319,
			DisplayIDs = {{571}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 226737 }, -- Lightforge Gauntlets
				{ 3, 228513 }, -- Vambraces of the Sadist
				{ 4, 228515 }, -- Grimgore Noose
				{ 5, 228514 }, -- Timmy's Galoshes
				{ 6, 13401 }, -- The Cruel Hand of Timmy
			},
			[NORMAL_DIFF] = {
				{ 1, 16724 }, -- Lightforge Gauntlets
				{ 3, 13400 }, -- Vambraces of the Sadist
				{ 4, 13403 }, -- Grimgore Noose
				{ 5, 13402 }, -- Timmy's Galoshes
				{ 6, 13401 }, -- The Cruel Hand of Timmy
			},
		},
		{ -- STRATMalorsStrongbox
			name = AL["Malor the Zealous"],
			NameColor = GREEN,
			npcID = 11032,
			ObjectID = 176112,
			Level = 60,
			SubAreaID = 32319,
			DisplayIDs = {{10458}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Malors Strongbox"], nil },
				{ 2, 12845 }, -- Medallion of Faith
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Malors Strongbox"], nil },
				{ 2, 12845 }, -- Medallion of Faith
			},
		},
		{ -- STRATCrimsonHammersmith
			name = AL["Crimson Hammersmith"],
			NameColor = GREEN,
			npcID = 11120,
			Level = 60,
			SubAreaID = 32357,
			DisplayIDs = {{10637}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1, 18781 }, -- Bottom Half of Advanced Armorsmithing: Volume II
			},
			[NORMAL_DIFF] = {
				{ 1, 18781 }, -- Bottom Half of Advanced Armorsmithing: Volume II
				--{ 3, 12824 }, -- Plans: Enchanted Battlehammer
			},
		},
		{ -- STRATCannonMasterWilley
			name = AL["Cannon Master Willey"],
			NameColor = GREEN,
			npcID = 10997,
			Level = 60,
			SubAreaID = 32357,
			DisplayIDs = {{10674}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1, 226706 }, -- Shadowcraft Spaulders
				{ 3, 22407 }, -- Helm of the New Moon
				{ 4, 228533 }, -- Nacreous Shell Necklace
				{ 5, 22405 }, -- Mantle of the Scarlet Crusade
				{ 6, 18721 }, -- Barrage Girdle
				{ 7, 13381 }, -- Master Cannoneer Boots
				{ 8, 228523 }, -- Cannonball Runner
				{ 9, 228522 }, -- Willey's Portable Howitzer
				{ 10, 13377 }, -- Miniature Cannon Balls
				{ 11, 22404 }, -- Willey's Back Scratcher
				{ 12, 22406 }, -- Redemption
				{ 14, 12839 }, -- Plans: Heartseeker
			},
			[NORMAL_DIFF] = {
				{ 1, 16708 }, -- Shadowcraft Spaulders
				{ 3, 22407 }, -- Helm of the New Moon
				{ 4, 22403 }, -- Diana's Pearl Necklace
				{ 5, 22405 }, -- Mantle of the Scarlet Crusade
				{ 6, 18721 }, -- Barrage Girdle
				{ 7, 13381 }, -- Master Cannoneer Boots
				{ 8, 13382 }, -- Cannonball Runner
				{ 9, 13380 }, -- Willey's Portable Howitzer
				{ 10, 13377 }, -- Miniature Cannon Balls
				{ 11, 22404 }, -- Willey's Back Scratcher
				{ 12, 22406 }, -- Redemption
				{ 14, 12839 }, -- Plans: Heartseeker
			},
		},
		{ -- STRATArchivistGalford
			name = AL["Archivist Galford"],
			NameColor = GREEN,
			npcID = 10811,
			Level = 60,
			SubAreaID = 32331,
			DisplayIDs = {{10544}},
			AtlasMapBossID = 10,
			[SOD_DIFF] = {
				{ 1, 226740 }, -- Devout Gloves
				{ 3, 13386 }, -- Archivist Cape
				{ 4, 13387 }, -- Foresight Girdle
				{ 5, 18716 }, -- Ash Covered Boots
				{ 6, 13385 }, -- Tome of Knowledge
				{ 8, 12811 }, -- Righteous Orb
				{ 10, 22897 }, -- Tome of Conjure Food VII
			},
			[NORMAL_DIFF] = {
				{ 1, 16692 }, -- Devout Gloves
				{ 3, 13386 }, -- Archivist Cape
				{ 4, 13387 }, -- Foresight Girdle
				{ 5, 18716 }, -- Ash Covered Boots
				{ 6, 13385 }, -- Tome of Knowledge
				{ 8, 12811 }, -- Righteous Orb
				{ 10, 22897 }, -- Tome of Conjure Food VII
			},
		},
		{ -- STRATBalnazzar
			name = AL["Balnazzar"],
			NameColor = GREEN,
			npcID = {10812, 10813},
			Level = 999,
			SubAreaID = 32367,
			DisplayIDs = {{10545}, {10691}},
			AtlasMapBossID = 11,
			[SOD_DIFF] = {
				{ 1, 228539 }, -- Book of the Dead
				{ 2, 14512 }, -- Pattern: Truefaith Vestments
				{ 3, 226738 }, -- Lightforge Boots
				{ 4, 228540 }, -- Crown of Tyranny
				{ 5, 228545 }, -- Grand Crusader's Helm
				{ 6, 228536 }, -- Star of Mystaria
				{ 7, 228546 }, -- Shroud of the Nathrezim
				{ 8, 13358 }, -- Wyrmtongue Shoulders
				{ 9, 13369 }, -- Fire Striders
				{ 10, 228541 }, -- Gift of the Elven Magi
				{ 11, 228544 }, -- Hammer of the Grand Crusader
				{ 12, 22334 }, -- Band of Mending
				{ 13, 13348 }, -- Demonshear
				{ 14, 13520 }, -- Recipe: Flask of Distilled Wisdom
				{ 15, 13250 }, -- Head of Balnazzar
			},
			[NORMAL_DIFF] = {
				{ 1, 13353 }, -- Book of the Dead
				{ 2, 14512 }, -- Pattern: Truefaith Vestments
				{ 3, 16725 }, -- Lightforge Boots
				{ 4, 13359 }, -- Crown of Tyranny
				{ 5, 18718 }, -- Grand Crusader's Helm
				{ 6, 12103 }, -- Star of Mystaria
				{ 7, 18720 }, -- Shroud of the Nathrezim
				{ 8, 13358 }, -- Wyrmtongue Shoulders
				{ 9, 13369 }, -- Fire Striders
				{ 10, 13360 }, -- Gift of the Elven Magi
				{ 11, 18717 }, -- Hammer of the Grand Crusader
				{ 12, 22334 }, -- Band of Mending
				{ 13, 13348 }, -- Demonshear
				{ 14, 13520 }, -- Recipe: Flask of Distilled Wisdom
				{ 15, 13250 }, -- Head of Balnazzar
			},
		},
		{ -- STRATMagistrateBarthilas
			name = AL["Magistrate Barthilas"],
			NameColor = PURP,
			npcID = 10435,
			Level = 58,
			SubAreaID = 32342,
			DisplayIDs = {{10433}},
			AtlasMapBossID = 12,
			[SOD_DIFF] = {
				{ 1, 18727 }, -- Crimson Felt Hat
				{ 2, 228505 }, -- Royal Tribunal Cloak
				{ 3, 228518 }, -- Magistrate's Cuffs
				{ 4, 18722 }, -- Death Grips
				{ 5, 23198 }, -- Idol of Brutality
				{ 6, 228516 }, -- Peacemaker
				{ 8, 12382 }, -- Key to the City
			},
			[NORMAL_DIFF] = {
				{ 1, 18727 }, -- Crimson Felt Hat
				{ 2, 13376 }, -- Royal Tribunal Cloak
				{ 3, 18726 }, -- Magistrate's Cuffs
				{ 4, 18722 }, -- Death Grips
				{ 5, 23198 }, -- Idol of Brutality
				{ 6, 18725 }, -- Peacemaker
				{ 8, 12382 }, -- Key to the City
			},
		},
		{ -- STRATStonespine
			name = AL["Stonespine"],
			NameColor = PURP,
			npcID = 10809,
			Level = 60,
			SubAreaID = 32303,
			DisplayIDs = {{7856}},
			AtlasMapBossID = 14,
			specialType = "rare",
			[SOD_DIFF] = {
				{ 1, 13397 }, -- Stoneskin Gargoyle Cape
				{ 2, 13954 }, -- Verdant Footpads
				{ 3, 13399 }, -- Gargoyle Shredder Talons
			},
			[NORMAL_DIFF] = {
				{ 1, 13397 }, -- Stoneskin Gargoyle Cape
				{ 2, 13954 }, -- Verdant Footpads
				{ 3, 13399 }, -- Gargoyle Shredder Talons
			},
		},
		{ -- STRATBaronessAnastari
			name = AL["Baroness Anastari"],
			NameColor = PURP,
			npcID = 10436,
			Level = 59,
			SubAreaID = 32344,
			DisplayIDs = {{10698}},
			AtlasMapBossID = 15,
			[SOD_DIFF] = {
				{ 1, 226763 }, -- Dreadmist Sandals
				{ 3, 18728 }, -- Anastari Heirloom
				{ 4, 228521 }, -- Shadowy Laced Handwraps
				{ 5, 18729 }, -- Screeching Bow
				{ 6, 13534 }, -- Banshee Finger
				{ 8, 13538 }, -- Windshrieker Pauldrons
				{ 9, 13535 }, -- Coldtouch Phantom Wraps
				{ 10, 13537 }, -- Chillhide Bracers
				{ 11, 13539 }, -- Banshee's Touch
				{ 12, 13514 }, -- Wail of the Banshee
			},
			[NORMAL_DIFF] = {
				{ 1, 16704 }, -- Dreadmist Sandals
				{ 3, 18728 }, -- Anastari Heirloom
				{ 4, 18730 }, -- Shadowy Laced Handwraps
				{ 5, 18729 }, -- Screeching Bow
				{ 6, 13534 }, -- Banshee Finger
				{ 8, 13538 }, -- Windshrieker Pauldrons
				{ 9, 13535 }, -- Coldtouch Phantom Wraps
				{ 10, 13537 }, -- Chillhide Bracers
				{ 11, 13539 }, -- Banshee's Touch
				{ 12, 13514 }, -- Wail of the Banshee
			},
		},
		{ -- STRATBlackGuardSwordsmith
			name = AL["Black Guard Swordsmith"],
			NameColor = PURP,
			npcID = 11121,
			Level = {61, 62},
			SubAreaID = 32345,
			DisplayIDs = {{775}},
			AtlasMapBossID = 15,
			[SOD_DIFF] = {
				{ 1, 18783 }, -- Bottom Half of Advanced Armorsmithing: Volume III
				--{ 2, 12725 }, -- Plans: Enchanted Thorium Helm
				--{ 3, 12620 }, -- Enchanted Thorium Helm
				--{ 3, 12825 }, -- Plans: Blazing Rapier
				--{ 6, 12777 }, -- Blazing Rapier
			},
			[NORMAL_DIFF] = {
				{ 1, 18783 }, -- Bottom Half of Advanced Armorsmithing: Volume III
				--{ 2, 12725 }, -- Plans: Enchanted Thorium Helm
				--{ 3, 12620 }, -- Enchanted Thorium Helm
				--{ 3, 12825 }, -- Plans: Blazing Rapier
				--{ 6, 12777 }, -- Blazing Rapier
			},
		},
		{ -- STRATNerubenkan
			name = AL["Nerub'enkan"],
			NameColor = PURP,
			npcID = 10437,
			Level = 60,
			SubAreaID = 32345,
			DisplayIDs = {{9793}},
			AtlasMapBossID = 16,
			[SOD_DIFF] = {
				{ 1, 226722 }, -- Beaststalker's Boots
				{ 3, 228530 }, -- Chitinous Plate Legguards
				{ 4, 228531 }, -- Thuzadin Sash
				{ 5, 18738 }, -- Carapace Spine Crossbow
				{ 6, 13529 }, -- Husk of Nerub'enkan
				{ 8, 13533 }, -- Acid-etched Pauldrons
				{ 9, 13532 }, -- Darkspinner Claws
				{ 10, 13531 }, -- Crypt Stalker Leggings
				{ 11, 13530 }, -- Fangdrip Runners
				{ 12, 13508 }, -- Eye of Arachnida
			},
			[NORMAL_DIFF] = {
				{ 1, 16675 }, -- Beaststalker's Boots
				{ 3, 18740 }, -- Thuzadin Sash
				{ 4, 18739 }, -- Chitinous Plate Legguards
				{ 5, 18738 }, -- Carapace Spine Crossbow
				{ 6, 13529 }, -- Husk of Nerub'enkan
				{ 8, 13533 }, -- Acid-etched Pauldrons
				{ 9, 13532 }, -- Darkspinner Claws
				{ 10, 13531 }, -- Crypt Stalker Leggings
				{ 11, 13530 }, -- Fangdrip Runners
				{ 12, 13508 }, -- Eye of Arachnida
			},
		},
		{ -- STRATMalekithePallid
			name = AL["Maleki the Pallid"],
			NameColor = PURP,
			npcID = 10438,
			Level = 61,
			SubAreaID = 32349,
			DisplayIDs = {{10546}},
			AtlasMapBossID = 17,
			[SOD_DIFF] = {
				{ 1, 226743 }, -- Devout Sandals
				{ 3, 18734 }, -- Pale Moon Cloak
				{ 4, 18735 }, -- Maleki's Footwraps
				{ 5, 13524 }, -- Skull of Burning Shadows
				{ 6, 228535 }, -- Bone Slicing Hatchet
				{ 8, 13528 }, -- Twilight Void Bracers
				{ 9, 13525 }, -- Darkbind Fingers
				{ 10, 13526 }, -- Flamescarred Girdle
				{ 11, 13527 }, -- Lavawalker Greaves
				{ 12, 13509 }, -- Clutch of Foresight
				{ 14, 12833 }, -- Plans: Hammer of the Titans
			},
			[NORMAL_DIFF] = {
				{ 1, 16691 }, -- Devout Sandals
				{ 3, 18734 }, -- Pale Moon Cloak
				{ 4, 18735 }, -- Maleki's Footwraps
				{ 5, 13524 }, -- Skull of Burning Shadows
				{ 6, 18737 }, -- Bone Slicing Hatchet
				{ 8, 13528 }, -- Twilight Void Bracers
				{ 9, 13525 }, -- Darkbind Fingers
				{ 10, 13526 }, -- Flamescarred Girdle
				{ 11, 13527 }, -- Lavawalker Greaves
				{ 12, 13509 }, -- Clutch of Foresight
				{ 14, 12833 }, -- Plans: Hammer of the Titans
			},
		},
		{ -- STRATRamsteintheGorger
			name = AL["Ramstein the Gorger"],
			NameColor = PURP,
			npcID = 10439,
			Level = 61,
			SubAreaID = 32301,
			DisplayIDs = {{12818}},
			AtlasMapBossID = 18,
			[SOD_DIFF] = {
				{ 1, 226771 }, -- Gauntlets of Valor
				{ 3, 18723 }, -- Animated Chain Necklace
				{ 4, 228520 }, -- Soulstealer Mantle
				{ 5, 13373 }, -- Band of Flesh
				{ 6, 13515 }, -- Ramstein's Lightning Bolts
				{ 7, 13375 }, -- Crest of Retribution
				{ 8, 13372 }, -- Slavedriver's Cane
			},
			[NORMAL_DIFF] = {
				{ 1, 16737 }, -- Gauntlets of Valor
				{ 3, 18723 }, -- Animated Chain Necklace
				{ 4, 13374 }, -- Soulstealer Mantle
				{ 5, 13373 }, -- Band of Flesh
				{ 6, 13515 }, -- Ramstein's Lightning Bolts
				{ 7, 13375 }, -- Crest of Retribution
				{ 8, 13372 }, -- Slavedriver's Cane
			},
		},
		{ -- STRATBaronRivendare
			name = AL["Baron Rivendare"],
			NameColor = PURP,
			npcID = 10440,
			Level = 62,
			SubAreaID = 32352,
			DisplayIDs = {{10729}},
			AtlasMapBossID = 19,
			[SOD_DIFF] = {
				{ 1, 13335 }, -- Deathcharger's Reins
				{ 2, 228543 }, -- Runeblade of Baron Rivendare
				{ 4, 228553 }, -- Helm of the Executioner
				{ 5, 22412 }, -- Thuzadin Mantle
				{ 6, 13340 }, -- Cape of the Black Baron
				{ 7, 13346 }, -- Robes of the Exalted
				{ 8, 228551 }, -- Tunic of the Crescent Moon
				{ 9, 228537 }, -- Dracorian Gauntlets
				{ 10, 228552 }, -- Gauntlets of Deftness
				{ 11, 228538 }, -- Seal of Rivendare
				{ 12, 22408 }, -- Ritssyn's Wand of Bad Mojo
				{ 13, 13349 }, -- Scepter of the Unholy
				{ 14, 13368 }, -- Bonescraper
				{ 15, 228542 }, -- Skullforge Reaver
				{ 16, 226747 }, -- Devout Skirt
				{ 17, 226727 }, -- Magister's Leggings
				{ 18, 226760 }, -- Dreadmist Leggings
				{ 19, 226705 }, -- Shadowcraft Pants
				{ 20, 226709 }, -- Wildheart Kilt
				{ 21, 226719 }, -- Beaststalker's Pants
				{ 22, 226750 }, -- Kilt of Elements
				{ 23, 226736 }, -- Lightforge Legplates
				{ 24, 226767 }, -- Legplates of Valor
			},
			[NORMAL_DIFF] = {
				{ 1, 13335 }, -- Deathcharger's Reins
				{ 2, 13505 }, -- Runeblade of Baron Rivendare
				{ 4, 22411 }, -- Helm of the Executioner
				{ 5, 22412 }, -- Thuzadin Mantle
				{ 6, 13340 }, -- Cape of the Black Baron
				{ 7, 13346 }, -- Robes of the Exalted
				{ 8, 22409 }, -- Tunic of the Crescent Moon
				{ 9, 13344 }, -- Dracorian Gauntlets
				{ 10, 22410 }, -- Gauntlets of Deftness
				{ 11, 13345 }, -- Seal of Rivendare
				{ 12, 22408 }, -- Ritssyn's Wand of Bad Mojo
				{ 13, 13349 }, -- Scepter of the Unholy
				{ 14, 13368 }, -- Bonescraper
				{ 15, 13361 }, -- Skullforge Reaver
				{ 16, 16694 }, -- Devout Skirt
				{ 17, 16687 }, -- Magister's Leggings
				{ 18, 16699 }, -- Dreadmist Leggings
				{ 19, 16709 }, -- Shadowcraft Pants
				{ 20, 16719 }, -- Wildheart Kilt
				{ 21, 16678 }, -- Beaststalker's Pants
				{ 22, 16668 }, -- Kilt of Elements
				{ 23, 16728 }, -- Lightforge Legplates
				{ 24, 16732 }, -- Legplates of Valor
			},
		},
		{ -- STRATTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 228532 }, -- Morlune's Bracer
				{ 2, 228534 }, -- Plaguehound Leggings
				{ 3, 226742 }, -- Devout Bracers
				{ 4, 226724 }, -- Magister's Belt
				{ 5, 226761 }, -- Dreadmist Belt
				{ 6, 226704 }, -- Shadowcraft Bracers
				{ 7, 226714 }, -- Wildheart Bracers
				{ 8, 226717 }, -- Beaststalker's Bindings
				{ 9, 226751 }, -- Bindings of Elements
				{ 10, 226732 }, -- Lightforge Belt
				{ 11, 226765 }, -- Belt of Valor
				{ 12, 16249 }, -- Formula: Enchant 2H Weapon - Major Intellect
				{ 13, 16248 }, -- Formula: Enchant Weapon - Unholy
				{ 14, 14495 }, -- Pattern: Ghostweave Pants
				{ 15, 15777 }, -- Pattern: Runic Leather Shoulders
				{ 16, 18742 }, -- Stratholme Militia Shoulderguard
				{ 17, 18743 }, -- Gracious Cape
				{ 18, 17061 }, -- Juno's Shadow
				{ 19, 18744 }, -- Plaguebat Fur Gloves
				{ 20, 18745 }, -- Sacred Cloth Leggings
				{ 21, 12811 }, -- Righteous Orb
				{ 22, 12735 }, -- Frayed Abomination Stitching
				{ 23, 12843 }, -- Corruptor's Scourgestone
				{ 24, 12841 }, -- Invader's Scourgestone
				{ 25, 12840 }, -- Minion's Scourgestone
				{ 28, 15768 }, -- Pattern: Wicked Leather Belt
				{ 29, 18658 }, -- Schematic: Ultra-Flash Shadow Reflector
				{ 30, 16052 }, -- Schematic: Voice Amplification Modulator
			},
			[NORMAL_DIFF] = {
				{ 1, 18741 }, -- Morlune's Bracer
				{ 2, 18736 }, -- Plaguehound Leggings
				{ 3, 16697 }, -- Devout Bracers
				{ 4, 16685 }, -- Magister's Belt
				{ 5, 16702 }, -- Dreadmist Belt
				{ 6, 16710 }, -- Shadowcraft Bracers
				{ 7, 16714 }, -- Wildheart Bracers
				{ 8, 16681 }, -- Beaststalker's Bindings
				{ 9, 16671 }, -- Bindings of Elements
				{ 10, 16723 }, -- Lightforge Belt
				{ 11, 16736 }, -- Belt of Valor
				{ 12, 16249 }, -- Formula: Enchant 2H Weapon - Major Intellect
				{ 13, 16248 }, -- Formula: Enchant Weapon - Unholy
				{ 14, 14495 }, -- Pattern: Ghostweave Pants
				{ 15, 15777 }, -- Pattern: Runic Leather Shoulders
				{ 16, 18742 }, -- Stratholme Militia Shoulderguard
				{ 17, 18743 }, -- Gracious Cape
				{ 18, 17061 }, -- Juno's Shadow
				{ 19, 18744 }, -- Plaguebat Fur Gloves
				{ 20, 18745 }, -- Sacred Cloth Leggings
				{ 21, 12811 }, -- Righteous Orb
				{ 22, 12735 }, -- Frayed Abomination Stitching
				{ 23, 12843 }, -- Corruptor's Scourgestone
				{ 24, 12841 }, -- Invader's Scourgestone
				{ 25, 12840 }, -- Minion's Scourgestone
				{ 28, 15768 }, -- Pattern: Wicked Leather Belt
				{ 29, 18658 }, -- Schematic: Ultra-Flash Shadow Reflector
				{ 30, 16052 }, -- Schematic: Voice Amplification Modulator
			},
		},
		{ -- STRATBSPlansSerenity / STRATBSPlansCorruption
			name = AL["Plans"],
			ExtraList = true,
			IgnoreAsSource = true,
			[SOD_DIFF] = {
				{ 1, 12827 }, -- Plans: Serenity
				{ 16, 12830 }, -- Plans: Corruption
			},
			[NORMAL_DIFF] = {
				{ 1, 12827 }, -- Plans: Serenity
				{ 16, 12830 }, -- Plans: Corruption
			},
		},
		{ -- STRATAtiesh
			name = AL["Atiesh"],
			NameColor = GREEN,
			ExtraList = true,
			AtlasMapBossID = 2,
			ContentPhase = 6,
			[SOD_DIFF] = {
				{ 1, 22736 }, -- Andonisus, Reaper of Souls
			},
			[NORMAL_DIFF] = {
				{ 1, 22736 }, -- Andonisus, Reaper of Souls
			},
		},
		{ -- STRATBalzaphon
			name = AL["Balzaphon"],
			NameColor = GREEN,
			ExtraList = true,
			specialType = "scourgeInvasion",
			npcID = 14684,
			DisplayIDs = {{7919}},
			AtlasMapBossID = 2,
			ContentPhase = 6,
			[SOD_DIFF] = {
				{ 1, 23126 }, -- Waistband of Balzaphon
				{ 2, 23125 }, -- Chains of the Lich
				{ 3, 23124 }, -- Staff of Balzaphon
			},
			[NORMAL_DIFF] = {
				{ 1, 23126 }, -- Waistband of Balzaphon
				{ 2, 23125 }, -- Chains of the Lich
				{ 3, 23124 }, -- Staff of Balzaphon
			},
		},
		{ -- STRATSothosJarien
			name = AL["Sothos and Jarien's Heirlooms"].." - "..format(AL["Tier %s Sets"], "0.5"),
			NameColor = GREEN,
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 11,
			[SOD_DIFF] = {
				{ 1, 228547 }, -- Ironweave Robe
				{ 2, 228548 }, -- Scepter of Interminable Focus
				{ 3, 22327 }, -- Amulet of the Redeemed
				{ 4, 22328 }, -- Legplates of Vigilance
				{ 5, 22334 }, -- Band of Mending
			},
			[NORMAL_DIFF] = {
				{ 1, 22327 }, -- Amulet of the Redeemed
				{ 2, 22301 }, -- Ironweave Robe
				{ 3, 22328 }, -- Legplates of Vigilance
				{ 4, 22334 }, -- Band of Mending
				{ 5, 22329 }, -- Scepter of Interminable Focus
			},
		},
		KEYS,
	},
}

-- ########################
-- Raids
-- ########################

data["WorldBosses2"] = {
	name = AL["World Bosses"],
	AtlasMapFile = "Azuregos",
	ContentType = RAID_CONTENT,
	LevelRange = GetForVersion({60, 60, 60},{60, 60, 60}),
	ContentPhase = 2,
	items = {
		{ -- AAzuregos
			name = AL["Azuregos"],
			AtlasMapFile = "Azuregos",
			npcID = 6109,
			Level = 999,
			ContentPhase = 2,
			DisplayIDs = {{11460}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  228385 }, -- Crystal Adorned Crown
				{ 2,  228389 }, -- Drape of Benediction
				{ 3,  228383 }, -- Puissant Cape
				{ 4,  228340 }, -- Unmelting Ice Girdle
				{ 5,  228345 }, -- Leggings of Arcane Supremacy
				{ 6,  228384 }, -- Snowblind Shoes
				{ 7,  228381 }, -- Cold Snap
				{ 8,  228382 }, -- Fang of the Mystics
				{ 9,  228349 }, -- Eskhandar's Left Claw
				{ 10, 228347 }, -- Typhoon
				{ 16, 18704 }, -- Mature Blue Dragon Sinew
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
			[NORMAL_DIFF] = {
				{ 1,  19132 }, -- Crystal Adorned Crown
				{ 2,  18208 }, -- Drape of Benediction
				{ 3,  18541 }, -- Puissant Cape
				{ 4,  18547 }, -- Unmelting Ice Girdle
				{ 5,  18545 }, -- Leggings of Arcane Supremacy
				{ 6,  19131 }, -- Snowblind Shoes
				{ 7,  19130 }, -- Cold Snap
				{ 8,  17070 }, -- Fang of the Mystics
				{ 9,  18202 }, -- Eskhandar's Left Claw
				{ 10, 18542 }, -- Typhoon
				{ 16, 18704 }, -- Mature Blue Dragon Sinew
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- KKazzak
			name = AL["Lord Kazzak"],
			AtlasMapFile = "LordKazzak",
			npcID = 12397,
			Level = 999,
			ContentPhase = 2,
			DisplayIDs = {{12449}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1, 228353 }, -- Infernal Headcage
				{ 2, 228354 }, -- Blazefury Medallion
				{ 3, 228360 }, -- Eskhandar's Pelt
				{ 4, 228357 }, -- Blacklight Bracer
				{ 5, 228351 }, -- Doomhide Gauntlets
				{ 6, 228355 }, -- Flayed Doomguard Belt
				{ 7, 228352 }, -- Fel Infused Leggings
				{ 8, 228359 }, -- Ring of Entropy
				{ 9, 228397 }, -- Empyrean Demolisher
				{ 10, 228356 }, -- Amberseal Keeper
				{ 16, 18665 }, -- The Eye of Shadow
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
			[NORMAL_DIFF] = {
				{ 1,  18546 }, -- Infernal Headcage
				{ 2,  17111 }, -- Blazefury Medallion
				{ 3,  18204 }, -- Eskhandar's Pelt
				{ 4,  19135 }, -- Blacklight Bracer
				{ 5,  18544 }, -- Doomhide Gauntlets
				{ 6,  19134 }, -- Flayed Doomguard Belt
				{ 7,  19133 }, -- Fel Infused Leggings
				{ 8,  18543 }, -- Ring of Entropy
				{ 9,  17112 }, -- Empyrean Demolisher
				{ 10, 17113 }, -- Amberseal Keeper
				{ 16, 18665 }, -- The Eye of Shadow
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- PrinceThunderaan
			name = AL["Prince Thunderaan"],
			npcID = 14435,
			Level = 999,
			DisplayIDs = {{15825}},
			[SOD_DIFF] = {
				{ 1, 231725 }, -- Ancient Belt
				{ 2, 231716 }, -- Primeval Belt
				{ 3, 231708 }, -- Draconian Belt
				{ 5, 19018 }, -- Dormant Wind Kissed Blade
				{ 16, 231782 }, -- Crown of the Successor
				{ 17, 231783 }, -- Drape of the Windlord
				{ 18, 231785 }, -- Echoes of Betrayal
				{ 19, 231815 }, -- Fleshrend
				{ 20, 231784 }, -- Lighhtning's Call
				{ 21, 231753 }, -- Skywall's Solace
				{ 22, 231777 }, -- Crystallized Qiraji Limb
				{ 23, 231387 }, -- Stormwrath, Snactified Shortblade of the Galefinder
				{ 24, 231781 }, -- Soul of Thunder
				{ 25, 231823 }, -- Geddon's Glaive
				{ 26, 231817 }, -- Windstriker
				{ 27, 231779 }, -- Wrath of Wray
			},
			[NORMAL_DIFF] = {
				{ 1, 19018 }, -- Dormant Wind Kissed Blade
			},
		},
		{ -- DLethon
			name = AL["Lethon"],
			AtlasMapFile = "FourDragons",
			npcID = 14888,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{15365}},
			[SOD_DIFF] = {
				{ 1,  234164 }, -- Deviate Growth Cap
				{ 2,  234162 }, -- Black Bark Wristbands
				{ 3,  234165 }, -- Gauntlets of the Shining Light
				{ 4,  234161 }, -- Belt of the Dark Bog
				{ 5,  234163 }, -- Dark Heart Pants
				{ 6,  234166 }, -- Malignant Footguards
				{ 9,  234151 }, -- Green Dragonskin Cloak
				{ 10, 234149 }, -- Dragonspur Wraps
				{ 11, 234148 }, -- Dragonbone Wristguards
				{ 12, 234150 }, -- Gloves of Delusional Power
				{ 13, 234147 }, -- Ancient Corroded Leggings
				{ 14, 234146 }, -- Acid Inscribed Greaves
				{ 15, 234154 }, -- Trance Stone
				{ 16, 235049 }, -- Nightmare Engulfed Object
				{ 17, 234155 }, -- Malfurion's Signet Ring
				{ 24, 234152 }, -- Hammer of Bestial Fury
				{ 25, 234153 }, -- Staff of Rampant Growth
				{ 29, 20381 }, -- Dreamscale
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
			[NORMAL_DIFF] = {
				{ 1,  20628 }, -- Deviate Growth Cap
				{ 2,  20626 }, -- Black Bark Wristbands
				{ 3,  20630 }, -- Gauntlets of the Shining Light
				{ 4,  20625 }, -- Belt of the Dark Bog
				{ 5,  20627 }, -- Dark Heart Pants
				{ 6,  20629 }, -- Malignant Footguards
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 29, 20381 }, -- Dreamscale
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DEmeriss
			name = AL["Emeriss"],
			AtlasMapFile = "FourDragons",
			npcID = 14889,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{15366}},
			[SOD_DIFF] = {
				{ 1,  234157 }, -- Circlet of Restless Dreams
				{ 2,  234158 }, -- Dragonheart Necklace
				{ 3,  234160 }, -- Ring of the Unliving
				{ 4,  234156 }, -- Boots of the Endless Moor
				{ 5,  234159 }, -- Polished Ironwood Crossbow
				{ 9,  234151 }, -- Green Dragonskin Cloak
				{ 10, 234149 }, -- Dragonspur Wraps
				{ 11, 234148 }, -- Dragonbone Wristguards
				{ 12, 234150 }, -- Gloves of Delusional Power
				{ 13, 234147 }, -- Ancient Corroded Leggings
				{ 14, 234146 }, -- Acid Inscribed Greaves
				{ 15, 234154 }, -- Trance Stone
				{ 16, 235049 }, -- Nightmare Engulfed Object
				{ 17, 234155 }, -- Malfurion's Signet Ring
				{ 24, 234152 }, -- Hammer of Bestial Fury
				{ 25, 234153 }, -- Staff of Rampant Growth
				{ 29, 20381 }, -- Dreamscale
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
			[NORMAL_DIFF] = {
				{ 1,  20623 }, -- Circlet of Restless Dreams
				{ 2,  20622 }, -- Dragonheart Necklace
				{ 3,  20624 }, -- Ring of the Unliving
				{ 4,  20621 }, -- Boots of the Endless Moor
				{ 5,  20599 }, -- Polished Ironwood Crossbow
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DTaerar
			name = AL["Taerar"],
			AtlasMapFile = "FourDragons",
			npcID = 14890,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{15363}, {15367}},
			[SOD_DIFF] = {
				{ 1,  234171 }, -- Unnatural Leather Spaulders
				{ 2,  234168 }, -- Mendicant's Slippers
				{ 3,  234167 }, -- Boots of Fright
				{ 4,  234169 }, -- Mindtear Band
				{ 5,  234170 }, -- Nightmare Blade
				{ 9,  234151 }, -- Green Dragonskin Cloak
				{ 10, 234149 }, -- Dragonspur Wraps
				{ 11, 234148 }, -- Dragonbone Wristguards
				{ 12, 234150 }, -- Gloves of Delusional Power
				{ 13, 234147 }, -- Ancient Corroded Leggings
				{ 14, 234146 }, -- Acid Inscribed Greaves
				{ 15, 234154 }, -- Trance Stone
				{ 16, 235049 }, -- Nightmare Engulfed Object
				{ 17, 234155 }, -- Malfurion's Signet Ring
				{ 24, 234152 }, -- Hammer of Bestial Fury
				{ 25, 234153 }, -- Staff of Rampant Growth
				{ 29, 20381 }, -- Dreamscale
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
			[NORMAL_DIFF] = {
				{ 1,  20633 }, -- Unnatural Leather Spaulders
				{ 2,  20631 }, -- Mendicant's Slippers
				{ 3,  20634 }, -- Boots of Fright
				{ 4,  20632 }, -- Mindtear Band
				{ 5,  20577 }, -- Nightmare Blade
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DYsondre
			name = AL["Ysondre"],
			AtlasMapFile = "FourDragons",
			npcID = 14887,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{15364}},
			[SOD_DIFF] = {
				{ 1,  234174 }, -- Acid Inscribed Pauldrons
				{ 2,  234962 }, -- Jade Inlaid Vestments
				{ 3,  234173 }, -- Leggings of the Demented Mind
				{ 4,  234963 }, -- Strangely Glyphed Legplates
				{ 5,  234175 }, -- Hibernation Crystal
				{ 6,  234172 }, -- Emerald Dragonfang
				{ 9,  234151 }, -- Green Dragonskin Cloak
				{ 10, 234149 }, -- Dragonspur Wraps
				{ 11, 234148 }, -- Dragonbone Wristguards
				{ 12, 234150 }, -- Gloves of Delusional Power
				{ 13, 234147 }, -- Ancient Corroded Leggings
				{ 14, 234146 }, -- Acid Inscribed Greaves
				{ 15, 234154 }, -- Trance Stone
				{ 16, 235049 }, -- Nightmare Engulfed Object
				{ 17, 234155 }, -- Malfurion's Signet Ring
				{ 24, 234152 }, -- Hammer of Bestial Fury
				{ 25, 234153 }, -- Staff of Rampant Growth
				{ 29, 20381 }, -- Dreamscale
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
			[NORMAL_DIFF] = {
				{ 1,  20637 }, -- Acid Inscribed Pauldrons
				{ 2,  20635 }, -- Jade Inlaid Vestments
				{ 3,  20638 }, -- Leggings of the Demented Mind
				{ 4,  20639 }, -- Strangely Glyphed Legplates
				{ 5,  20636 }, -- Hibernation Crystal
				{ 6,  20578 }, -- Emerald Dragonfang
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
	},
}

data["MoltenCore2"] = {
	MapID = 2717,
	InstanceID = 409,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "MoltenCore",
	AtlasMapFile = "CL_MoltenCore",
	AtlasMapFile_AL = "MoltenCore",
	ContentType = RAID_CONTENT,
	LevelRange = GetForVersion({60, 60, 60},{60, 60, 60}),
	items = {
		{	--MCLucifron
			name = AL["Lucifron"],
			npcID = 12118,
			Level = 999,
			DisplayIDs = {{13031},{12030}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1, 227533 },	-- Incandescent Gloves
				{ 2, 227759 },	-- Scorched Core Gloves
				{ 3, 227756 },	-- Molten Scaled Gloves
				{ 16, 228285 },	-- Helm of the Lifegiver
				{ 17, 228247 },	-- Choker of Enlightenment
				{ 18, 228239 },	-- Robe of Volatile Power
				{ 19, 228246 },	-- Wristguards of Stability
				{ 20, 228244 },	-- Manastorm Leggings
				{ 21, 228245 },	-- Salamander Scale Pants
				{ 22, 228240 },	-- Flamewaker Legplates
				{ 23, 228242 },	-- Heavy Dark Iron Ring
				{ 24, 228243},	-- Ring of Spell Power
				{ 25, 228262 },	-- Crimson Shocker
				{ 26, 228263 },	-- Sorcerous Dagger
				{ 27, 228127 },	-- Wristguards of Instability
				{ 30, 16665 },	-- Tome of Tranquilizing Shot
			},
			[NORMAL_DIFF] = {
				{ 1, 16800 },	-- Arcanist Boots
				{ 2, 16805 },	-- Felheart Gloves
				{ 3, 16829 },	-- Cenarion Boots
				{ 4, 16837 },	-- Earthfury Boots
				{ 5, 16859 },	-- Lawbringer Boots
				{ 6, 16863 },	-- Gauntlets of Might
				{ 16, 18870 },	-- Helm of the Lifegiver
				{ 17, 17109 },	-- Choker of Enlightenment
				{ 18, 19145 },	-- Robe of Volatile Power
				{ 19, 19146 },	-- Wristguards of Stability
				{ 20, 18872 },	-- Manastorm Leggings
				{ 21, 18875 },	-- Salamander Scale Pants
				{ 22, 18861 },	-- Flamewaker Legplates
				{ 23, 18879 },	-- Heavy Dark Iron Ring
				{ 24, 19147 },	-- Ring of Spell Power
				{ 25, 17077 },	-- Crimson Shocker
				{ 26, 18878 },	-- Sorcerous Dagger
				{ 30, 16665 },	-- Tome of Tranquilizing Shot
			},
		},
		{	--MCMagmadar
			name = AL["Magmadar"],
			npcID = 11982,
			Level = 999,
			DisplayIDs = {{10193}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1, 227763 },	-- Scorched Core Leggings
				{ 2, 227534 },	-- Incandescent Leggings
				{ 3, 227754 },	-- Molten Scaled Leggings
				{ 5, 228146 },	-- Magmadar's Left Claw
				{ 6, 228101 },	-- Hide of the Behemoth
				{ 16, 228249 },	-- Medallion of Steadfast Might
				{ 17, 228258 },	-- Deep Earth Spaulders
				{ 18, 228257 },	-- Aged Core Leather Gloves
				{ 19, 228260 },	-- Flameguard Gauntlets
				{ 20, 228256 },	-- Mana Igniting Cord
				{ 21, 228240 },	-- Flamewaker Legplates
				{ 22, 228253 },	-- Sabatons of the Flamewalker
				{ 23, 228254 },	-- Magma Tempered Boots
				{ 24, 228261 },	-- Quick Strike Ring
				{ 25, 228255 },	-- Talisman of Ephemeral Power
				{ 26, 228259 },	-- Fire Runed Grimoire
				{ 27, 228252 },	-- Striker's Mark
				{ 28, 228248 },	-- Earthshaker
				{ 29, 228229 },	-- Obsidian Edged Blade
			},
			[NORMAL_DIFF] = {
				{ 1,  16814 },	-- Pants of Prophecy
				{ 2,  16796 },	-- Arcanist Leggings
				{ 3,  16810 },	-- Felheart Pants
				{ 4,  16822 },	-- Nightslayer Pants
				{ 5,  16835 },	-- Cenarion Leggings
				{ 6,  16847 },	-- Giantstalker's Leggings
				{ 7,  16843 },	-- Earthfury Legguards
				{ 8,  16855 },	-- Lawbringer Legplates
				{ 9,  16867 },	-- Legplates of Might
				{ 11, 18203 },	-- Eskhandar's Right Claw
				{ 16, 17065 },	-- Medallion of Steadfast Might
				{ 17, 18829 },	-- Deep Earth Spaulders
				{ 18, 18823 },	-- Aged Core Leather Gloves
				{ 19, 19143 },	-- Flameguard Gauntlets
				{ 20, 19136 },	-- Mana Igniting Cord
				{ 21, 18861 },	-- Flamewaker Legplates
				{ 22, 19144 },	-- Sabatons of the Flamewalker
				{ 23, 18824 },	-- Magma Tempered Boots
				{ 24, 18821 },	-- Quick Strike Ring
				{ 25, 18820 },	-- Talisman of Ephemeral Power
				{ 26, 19142 },	-- Fire Runed Grimoire
				{ 27, 17069 },	-- Striker's Mark
				{ 28, 17073 },	-- Earthshaker
				{ 29, 18822 },	-- Obsidian Edged Blade
			},
		},
		{	--MCGehennas
			name = AL["Gehennas"],
			npcID = 12259,
			Level = 999,
			DisplayIDs = {{13030},{12002}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 227765 },	-- Scorched Core Boots
				{ 2, 227757 },	-- Molten Scaled Boots
				{ 3, 227533 },	-- Incandescent Gloves
				{ 5, 228350 },	-- Eskhandar's Right Claw
   				{ 16, 228285 },	-- Helm of the Lifegiver
				{ 17, 228239 },	-- Robe of Volatile Power
				{ 18, 228246 },	-- Wristguards of Stability
				{ 19, 228244 },	-- Manastorm Leggings
				{ 20, 228245 },	-- Salamander Scale Pants
				{ 21, 228240 },	-- Flamewaker Legplates
				{ 22, 228242 },	-- Heavy Dark Iron Ring
				{ 23, 228243 },	-- Ring of Spell Power
				{ 24, 228262 },	-- Crimson Shocker
				{ 25, 228263 },	-- Sorcerous Dagger
				{ 26, 228127 },	-- Wristguards of Instability
			},
			[NORMAL_DIFF] = {
				{ 1,  16812 },	-- Gloves of Prophecy
				{ 2,  16826 },	-- Nightslayer Gloves
				{ 3,  16849 },	-- Giantstalker's Boots
				{ 4,  16839 },	-- Earthfury Gauntlets
				{ 5,  16860 },	-- Lawbringer Gauntlets
				{ 6,  16862 },	-- Sabatons of Might
				{ 16, 18870 },	-- Helm of the Lifegiver
				{ 17, 19145 },	-- Robe of Volatile Power
				{ 18, 19146 },	-- Wristguards of Stability
				{ 19, 18872 },	-- Manastorm Leggings
				{ 20, 18875 },	-- Salamander Scale Pants
				{ 21, 18861 },	-- Flamewaker Legplates
				{ 22, 18879 },	-- Heavy Dark Iron Ring
				{ 23, 19147 },	-- Ring of Spell Power
				{ 24, 17077 },	-- Crimson Shocker
				{ 25, 18878 },	-- Sorcerous Dagger
			},
		},
		{	--MCGarr
			name = AL["Garr"],
			npcID = 12057,
			Level = 999,
			DisplayIDs = {{12110}, {5781}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1, 18564 },	-- Bindings of the Windseeker
				{ 3, 227532 },	-- Incandescent Hood
				{ 4, 227764 },	-- Scorched Core Helm
				{ 5, 227755 },	-- Molten Scaled Helm
				{ 7, 228139 },	-- Fist of the Firesworn
				{ 8, 228142 },	-- Earth and Fire
				{ 9, 228160 },	-- Faithbringer
				{ 16, 228258 },	-- Deep Earth Spaulders
				{ 17, 228257 },	-- Aged Core Leather Gloves
				{ 18, 228260 },	-- Flameguard Gauntlets
				{ 19, 228256 },	-- Mana Igniting Cord
				{ 20, 228240 },	-- Flamewaker Legplates
				{ 21, 228253 },	-- Sabatons of the Flamewalker
				{ 22, 228254 },	-- Magma Tempered Boots
				{ 23, 228261 },	-- Quick Strike Ring
				{ 24, 228255 },	-- Talisman of Ephemeral Power
				{ 25, 228259 },	-- Fire Runed Grimoire
				{ 26, 228266 },	-- Drillborer Disk
				{ 27, 228267 },	-- Gutgore Ripper
				{ 28, 228264 },	-- Aurastone Hammer
				{ 29, 228265 },	-- Brutality Blade
				{ 30, 228229 },	-- Obsidian Edged Blade
			},
			[NORMAL_DIFF] = {
				{ 1, 18564 },	-- Bindings of the Windseeker
				{ 3,  16813 },	-- Circlet of Prophecy
				{ 4,  16795 },	-- Arcanist Crown
				{ 5,  16808 },	-- Felheart Horns
				{ 6,  16821 },	-- Nightslayer Cover
				{ 7,  16834 },	-- Cenarion Helm
				{ 8,  16846 },	-- Giantstalker's Helmet
				{ 9,  16842 },	-- Earthfury Helmet
				{ 10,  16854 },	-- Lawbringer Helm
				{ 11,  16866 },	-- Helm of Might
				{ 16, 18829 },	-- Deep Earth Spaulders
				{ 17, 18823 },	-- Aged Core Leather Gloves
				{ 18, 19143 },	-- Flameguard Gauntlets
				{ 19, 19136 },	-- Mana Igniting Cord
				{ 20, 18861 },	-- Flamewaker Legplates
				{ 21, 19144 },	-- Sabatons of the Flamewalker
				{ 22, 18824 },	-- Magma Tempered Boots
				{ 23, 18821 },	-- Quick Strike Ring
				{ 24, 18820 },	-- Talisman of Ephemeral Power
				{ 25, 19142 },	-- Fire Runed Grimoire
				{ 26, 17066 },	-- Drillborer Disk
				{ 27, 17071 },	-- Gutgore Ripper
				{ 28, 17105 },	-- Aurastone Hammer
				{ 29, 18832 },	-- Brutality Blade
				{ 30, 18822 },	-- Obsidian Edged Blade
			},
		},
		{	--MCShazzrah
			name = AL["Shazzrah"],
			npcID = 12264,
			Level = 999,
			DisplayIDs = {{13032}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1, 227531 },	-- Incandescent Bindings
				{ 2, 227760 },	-- Scorched Core Bindings
				{ 3, 227750 },	-- Molten Scaled Bindings
				{ 5, "INV_Box_01", nil, AL["Heat 3 Only"], nil },
				{ 6, 228286 }, -- Band of Accuria
				{ 16, 228285},	-- Helm of the Lifegiver
				{ 17, 228239 },	-- Robe of Volatile Power
				{ 18, 228246 },	-- Wristguards of Stability
				{ 19, 228244 },	-- Manastorm Leggings
				{ 20, 228245 },	-- Salamander Scale Pants
				{ 21, 228240 },	-- Flamewaker Legplates
				{ 22, 228242 },	-- Heavy Dark Iron Ring
				{ 23, 228243 },	-- Ring of Spell Power
				{ 24, 228262 },	-- Crimson Shocker
				{ 25, 228263 },	-- Sorcerous Dagger
				{ 26, 228127 },	-- Wristguards of Instability
				{ 27, 228253 },	-- Sabatons of the Flamewalker
			},
			[NORMAL_DIFF] = {
				{ 1,  16811 },	-- Boots of Prophecy
				{ 2,  16801 },	-- Arcanist Gloves
				{ 3,  16803 },	-- Felheart Slippers
				{ 4,  16824 },	-- Nightslayer Boots
				{ 5,  16831 },	-- Cenarion Gloves
				{ 6,  16852 },	-- Giantstalker's Gloves
				{ 16, 18870 },	-- Helm of the Lifegiver
				{ 17, 19145 },	-- Robe of Volatile Power
				{ 18, 19146 },	-- Wristguards of Stability
				{ 19, 18872 },	-- Manastorm Leggings
				{ 20, 18875 },	-- Salamander Scale Pants
				{ 21, 18861 },	-- Flamewaker Legplates
				{ 22, 18879 },	-- Heavy Dark Iron Ring
				{ 23, 19147 },	-- Ring of Spell Power
				{ 24, 17077 },	-- Crimson Shocker
				{ 25, 18878 },	-- Sorcerous Dagger
			},
		},
		{	--MCGeddon
			name = AL["Baron Geddon"],
			npcID = 12056,
			Level = 999,
			DisplayIDs = {{12129}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  18563 },	-- Bindings of the Windseeker
				{ 3, 227530 },	-- Incandescent Belt
				{ 4, 227761 },	-- Scorched Core Belt
				{ 5, 227751 },	-- Molten Scaled Belt
				{ 16, 228258 },	-- Deep Earth Spaulders
				{ 17, 228257 },	-- Aged Core Leather Gloves
				{ 18, 228260 },	-- Flameguard Gauntlets
				{ 19, 228256 },	-- Mana Igniting Cord
				{ 20, 228240 },	-- Flamewaker Legplates
				{ 21, 228253 },	-- Sabatons of the Flamewalker
				{ 22, 228254 },	-- Magma Tempered Boots
				{ 23, 228261 },	-- Quick Strike Ring
				{ 24, 228268 },	-- Seal of the Archmagus
				{ 25, 228255 },	-- Talisman of Ephemeral Power
				{ 26, 228259 },	-- Fire Runed Grimoire
				{ 27, 228229 },	-- Obsidian Edged Blade
				{ 28, 228139 },	-- Fist of the Firesworn
				{ 29, 228142 },	-- Earth and Fire
				{ 30, 228160 },	-- Faithbringer
			},
			[NORMAL_DIFF] = {
				{ 1,  18563 },	-- Bindings of the Windseeker
				{ 3,  16797 },	-- Arcanist Mantle
				{ 4,  16807 },	-- Felheart Shoulder Pads
				{ 5,  16836 },	-- Cenarion Spaulders
				{ 6,  16844 },	-- Earthfury Epaulets
				{ 7,  16856 },	-- Lawbringer Spaulders
				{ 16, 18829 },	-- Deep Earth Spaulders
				{ 17, 18823 },	-- Aged Core Leather Gloves
				{ 18, 19143 },	-- Flameguard Gauntlets
				{ 19, 19136 },	-- Mana Igniting Cord
				{ 20, 18861 },	-- Flamewaker Legplates
				{ 21, 19144 },	-- Sabatons of the Flamewalker
				{ 22, 18824 },	-- Magma Tempered Boots
				{ 23, 18821 },	-- Quick Strike Ring
				{ 24, 17110 },	-- Seal of the Archmagus
				{ 25, 18820 },	-- Talisman of Ephemeral Power
				{ 26, 19142 },	-- Fire Runed Grimoire
				{ 27, 18822 },	-- Obsidian Edged Blade
			},
		},
		{	--MCGolemagg
			name = AL["Golemagg the Incinerator"],
			npcID = 11988,
			Level = 999,
			DisplayIDs = {{11986}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 17203 },	-- Sulfuron Ingot
				{ 2, 228137 },	-- Heart of Golemagg
				{ 3, 228147 },	-- Magmadar's Horn
				{ 4, 228258 },	-- Deep Earth Spaulders
				{ 5, 228257 },	-- Aged Core Leather Gloves
				{ 6, 228260 },	-- Flameguard Gauntlets
				{ 7, 228256 },	-- Mana Igniting Cord
				{ 8, 228240 },	-- Flamewaker Legplates
				{ 9, 228253 },	-- Sabatons of the Flamewalker
				{ 10, 228254 },	-- Magma Tempered Boots
				{ 11, 228261 },	-- Quick Strike Ring
				{ 12, 228255 },	-- Talisman of Ephemeral Power
				{ 13, 228259 },	-- Fire Runed Grimoire
				{ 14, 228270 },	-- Blastershot Launcher
				{ 15, 228269 },	-- Azuresong Mageblade
				{ 16, 228229 },	-- Obsidian Edged Blade
				{ 17, 228271 },	-- Staff of Dominance
				{ 19, "INV_Box_01", nil, AL["Heat 3 Only"], nil },
				{ 20, 228290 },	-- Cloak of the Shrouded Mists
				{ 21, 228289 },	-- Choken of the Fire Lord
				{ 23, 227535 },	-- Incandescent Robe
				{ 24, 227766 },	-- Scorched Core Chest
				{ 25, 227758 },	-- Molten Scaled Chest
				{ 27, 227537 }, -- 
				{ 28, 227752 }, -- 
				{ 29, 227762 }, -- 
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 227533 }, -- 
				{ 102, 227756 }, -- 
				{ 103, 227759 }, -- 
				{ 105, 227531 }, -- 
				{ 106, 227750 }, -- 
				{ 107, 227760 }, -- 
				{ 109, 227530 }, -- 
				{ 110, 227751 }, -- 
				{ 111, 227761 }, -- 
				{ 116, 227534 }, -- 
				{ 117, 227754 }, -- 
				{ 118, 227763 }, -- 
				{ 120, 227536 }, -- 
				{ 121, 227757 }, -- 
				{ 122, 227765 }, -- 
				{ 124, 227532 }, -- Incandescent Hood
				{ 125, 227764 }, -- Scorched Core Helm
				{ 126, 227755 }, -- Molten Scaled Helm
			},
			[NORMAL_DIFF] = {
				{ 1,  16815 },	-- Robes of Prophecy
				{ 2,  16798 },	-- Arcanist Robes
				{ 3,  16809 },	-- Felheart Robes
				{ 4,  16820 },	-- Nightslayer Chestpiece
				{ 5,  16833 },	-- Cenarion Vestments
				{ 6,  16845 },	-- Giantstalker's Breastplate
				{ 7,  16841 },	-- Earthfury Vestments
				{ 8,  16853 },	-- Lawbringer Chestguard
				{ 9,  16865 },	-- Breastplate of Might
				{ 11, 17203 },	-- Sulfuron Ingot
				{ 16, 18829 },	-- Deep Earth Spaulders
				{ 17, 18823 },	-- Aged Core Leather Gloves
				{ 18, 19143 },	-- Flameguard Gauntlets
				{ 19, 19136 },	-- Mana Igniting Cord
				{ 20, 18861 },	-- Flamewaker Legplates
				{ 21, 19144 },	-- Sabatons of the Flamewalker
				{ 22, 18824 },	-- Magma Tempered Boots
				{ 23, 18821 },	-- Quick Strike Ring
				{ 24, 18820 },	-- Talisman of Ephemeral Power
				{ 25, 19142 },	-- Fire Runed Grimoire
				{ 26, 17072 },	-- Blastershot Launcher
				{ 27, 17103 },	-- Azuresong Mageblade
				{ 28, 18822 },	-- Obsidian Edged Blade
				{ 29, 18842 },	-- Staff of Dominance
			},
		},
		{ -- MCSulfuron
			name = AL["Sulfuron Harbinger"],
			npcID = 12098,
			Level = 999,
			DisplayIDs = {{13030},{12030}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1, 17203 },	-- Sulfuron Ingot
				{ 3, 18870 }, -- Helm of the Lifegiver
				{ 4, 228239 }, -- Robe of Volatile Power
				{ 5, 228246 }, -- Wristguards of Stability
				{ 6, 228244 }, -- Manastorm Leggings
				{ 7, 228245 }, -- Salamander Scale Pants
				{ 8, 228240 }, -- Flamewaker Legplates
				{ 9, 228242 }, -- Heavy Dark Iron Ring
				{ 10, 228243 }, -- Ring of Spell Power
				{ 11, 228262 }, -- Crimson Shocker
				{ 12, 228263 }, -- Sorcerous Dagger
				{ 13, 228272 }, -- Shadowstrike
				{ 14, 228127 },	-- Wristguards of Instability
				{ 15, 228128 }, -- Hammer of the Black Anvil
				{ 16, 228260 }, -- Flameguard Gauntlets
				{ 17, 228292 }, -- Dragon's Blood Cape
				{ 19, "INV_Box_01", nil, AL["Heat 2+"], nil },
				{ 20, 228295 }, -- Onslaught Girdle
				{ 22, 227535 },	-- Incandescent Robe
				{ 23, 227766 },	-- Scorched Core Chest
				{ 24, 227758 },	-- Molten Scaled Chest
				{ 26, 227537 }, -- 
				{ 27, 227752 }, -- 
				{ 28, 227762 }, -- 
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 227533 }, -- 
				{ 102, 227756 }, -- 
				{ 103, 227759 }, -- 
				{ 105, 227531 }, -- 
				{ 106, 227750 }, -- 
				{ 107, 227760 }, -- 
				{ 109, 227530 }, -- 
				{ 110, 227751 }, -- 
				{ 111, 227761 }, -- 
				{ 116, 227534 }, -- 
				{ 117, 227754 }, -- 
				{ 118, 227763 }, -- 
				{ 120, 227536 }, -- 
				{ 121, 227757 }, -- 
				{ 122, 227765 }, -- 
				{ 124, 227532 }, -- Incandescent Hood
				{ 125, 227764 }, -- Scorched Core Helm
				{ 126, 227755 }, -- Molten Scaled Helm
			},
			[NORMAL_DIFF] = {
				{ 1,  16816 }, -- Mantle of Prophecy
				{ 2,  16823 }, -- Nightslayer Shoulder Pads
				{ 3,  16848 }, -- Giantstalker's Epaulets
				{ 4,  16868 }, -- Pauldrons of Might
				{ 16, 18870 }, -- Helm of the Lifegiver
				{ 17, 19145 }, -- Robe of Volatile Power
				{ 18, 19146 }, -- Wristguards of Stability
				{ 19, 18872 }, -- Manastorm Leggings
				{ 20, 18875 }, -- Salamander Scale Pants
				{ 21, 18861 }, -- Flamewaker Legplates
				{ 22, 18879 }, -- Heavy Dark Iron Ring
				{ 23, 19147 }, -- Ring of Spell Power
				{ 24, 17077 }, -- Crimson Shocker
				{ 25, 18878 }, -- Sorcerous Dagger
				{ 26, 17074 }, -- Shadowstrike
			},
		},
		{ -- MCMajordomo
			name = AL["Majordomo Executus"],
			npcID = 12018,
			Level = 999,
			ObjectID = 179703,
			DisplayIDs = {{12029},{13029},{12002}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1,  17203 }, -- Sulfuron Ingot
				{ 2,  228279 }, -- Fireguard Shoulders
				{ 3,  228283 }, -- Wild Growth Spaulders
				{ 4,  228280 }, -- Fireproof Cloak
				{ 5,  228281 }, -- Gloves of the Hypnotic Flame
				{ 6,  228282 }, -- Sash of Whispered Secrets
				{ 7,  228284 }, -- Wristguards of True Flight
				{ 8,  228275 }, -- Core Forged Greaves
				{ 9,  228274 }, -- Cauterizing Band
				{ 10, 228102 }, -- Majordomo's Drape
				{ 11, 228277 }, -- Core Hound Tooth
				{ 12, 228278 }, -- Hyperthermically Insulated Lava Dredger
				{ 16, 18703 }, -- Ancient Petrified Leaf
				{ 17, 18646 }, -- The Eye of Divinity
				{ 18, 228129 }, -- Shadowflame Skull
				{ 20, "INV_Box_01", nil, AL["Heat 3 Only"], nil },
				{ 21, 228461 }, -- Bonereaver's Edge
				{ 22, 228296 }, -- Perdition's Blade (Gutgore Ripper)
				{ 23, 227535 },	-- Incandescent Robe
				{ 24, 227766 },	-- Scorched Core Chest
				{ 25, 227758 },	-- Molten Scaled Chest
				{ 27, 227537 }, -- 
				{ 28, 227752 }, -- 
				{ 29, 227762 }, -- 
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 227533 }, -- 
				{ 102, 227756 }, -- 
				{ 103, 227759 }, -- 
				{ 105, 227531 }, -- 
				{ 106, 227750 }, -- 
				{ 107, 227760 }, -- 
				{ 109, 227530 }, -- 
				{ 110, 227751 }, -- 
				{ 111, 227761 }, -- 
				{ 116, 227534 }, -- 
				{ 117, 227754 }, -- 
				{ 118, 227763 }, -- 
				{ 120, 227536 }, -- 
				{ 121, 227757 }, -- 
				{ 122, 227765 }, -- 
				{ 124, 227532 }, -- Incandescent Hood
				{ 125, 227764 }, -- Scorched Core Helm
				{ 126, 227755 }, -- Molten Scaled Helm
			},
			[NORMAL_DIFF] = {
				{ 1,  19139 }, -- Fireguard Shoulders
				{ 2,  18810 }, -- Wild Growth Spaulders
				{ 3,  18811 }, -- Fireproof Cloak
				{ 4,  18808 }, -- Gloves of the Hypnotic Flame
				{ 5,  18809 }, -- Sash of Whispered Secrets
				{ 6,  18812 }, -- Wristguards of True Flight
				{ 7,  18806 }, -- Core Forged Greaves
				{ 8,  19140 }, -- Cauterizing Band
				{ 9,  18805 }, -- Core Hound Tooth
				{ 10, 18803 }, -- Finkle's Lava Dredger
				{ 16, 18703 }, -- Ancient Petrified Leaf
				{ 18, 18646 }, -- The Eye of Divinity
			},
		},
		{ -- MCRagnaros
			name = AL["Ragnaros"],
			npcID = 11502,
			Level = 999,
			DisplayIDs = {{11121}},
			AtlasMapBossID = 10,
			[SOD_DIFF] = {
				{ 1, 227728 }, -- Eye of Sulfuras
				{ 2, 19017 }, -- Essence of the Firelord
				{ 3, 17203 }, -- Sulfuron Ingot
				{ 5, 228289 }, -- Choker of the Firelord
				{ 6, 228297 }, -- Shard of the Flame
				{ 7, 228291 }, -- Crown of Destruction
				{ 8, 228290 }, -- Cloak of the Shrouded Mists
				{ 9, 228292 }, -- Dragon's Blood Cape
				{ 10, 228295 }, -- Onslaught Girdle
				{ 11, 228286 }, -- Band of Accuria
				{ 12, 228287 }, -- Band of Sulfuras
				{ 13, 228266 }, -- Essence of the Pure Flame (Drillborer Disk)
				{ 14, 228294 }, -- Malistar's Defender
				{ 15, 228293 }, -- Essence of the Pure Flame
				{ 16, 228296 }, -- Perdition's Blade (Gutgore Ripper)
				{ 17, 228299 }, -- Spinal Reaper
				{ 18, 228288 }, -- Bonereaver's Edge
				{ 20, 227535 },	-- Incandescent Robe
				{ 21, 227766 },	-- Scorched Core Chest
				{ 22, 227758 },	-- Molten Scaled Chest
				{ 24, 227537 }, -- 
				{ 25, 227752 }, -- 
				{ 26, 227762 }, -- 
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 227533 }, -- 
				{ 102, 227756 }, -- 
				{ 103, 227759 }, -- 
				{ 105, 227531 }, -- 
				{ 106, 227750 }, -- 
				{ 107, 227760 }, -- 
				{ 109, 227530 }, -- 
				{ 110, 227751 }, -- 
				{ 111, 227761 }, -- 
				{ 116, 227534 }, -- 
				{ 117, 227754 }, -- 
				{ 118, 227763 }, -- 
				{ 120, 227536 }, -- 
				{ 121, 227757 }, -- 
				{ 122, 227765 }, -- 
				{ 124, 227532 }, -- Incandescent Hood
				{ 125, 227764 }, -- Scorched Core Helm
				{ 126, 227755 }, -- Molten Scaled Helm
			},
			[NORMAL_DIFF] = {
				{ 1, 17204 }, -- Eye of Sulfuras
				{ 2, 19017 }, -- Essence of the Firelord
				{ 4,  16922 }, -- Leggings of Transcendence
				{ 5,  16915 }, -- Netherwind Pants
				{ 6,  16930 }, -- Nemesis Leggings
				{ 7,  16909 }, -- Bloodfang Pants
				{ 8,  16901 }, -- Stormrage Legguards
				{ 9,  16938 }, -- Dragonstalker's Legguards
				{ 10,  16946 }, -- Legplates of Ten Storms
				{ 11,  16954 }, -- Judgement Legplates
				{ 12,  16962 }, -- Legplates of Wrath
				{ 14, 17082 }, -- Shard of the Flame
				{ 16, 18817 }, -- Crown of Destruction
				{ 17, 18814 }, -- Choker of the Fire Lord
				{ 18, 17102 }, -- Cloak of the Shrouded Mists
				{ 19, 17107 }, -- Dragon's Blood Cape
				{ 20, 19137 }, -- Onslaught Girdle
				{ 21, 17063 }, -- Band of Accuria
				{ 22, 19138 }, -- Band of Sulfuras
				{ 23, 18815 }, -- Essence of the Pure Flame
				{ 24, 17106 }, -- Malistar's Defender
				{ 25, 18816 }, -- Perdition's Blade
				{ 26, 17104 }, -- Spinal Reaper
				{ 27, 17076 }, -- Bonereaver's Edge
			},
		},
		{ -- MCTheMoltenCore
			name = AL["The Molten Core"],
			npcID = 227959,
			Level = 999,
			[SOD_DIFF] = {
				{ 1, 227728 }, -- Eye of Sulfuras
				{ 2, 18563 }, -- Bindings of the Windseeker
				{ 3, 18564 }, -- Bindings of the Windseeker
				{ 5, "INV_Box_01", nil, AL["Drops 1 rare MC item"], nil },
				{ 6, "INV_Box_01", nil, AL["This list may be incomplete"], nil },
				{ 7, 228286 }, -- Band of Accuria
				{ 8, 228287 }, -- Band of Sulfuras
				{ 9, 228296 }, -- Perdition's Blade 
				{ 10, 228288 }, -- Bonereaver's Edge
				{ 11, 228299 }, -- Spinal Reaper
				{ 16, 227535 },	-- Incandescent Robe
				{ 17, 227766 },	-- Scorched Core Chest
				{ 18, 227758 },	-- Molten Scaled Chest
				{ 20, 227537 }, -- Incandescent Shoulderpads
				{ 21, 227752 }, -- Molten Scaled Shoulderpads
				{ 22, 227762 }, -- Scorched Core Shoulderpads
				{ 24, 227532 }, -- Incandescent Hood
				{ 25, 227764 }, -- Scorched Core Helm
				{ 26, 227755 }, -- Molten Scaled Helm
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 227533 }, -- Incandescent Gloves
				{ 102, 227756 }, -- Molten Scaled Gloves
				{ 103, 227759 }, -- Scorched Core Gloves
				{ 105, 227531 }, -- Incandescent Bindings
				{ 106, 227750 }, -- Molten Scaled Bindings
				{ 107, 227760 }, -- Scorched Core Bindings
				{ 109, 227530 }, -- Incandescent Belt
				{ 110, 227751 }, -- Molten Sccaled Belt
				{ 111, 227761 }, -- Scorched Core Belt
				{ 116, 227534 }, -- Incandescent Leggings
				{ 117, 227754 }, -- Molten Scaled Leggings
				{ 118, 227763 }, -- Scorched Core Leggings
				{ 120, 227536 }, -- Inncandescent Boots
				{ 121, 227757 }, -- Molten Scaled Boots
				{ 122, 227765 }, -- Scorched Core Boots
			},
		},
		{ -- MCTrashMobs
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 17011 }, -- Lava Core
				{ 2, 17010 }, -- Fiery Core
				{ 3, 11382 }, -- Blood of the Mountain
				{ 4, 17012 }, -- Core Leather
			},
			[NORMAL_DIFF] = {
				{ 1,  16817 }, -- Girdle of Prophecy
				{ 2,  16802 }, -- Arcanist Belt
				{ 3,  16806 }, -- Felheart Belt
				{ 4,  16827 }, -- Nightslayer Belt
				{ 5,  16828 }, -- Cenarion Belt
				{ 6,  16851 }, -- Giantstalker's Belt
				{ 7,  16838 }, -- Earthfury Belt
				{ 8,  16858 }, -- Lawbringer Belt
				{ 9,  16864 }, -- Belt of Might
				{ 12, 17011 }, -- Lava Core
				{ 13, 17010 }, -- Fiery Core
				{ 14, 11382 }, -- Blood of the Mountain
				{ 15, 17012 }, -- Core Leather
				{ 16, 16819 }, -- Vambraces of Prophecy
				{ 17, 16799 }, -- Arcanist Bindings
				{ 18, 16804 }, -- Felheart Bracers
				{ 19, 16825 }, -- Nightslayer Bracelets
				{ 20, 16830 }, -- Cenarion Bracers
				{ 21, 16850 }, -- Giantstalker's Bracers
				{ 22, 16840 }, -- Earthfury Bracers
				{ 23, 16857 }, -- Lawbringer Bracers
				{ 24, 16861 }, -- Bracers of Might
			},
		},
		{ -- MCRANDOMBOSSDROPS
			name = AL["All bosses"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  18264 }, -- Plans: Elemental Sharpening Stone
				{ 3,  18292 }, -- Schematic: Core Marksman Rifle
				{ 4,  18291 }, -- Schematic: Force Reactive Disk
				{ 5, 18290 }, -- Schematic: Biznicks 247x128 Accurascope
				{ 7, 18259 }, -- Formula: Enchant Weapon - Spell Power
				{ 8, 18260 }, -- Formula: Enchant Weapon - Healing Power
				{ 16, 18252 }, -- Pattern: Core Armor Kit
				{ 18, 18265 }, -- Pattern: Flarecore Wraps
				{ 19, 21371 }, -- Pattern: Core Felcloth Bag
				{ 21, 18257 }, -- Recipe: Major Rejuvenation Potion
			},
			[NORMAL_DIFF] = {
				{ 1,  18264 }, -- Plans: Elemental Sharpening Stone
				{ 3,  18292 }, -- Schematic: Core Marksman Rifle
				{ 4,  18291 }, -- Schematic: Force Reactive Disk
				{ 5, 18290 }, -- Schematic: Biznicks 247x128 Accurascope
				{ 7, 18259 }, -- Formula: Enchant Weapon - Spell Power
				{ 8, 18260 }, -- Formula: Enchant Weapon - Healing Power
				{ 16, 18252 }, -- Pattern: Core Armor Kit
				{ 18, 18265 }, -- Pattern: Flarecore Wraps
				{ 19, 21371 }, -- Pattern: Core Felcloth Bag
				{ 21, 18257 }, -- Recipe: Major Rejuvenation Potion
			},
		},
		SoD_T1_SET
	},
}

data["Onyxia2"] = {
	MapID = 2159,
	InstanceID = 249,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Onyxia",
	AtlasMapFile = "CL_OnyxiasLair",
	AtlasMapFile_AL = "OnyxiasLair",
	ContentType = RAID_CONTENT,
	LevelRange = GetForVersion({60, 60, 60},{60, 60, 60}),
	items = {
		{ -- Onyxia
			name = AL["Onyxia"],
			npcID = 10184,
			Level = 999,
			DisplayIDs = {{8570}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 18423 }, -- Head of Onyxia
				{ 2, 18705 }, -- Mature Black Dragon Sinew
				{ 3, 228759 }, -- Eskhandar's Collar
				{ 4, 17078 }, -- Sapphiron Drape
				{ 5, 18813 }, -- Ring of Binding
				{ 6, 228298 }, -- Shard of the Scale
				{ 7, 228955 }, -- Ancient Cornerstone Grimoire
				{ 8, 17068 }, -- Deathbringer
				{ 9, 17075 }, -- Vis'kag the Bloodletter
				{ 10, 228166 }, -- Key to the City
				{ 11, 228162 }, -- Deceit
				{ 12, 228165 }, -- Dragonslayer's Javelin
				{ 13, 228163 }, -- Broodmother's Brooch
				{ 14, 228188 }, -- Prestor's Hairpin
				{ 15, 228992 }, -- Onyxia Hide Backpack
				{ 16, 15410 }, -- Scale of Onyxia
				{ 17, 11938 }, -- Sack of Gems
				{ 19, 227532 }, -- These are just tier tokens below..
				{ 20, 227755 }, -- 
				{ 21, 227764 }, -- 
				{ 23, 227537 }, -- 
				{ 24, 227752 }, -- 
				{ 25, 227762 }, -- 
				{ 27, 227535 }, -- 
				{ 28, 227758 }, -- 
				{ 29, 227766 }, -- 
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 227533 }, -- 
				{ 102, 227756 }, -- 
				{ 103, 227759 }, -- 
				{ 105, 227531 }, -- 
				{ 106, 227750 }, -- 
				{ 107, 227760 }, -- 
				{ 109, 227530 }, -- 
				{ 110, 227751 }, -- 
				{ 111, 227761 }, -- 
				{ 116, 227534 }, -- 
				{ 117, 227754 }, -- 
				{ 118, 227763 }, -- 
				{ 120, 227536 }, -- 
				{ 121, 227757 }, -- 
				{ 122, 227765 }, -- 
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
			[NORMAL_DIFF] = {
				{ 1,  16921 }, -- Halo of Transcendence
				{ 2,  16914 }, -- Netherwind Crown
				{ 3,  16929 }, -- Nemesis Skullcap
				{ 4,  16908 }, -- Bloodfang Hood
				{ 5,  16900 }, -- Stormrage Cover
				{ 6,  16939 }, -- Dragonstalker's Helm
				{ 7,  16947 }, -- Helmet of Ten Storms
				{ 8,  16955 }, -- Judgement Crown
				{ 9,  16963 }, -- Helm of Wrath
				{ 11, 18423 }, -- Head of Onyxia
				{ 12, 15410 }, -- Scale of Onyxia
				{ 16, 18705 }, -- Mature Black Dragon Sinew
				{ 18, 18205 }, -- Eskhandar's Collar
				{ 19, 17078 }, -- Sapphiron Drape
				{ 20, 18813 }, -- Ring of Binding
				{ 21, 17064 }, -- Shard of the Scale
				{ 22, 17067 }, -- Ancient Cornerstone Grimoire
				{ 23, 17068 }, -- Deathbringer
				{ 24, 17075 }, -- Vis'kag the Bloodletter
				{ 26, 17966 }, -- Onyxia Hide Backpack
				{ 27, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
	},
}

data["DemonFallCanyon"] = {
	MapID = 15475,
	InstanceID = 15540,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {60, 60, 60},
	items = {
		{ -- DFCGrimroot
			name = AL["Grimroot"],
			[SOD_DIFF] = {
				{ 1, 228080}, -- Resin Loop
				{ 2, 228081}, -- Germinating Poisonseed
				{ 3, 228079}, -- Cloak of Leaves
				{ 4, 228082}, -- Warsong Axe
				{ 5, 228083}, -- Gloaming Treeheart
			},
		},
		{ -- DFCDiathorus
			name = AL["Diathorus The Seeker"],
			[SOD_DIFF] = {
				{ 1, 228106}, -- Shield of Life and Death
				{ 2, 228107}, -- Fallen Huntress' Longbow
				{ 3, 228094}, -- Dreadlord's Blade
				{ 4, 228104}, -- Robes of Elune
				{ 5, 228103}, -- Nathrezim's Greaves
			},
		},
		{ -- DFCDestructor
			name = AL["Destructor's Wraith"],
			[SOD_DIFF] = {
				{ 1, 228074}, -- Hands of Temptation
				{ 2, 228075}, -- Spear of Destiny
				{ 3, 228077}, -- Dreambough
				{ 4, 228078}, -- Accursed Chalice
				{ 5, 228076}, -- Burning Ring of Fire
			},
		},
		{ -- DFCZilbagob
			name = AL["Zilbagob"],
			[SOD_DIFF] = {
				{ 1, 228086}, -- Repurposed Shredderblade
				{ 2, 228088}, -- Shredder Operator's Dogtags
				{ 3, 228087}, -- Supercharged Silver Moebius
				{ 4, 228084}, -- Miniaturized Fire Extinguisher
				{ 5, 228085}, -- Phaseshifted Legion Band
			},
		},
		{ -- DFCPyranis
			name = AL["Pyranis"],
			[SOD_DIFF] = {
				{ 1, 228091}, -- Thorned Boots
				{ 2, 228093}, -- Dark Heart of Darkness
				{ 3, 228090}, -- Cenarion Ritual Dagger
				{ 4, 228092}, -- Druidic Mantle
				{ 5, 228089}, -- Woodcarved Moonstalker
			},
		},
		{ -- DFCHellscream
			name = AL["Hellscream's Phantom"],
			[SOD_DIFF] = {
				{ 1, 228112}, -- Nightmare Gown
				{ 2, 228113}, -- Cold Embrace
				{ 3, 228111}, -- Mask of the Godslayer
				{ 4, 228109}, -- Legguards of Sacrifice
				{ 5, 228108}, -- Shadow of Gorehowl
				{ 7, 228410}, -- Dreadblade of the Destructor
			},
		},
		{ -- DFCHellscream
			name = AL["Azgaloth"],
			[SOD_DIFF] = {
				{ 1, 231911}, -- Signet of the Legion General
				{ 2, 231910}, -- Heart of Azgaloth
				{ 3, 231913}, -- Eye of the Observer
				{ 4, 231460}, -- Planebreaker of Azgaloth
				{ 5, 231912}, -- Blade of the Pit
			},
		},
	},
}

data["Karazhan Crypts"] = {
    MapID = 16074,
    InstanceID = 16074,
    ContentType = DUNGEON_CONTENT,
    LevelRange = {60, 60, 60},
    items = {


		{ -- The Failed Apprentices
            name = AL["The Failed Apprentices"],
            [SOD_DIFF] = {
                { 1, "INV_Box_01", nil, AL["The Warden"], nil },
				{ 2, "INV_Chest_Chain_08", nil, AL["Random chest from invasions"], nil },
				{ 3, 237011 }, -- Key
				{ 5, "INV_Box_01", nil, AL["Barian Maryla"], nil },
				{ 6, 235887 }, -- Barian's Choker
				{ 7, 235880 }, -- Pauper Soles
				{ 8, 235894 }, -- Doomsayer's Demise
				{ 9, 235873 }, -- Crypt's Keepers
				{ 10, 235879 }, -- Nimble Links
				{ 16, "INV_Box_01", nil, AL["Kaigy Marylaa"], nil },
				{ 17, 235886 }, -- Kaigy's Clasp
				{ 18, 235880 }, -- Pauper Soles
				{ 19, 235894 }, -- Doomsayer's Demise
				{ 20, 235873 }, -- Crypt's Keepers
				{ 21, 235879 }, -- Nimble Links
				{ 23, "INV_Box_01", nil, AL["Sairuh Marylaa"], nil },
				{ 24, 236782 }, -- Sairuh's Collar
				{ 25, 235880 }, -- Pauper Soles
				{ 26, 235894 }, -- Doomsayer's Demise
				{ 27, 235873 }, -- Crypt's Keepers
				{ 28, 235879 }, -- Nimble Links
            },
        },

        { -- Harbinger of Sin
            name = AL["Harbinger of Sin"],
            [SOD_DIFF] = {
                { 1, 235891 }, -- Ol' Reliable
                { 2, 235890 }, -- Shadow Weaver's Needle
                { 3, 235869 }, -- The Master's Cowl
                { 4, 235882 }, -- Clattering Steps
            },
        },
        { -- Opera Cache
            name = AL["Opera Cache"],
            [SOD_DIFF] = {
                { 1, 235889 }, -- Servant's Quarterstaff
                { 2, 235883 }, -- Well Diver's Stumble
				{ 3, 235878 }, -- Malefic Belt
				{ 4, 235893 }, -- Shadowbound Grimoire
            },
        },
        { -- Creeping Malison Spider
            name = AL["Creeping Malison"],
            [SOD_DIFF] = {
                { 1, 235888 }, -- Clobberclub
                { 2, 235885 }, -- Ghastly Ring
                { 3, 235884 }, -- Spectral Signet
				{ 4, 235881 }, -- Dreaded Treaders
            },
        },

		{ -- Kharon (Also all the other loot)
		name = AL["Kharon (Also all the other loot)"],
		[SOD_DIFF] = {
				{ 1, 235875 }, -- Gravedigger's Gloves
				{ 2, 235874 }, -- Cultist's Handwraps
				{ 3, 235877 }, -- Fanatic's Gauntlets
				{ 4, 236645 }, -- Lightwielder's Gauntlets
				{ 5, 235876 }, -- Sinner's Handguards
				{ 6, 236642 }, -- Mender's Handwraps
				{ 7, 236643 }, -- Nightwatcher's Gloves
				{ 8, 235002 }, -- Mourner's Handguards (placeholder)
				{ 9, 235878 }, -- Malefic Belt
				{ 10, 235879 }, -- Nimble Links
				{ 11, 235872 }, -- Stalker's Bands
				{ 12, 235871 }, -- Clutching Death Helm
				{ 13, 235873 }, -- Crypt's Keepers
				{ 14, 235881 }, -- Dreaded Treaders
				{ 15, 235880 }, -- Pauper Soles
				{ 16, 235870 }, -- Rattlechain Helm
				{ 17, 235893 }, -- Shadowbound Grimoire
				{ 18, 235869 }, -- The Master's Cowl
				{ 19, 235883 }, -- Well Diver's Stumble
				{ 20, 235887 }, -- Barian's Choker
				{ 21, 235882 }, -- Clattering Steps
				{ 22, 235885 }, -- Ghastly Ring
				{ 23, 235868 }, -- Bulwark of Ire
				{ 24, 235892 }, -- Darkrider's Spine
				{ 25, 235886 }, -- Kaigy's Clasp
				{ 26, 235891 }, -- Ol' Reliable
				{ 27, 235888 }, -- Clobberclub
				{ 28, 235894 }, -- Doomsayer's Demise
				{ 29, 235889 }, -- Servant's Quarterstaff
				{ 30, 235890 }, -- Shadow Weaver's Needle
				{ 31, 235884 }, -- Spectral Signet
				{ 32, 236782 }, -- Sairuh's Collar
			},
		},
	
		        { -- Dark Rider
            name = AL["Dark Rider"],
            [SOD_DIFF] = {
                { 1, 235892 }, -- Darkrider's Spine
                { 2, 235868 }, -- Bulwark of Ire
                { 3, 235871 }, -- Clutching Death Helm
				{ 4, 235872 }, -- Stalker's Bands
            },
        },

    },
}


data["Zul'Gurub"] = {
	MapID = 1977,
	InstanceID = 309,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Zul'Gurub", -- ??
	AtlasMapFile = "CL_ZulGurub",
	AtlasMapFile_AL = "ZulGurub",
	ContentType = RAID_CONTENT,
	LevelRange = GetForVersion({60, 60, 60},{60, 60, 60}),
	ContentPhase = 4,
	items = {
		{ -- ZGJeklik
			name = AL["High Priestess Jeklik"],
			npcID = 14517,
			Level = 999,
			DisplayIDs = {{15219}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 15, "INV_Box_01", nil, AL["Loot unconfirmed"], nil },
				{ 16, 230911 }, -- Jeklik's Crusher
				{ 18, 230913 }, -- Jeklik's Opaline Talisman
				{ 19, 230912 }, -- Animist's Spaulders
				{ 20, 230916 }, -- Seafury Boots
				{ 21, 230914 }, -- Peacekeeper Boots
				{ 22, 230915 }, -- Primalist's Band
				{ 23, 232299 }, -- Zulian Defender
			},
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19918 }, -- Jeklik's Crusher
				{ 18, 19923 }, -- Jeklik's Opaline Talisman
				{ 19, 19928 }, -- Animist's Spaulders
				{ 20, 20262 }, -- Seafury Boots
				{ 21, 20265 }, -- Peacekeeper Boots
				{ 22, 19920 }, -- Primalist's Band
				{ 23, 19915 }, -- Zulian Defender
			},
		},
		{ -- ZGVenoxis
			name = AL["High Priest Venoxis"],
			npcID = 14507,
			Level = 999,
			DisplayIDs = {{15217}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 230864 }, -- Runed Bloodstained Hauberk
				{ 17, 230865 }, -- Fang of Venoxis
				{ 19, 232311 }, -- Zulian Tigerhide Cloak
				{ 20, 230866 }, -- Blooddrenched Footpads
				{ 21, 230867 }, -- Zanzil's Band
				{ 22, 230868 }, -- Zulian Stone Axe
			},
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19904 }, -- Runed Bloodstained Hauberk
				{ 17, 19903 }, -- Fang of Venoxis
				{ 19, 19907 }, -- Zulian Tigerhide Cloak
				{ 20, 19906 }, -- Blooddrenched Footpads
				{ 21, 19905 }, -- Zanzil's Band
				{ 22, 19900 }, -- Zulian Stone Axe
			},
		},
		{ -- ZGMarli
			name = AL["High Priestess Mar'li"],
			npcID = 14510,
			Level = 999,
			DisplayIDs = {{15220}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 230917 }, -- Flowing Ritual Robes
				{ 17, 230918 }, -- Mar'li's Touch
				{ 19, 230922 }, -- Talisman of Protection
				{ 20, 230919 }, -- Bloodstained Greaves
				{ 21, 230921 }, -- Band of Jin
				{ 22, 230920 }, -- Mar'li's Eye
			},
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 20032 }, -- Flowing Ritual Robes
				{ 17, 19927 }, -- Mar'li's Touch
				{ 19, 19871 }, -- Talisman of Protection
				{ 20, 19919 }, -- Bloodstained Greaves
				{ 21, 19925 }, -- Band of Jin
				{ 22, 19930 }, -- Mar'li's Eye
			},
		},
		{ -- ZGMandokir
			name = AL["Bloodlord Mandokir"],
			npcID = 11382,
			Level = 999,
			DisplayIDs = {{11288}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19872 }, -- Swift Razzashi Raptor
				{ 17, 230993 }, -- Mandokir's Sting
				{ 18, 230989 }, -- Bloodlord's Defender
				{ 19, 230992 }, -- Warblade of the Hakkari
				{ 20, 230991 }, -- Halberd of Smiting
				{ 22, 230996 }, -- Bloodsoaked Pauldrons
				{ 23, 230998 }, -- Hakkari Loa Cloak
				{ 24, 230995 }, -- Blooddrenched Grips
				{ 25, 230997 }, -- Bloodtinged Kilt
				{ 26, 230994 }, -- Animist's Leggings
				{ 27, 230999 }, -- Overlord's Crimson Band
				{ 28, 231000 }, -- Primalist's Seal
				{ 29, 231001 }, -- Zanzil's Seal
			},
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 19872 }, -- Swift Razzashi Raptor
				{ 17, 20038 }, -- Mandokir's Sting
				{ 18, 19867 }, -- Bloodlord's Defender
				{ 19, 19866 }, -- Warblade of the Hakkari
				{ 20, 19874 }, -- Halberd of Smiting
				{ 22, 19878 }, -- Bloodsoaked Pauldrons
				{ 23, 19870 }, -- Hakkari Loa Cloak
				{ 24, 19869 }, -- Blooddrenched Grips
				{ 25, 19895 }, -- Bloodtinged Kilt
				{ 26, 19877 }, -- Animist's Leggings
				{ 27, 19873 }, -- Overlord's Crimson Band
				{ 28, 19863 }, -- Primalist's Seal
				{ 29, 19893 }, -- Zanzil's Seal
			},
		},
		{ -- ZGGrilek
			name = AL["Gri'lek"],
			npcID = 15082,
			Level = 999,
			DisplayIDs = {{8390}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 231274 }, -- Gri'lek's Grinder
				{ 2, 231273 }, -- Gri'lek's Carver
				{ 4,  19939 }, -- Gri'lek's Blood
			},
			[NORMAL_DIFF] = {
				{ 1,  19961 }, -- Gri'lek's Grinder
				{ 2,  19962 }, -- Gri'lek's Carver
				{ 4,  19939 }, -- Gri'lek's Blood
			},
		},
		{ -- ZGHazzarah
			name = AL["Hazza'rah"],
			npcID = 15083,
			Level = 999,
			DisplayIDs = {{15267}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 231276 }, -- Thoughtblighter
				{ 2, 231275 }, -- Fiery Retributer
				{ 4,  19942 }, -- Hazza'rah's Dream Thread
			},
			[NORMAL_DIFF] = {
				{ 1,  19967 }, -- Thoughtblighter
				{ 2,  19968 }, -- Fiery Retributer
				{ 4,  19942 }, -- Hazza'rah's Dream Thread
			},
		},
		{ -- ZGRenataki
			name = AL["Renataki"],
			npcID = 15084,
			Level = 999,
			DisplayIDs = {{15268}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 232309 }, -- Renataki's Soul Conduit
				{ 2, 231277 }, -- Pitchfork of Madness
				{ 4,  19940 }, -- Renataki's Tooth
			},
			[NORMAL_DIFF] = {
				{ 1,  19964 }, -- Renataki's Soul Conduit
				{ 2,  19963 }, -- Pitchfork of Madness
				{ 4,  19940 }, -- Renataki's Tooth
			},
		},
		{ -- ZGWushoolay
			name = AL["Wushoolay"],
			npcID = 15085,
			Level = 999,
			DisplayIDs = {{15269}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 231278 }, -- Hoodoo Hunting Bow
				{ 2, 231279 }, -- Wushoolay's Poker
				{ 4,  19941 }, -- Wushoolay's Mane
			},
			[NORMAL_DIFF] = {
				{ 1,  19993 }, -- Hoodoo Hunting Bow
				{ 2,  19965 }, -- Wushoolay's Poker
				{ 4,  19941 }, -- Wushoolay's Mane
			},
		},
		{ -- ZGGahzranka
			name = AL["Gahz'ranka"],
			npcID = 15114,
			Level = 999,
			DisplayIDs = {{15288}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 231014 }, -- Foror's Eyepatch
				{ 2, 231016 }, -- Nat Pagle's Fish Terminator
				{ 4, 231271 }, -- Nat Pagle's Broken Reel
				{ 5, 231272 }, -- Tigule's Harpoon
				{ 7, 22739 }, -- Tome of Polymorph: Turtle
			},
			[NORMAL_DIFF] = {
				{ 1,  19945 }, -- Foror's Eyepatch
				{ 2,  19944 }, -- Nat Pagle's Fish Terminator
				{ 4,  19947 }, -- Nat Pagle's Broken Reel
				{ 5,  19946 }, -- Tigule's Harpoon
				{ 7,  22739 }, -- Tome of Polymorph: Turtle
			},
		},
		{ -- ZGThekal
			name = AL["High Priest Thekal"],
			npcID = 14509,
			Level = 999,
			DisplayIDs = {{15216}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19902 }, -- Swift Zulian Tiger
				{ 17, 230923 }, -- Betrayer's Boots
				{ 18, 230925 }, -- Thekal's Grasp
				{ 20, 230927 }, -- Ritualistic Legguards
				{ 21, 230928 }, -- Seafury Leggings
				{ 22, 230926 }, -- Peacekeeper Leggings
				{ 23, 230929 }, -- Seal of Jin
				{ 24, 230930 }, -- Zulian Slicer
			},
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19902 }, -- Swift Zulian Tiger
				{ 17, 19897 }, -- Betrayer's Boots
				{ 18, 19896 }, -- Thekal's Grasp
				{ 20, 19899 }, -- Ritualistic Legguards
				{ 21, 20260 }, -- Seafury Leggings
				{ 22, 20266 }, -- Peacekeeper Leggings
				{ 23, 19898 }, -- Seal of Jin
				{ 24, 19901 }, -- Zulian Slicer
			},
		},
		{ -- ZGArlokk
			name = AL["High Priestess Arlokk"],
			npcID = 14515,
			Level = 999,
			DisplayIDs = {{15218}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 230934 }, -- Arlokk's Grasp
				{ 17, 230939 }, -- Will of Arlokk
				{ 19, 230942 }, -- Bloodsoaked Greaves
				{ 20, 230943 }, -- Overlord's Onyx Band
				{ 21, 230941 }, -- Arlokk's Hoodoo Stick
				{ 23, 19914 }, -- Panther Hide Sack
			},
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19910 }, -- Arlokk's Grasp
				{ 17, 19909 }, -- Will of Arlokk
				{ 19, 19913 }, -- Bloodsoaked Greaves
				{ 20, 19912 }, -- Overlord's Onyx Band
				{ 21, 19922 }, -- Arlokk's Hoodoo Stick
				{ 23, 19914 }, -- Panther Hide Sack
			},
		},
		{ -- ZGJindo
			name = AL["Jin'do the Hexxer"],
			npcID = 11380,
			Level = 999,
			DisplayIDs = {{11311}},
			AtlasMapBossID = 10,
			[SOD_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 231003 }, -- Jin'do's Evil Eye
				{ 17, 231005 }, -- Jin'do's Bag of Whammies
				{ 18, 231002 }, -- Jin'do's Hexxer
				{ 19, 231004 }, -- Jin'do's Judgement
				{ 21, 231013 }, -- The Hexxer's Cover
				{ 22, 231007 }, -- Bloodstained Coif
				{ 23, 231012 }, -- Overlord's Embrace
				{ 24, 231011 }, -- Bloodtinged Gloves
				{ 25, 231010 }, -- Bloodsoaked Gauntlets
				{ 26, 231009 }, -- Blooddrenched Leggings
				{ 27, 231008 }, -- Bloodstained Legplates
				{ 28, 231006 }, -- Animist's Boots
			},
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 19885 }, -- Jin'do's Evil Eye
				{ 17, 19891 }, -- Jin'do's Bag of Whammies
				{ 18, 19890 }, -- Jin'do's Hexxer
				{ 19, 19884 }, -- Jin'do's Judgement
				{ 21, 19886 }, -- The Hexxer's Cover
				{ 22, 19875 }, -- Bloodstained Coif
				{ 23, 19888 }, -- Overlord's Embrace
				{ 24, 19929 }, -- Bloodtinged Gloves
				{ 25, 19894 }, -- Bloodsoaked Gauntlets
				{ 26, 19889 }, -- Blooddrenched Leggings
				{ 27, 19887 }, -- Bloodstained Legplates
				{ 28, 19892 }, -- Animist's Boots
			},
		},
		{ -- ZGHakkar
			name = AL["Hakkar"],
			npcID = 14834,
			Level = 999,
			DisplayIDs = {{15295}},
			AtlasMapBossID = 11,
			[SOD_DIFF] = {
				{ 1,  231300 }, -- Cloak of Consumption
				{ 2,  231305 }, -- Seafury Gauntlets
				{ 3,  231303 }, -- Peacekeeper Gauntlets
				{ 4,  231299 }, -- Bloodsoaked Legplates
				{ 5,  231306 }, -- Soul Corrupter's Necklace
				{ 6,  231307 }, -- The Eye of Hakkar
				{ 8, 19802 }, -- Heart of Hakkar
				{ 16,  231308 }, -- Touch of Chaos
				{ 17,  231302 }, -- Gurubashi Dwarf Destroyer
				{ 18, 231289 }, -- Aegis of the Blood God
				{ 19, 231296 }, -- Bloodcaller
				{ 20, 231309 }, -- Warblade of the Hakkari
				{ 21, 230992 }, -- Warblade of the Hakkari
				{ 22, 231293 }, -- Ancient Hakkari Manslayer
				{ 23, 231301 }, -- Fang of the Faceless
				{ 24, 231315 }, -- Zin'rokh, Destroyer of Worlds
			},
			[NORMAL_DIFF] = {
				{ 1,  19857 }, -- Cloak of Consumption
				{ 2,  20257, [ATLASLOOT_IT_ALLIANCE] = 20264 }, -- Seafury Gauntlets
				--{ 3,  20264, [ATLASLOOT_IT_HORDE] = 20257 }, -- Peacekeeper Gauntlets
				{ 3,  19855 }, -- Bloodsoaked Legplates
				{ 4,  19876 }, -- Soul Corrupter's Necklace
				{ 5,  19856 }, -- The Eye of Hakkar
				{ 7, 19802 }, -- Heart of Hakkar
				{ 16,  19861 }, -- Touch of Chaos
				{ 17,  19853 }, -- Gurubashi Dwarf Destroyer
				{ 18, 19862 }, -- Aegis of the Blood God
				{ 19, 19864 }, -- Bloodcaller
				{ 20, 19865 }, -- Warblade of the Hakkari
				{ 21, 19866 }, -- Warblade of the Hakkari
				{ 22, 19852 }, -- Ancient Hakkari Manslayer
				{ 23, 19859 }, -- Fang of the Faceless
				{ 24, 19854 }, -- Zin'rokh, Destroyer of Worlds
			},
		},
		{
			name = AL["Zul'Gurub Sets"],
			ExtraList = true,
			TableType = SET_ITTYPE,
			[SOD_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Druid"], nil },
				{ 2, 1824 },
				{ 4, "INV_Box_01", nil, AL["Hunter"], nil },
				{ 5, 1825 },
				{ 7, "INV_Box_01", nil, AL["Mage"], nil },
				{ 8, 1826 },
				{ 10, "INV_Box_01", nil, AL["Paladin"], nil },
				{ 11, 1827 },
				{ 15, "INV_Box_01", nil, AL["*Click sets for details*"], nil },
				{ 16, "INV_Box_01", nil, AL["Priest"], nil },
				{ 17, 1828 },
				{ 19, "INV_Box_01", nil, AL["Rogue"], nil },
				{ 20, 1829 },
				{ 22, "INV_Box_01", nil, AL["Shaman"], nil },
				{ 23, 1830 },
				{ 25, "INV_Box_01", nil, AL["Warlock"], nil },
				{ 26, 1831 },
				{ 28, "INV_Box_01", nil, AL["Warrior"], nil },
				{ 29, 1832 },
			},
		},
		{ -- ZGShared
			name = AL["High Priest Shared loot"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  230854 }, -- Band of Servitude
				{ 2,  230855 }, -- Seal of the Gurubashi Berserker
				{ 4,  230862 }, -- Zulian Headdress
				{ 5,  230857 }, -- Blooddrenched Mask
				{ 6,  230858 }, -- Cloak of the Hakkari Worshipers
				{ 7,  230860 }, -- Might of the Tribe
				{ 8,  230859 }, -- Gloves of the Tormented
				{ 9,  230861 }, -- Sacrificial Gauntlets
				{ 10, 230856 }, -- Belt of Untapped Power
				{ 11, 230863 }, -- Zulian Scepter of Rites
			},
			[NORMAL_DIFF] = {
				{ 1,  22721 }, -- Band of Servitude
				{ 2,  22722 }, -- Seal of the Gurubashi Berserker
				{ 4,  22720 }, -- Zulian Headdress
				{ 5,  22718 }, -- Blooddrenched Mask
				{ 6,  22711 }, -- Cloak of the Hakkari Worshipers
				{ 7,  22712 }, -- Might of the Tribe
				{ 8,  22715 }, -- Gloves of the Tormented
				{ 9,  22714 }, -- Sacrificial Gauntlets
				{ 10, 22716 }, -- Belt of Untapped Power
				{ 11, 22713 }, -- Zulian Scepter of Rites
			},
		},
		{ -- ZGTrash1
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  20263 }, -- Gurubashi Helm
				{ 2,  20259 }, -- Shadow Panther Hide Gloves
				{ 3,  20261 }, -- Shadow Panther Hide Belt
				{ 4,  19921 }, -- Zulian Hacker
				{ 5,  19908 }, -- Sceptre of Smiting
				{ 16,  20258 }, -- Zulian Ceremonial Staff
				{ 17, 19726 }, -- Bloodvine
				{ 18, 19774 }, -- Souldarite
				{ 19, 19767 }, -- Primal Bat Leather
				{ 20, 19768 }, -- Primal Tiger Leather
				{ 7, 19706 }, -- Bloodscalp Coin
				{ 8, 19701 }, -- Gurubashi Coin
				{ 9, 19700 }, -- Hakkari Coin
				{ 10, 19699 }, -- Razzashi Coin
				{ 11, 19704 }, -- Sandfury Coin
				{ 12, 19705 }, -- Skullsplitter Coin
				{ 13, 19702 }, -- Vilebranch Coin
				{ 14, 19703 }, -- Witherbark Coin
				{ 15, 19698 }, -- Zulian Coin
				{ 22, 19708 }, -- Blue Hakkari Bijou
				{ 23, 19713 }, -- Bronze Hakkari Bijou
				{ 24, 19715 }, -- Gold Hakkari Bijou
				{ 25, 19711 }, -- Green Hakkari Bijou
				{ 26, 19710 }, -- Orange Hakkari Bijou
				{ 27, 19712 }, -- Purple Hakkari Bijou
				{ 28, 19707 }, -- Red Hakkari Bijou
				{ 29, 19714 }, -- Silver Hakkari Bijou
				{ 30, 19709 }, -- Yellow Hakkari Bijou
			},
			[NORMAL_DIFF] = {
				{ 1,  20263 }, -- Gurubashi Helm
				{ 2,  20259 }, -- Shadow Panther Hide Gloves
				{ 3,  20261 }, -- Shadow Panther Hide Belt
				{ 4,  19921 }, -- Zulian Hacker
				{ 5,  19908 }, -- Sceptre of Smiting
				{ 16,  20258 }, -- Zulian Ceremonial Staff
				{ 17, 19726 }, -- Bloodvine
				{ 18, 19774 }, -- Souldarite
				{ 19, 19767 }, -- Primal Bat Leather
				{ 20, 19768 }, -- Primal Tiger Leather
				{ 7, 19706 }, -- Bloodscalp Coin
				{ 8, 19701 }, -- Gurubashi Coin
				{ 9, 19700 }, -- Hakkari Coin
				{ 10, 19699 }, -- Razzashi Coin
				{ 11, 19704 }, -- Sandfury Coin
				{ 12, 19705 }, -- Skullsplitter Coin
				{ 13, 19702 }, -- Vilebranch Coin
				{ 14, 19703 }, -- Witherbark Coin
				{ 15, 19698 }, -- Zulian Coin
				{ 22, 19708 }, -- Blue Hakkari Bijou
				{ 23, 19713 }, -- Bronze Hakkari Bijou
				{ 24, 19715 }, -- Gold Hakkari Bijou
				{ 25, 19711 }, -- Green Hakkari Bijou
				{ 26, 19710 }, -- Orange Hakkari Bijou
				{ 27, 19712 }, -- Purple Hakkari Bijou
				{ 28, 19707 }, -- Red Hakkari Bijou
				{ 29, 19714 }, -- Silver Hakkari Bijou
				{ 30, 19709 }, -- Yellow Hakkari Bijou
			},
		},
		{ -- ZGEnchants
			name = AL["Enchants"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  19789 }, -- Prophetic Aura
				{ 2,  19787 }, -- Presence of Sight
				{ 3,  19788 }, -- Hoodoo Hex
				{ 4,  19784 }, -- Death's Embrace
				{ 5,  19790 }, -- Animist's Caress
				{ 6,  19785 }, -- Falcon's Call
				{ 7,  19786 }, -- Vodouisant's Vigilant Embrace
				{ 8,  19783 }, -- Syncretist's Sigil
				{ 9,  19782 }, -- Presence of Might
				{ 16, 20077 }, -- Zandalar Signet of Might
				{ 17, 20076 }, -- Zandalar Signet of Mojo
				{ 18, 20078 }, -- Zandalar Signet of Serenity
				{ 20, 22635 }, -- Savage Guard
			},
			[NORMAL_DIFF] = {
				{ 1,  19789 }, -- Prophetic Aura
				{ 2,  19787 }, -- Presence of Sight
				{ 3,  19788 }, -- Hoodoo Hex
				{ 4,  19784 }, -- Death's Embrace
				{ 5,  19790 }, -- Animist's Caress
				{ 6,  19785 }, -- Falcon's Call
				{ 7,  19786 }, -- Vodouisant's Vigilant Embrace
				{ 8,  19783 }, -- Syncretist's Sigil
				{ 9,  19782 }, -- Presence of Might
				{ 16, 20077 }, -- Zandalar Signet of Might
				{ 17, 20076 }, -- Zandalar Signet of Mojo
				{ 18, 20078 }, -- Zandalar Signet of Serenity
				{ 20, 22635 }, -- Savage Guard
			},
		},
		{ -- ZGMuddyChurningWaters
			name = AL["Muddy Churning Waters"],
			ExtraList = true,
			AtlasMapBossID = "1'",
			[SOD_DIFF] = {
				{ 1,  19975 }, -- Zulian Mudskunk
			},
			[NORMAL_DIFF] = {
				{ 1,  19975 }, -- Zulian Mudskunk
			},
		},
		{ -- ZGJinxedHoodooPile
			name = AL["Jinxed Hoodoo Pile"],
			ExtraList = true,
			AtlasMapBossID = "2'",
			[SOD_DIFF] = {
				{ 1,  19727 }, -- Blood Scythe
				{ 3,  19820 }, -- Punctured Voodoo Doll
				{ 4,  19818 }, -- Punctured Voodoo Doll
				{ 5,  19819 }, -- Punctured Voodoo Doll
				{ 6,  19814 }, -- Punctured Voodoo Doll
				{ 7,  19821 }, -- Punctured Voodoo Doll
				{ 8,  19816 }, -- Punctured Voodoo Doll
				{ 9,  19817 }, -- Punctured Voodoo Doll
				{ 10, 19815 }, -- Punctured Voodoo Doll
				{ 11, 19813 }, -- Punctured Voodoo Doll
			},
			[NORMAL_DIFF] = {
				{ 1,  19727 }, -- Blood Scythe
				{ 3,  19820 }, -- Punctured Voodoo Doll
				{ 4,  19818 }, -- Punctured Voodoo Doll
				{ 5,  19819 }, -- Punctured Voodoo Doll
				{ 6,  19814 }, -- Punctured Voodoo Doll
				{ 7,  19821 }, -- Punctured Voodoo Doll
				{ 8,  19816 }, -- Punctured Voodoo Doll
				{ 9,  19817 }, -- Punctured Voodoo Doll
				{ 10, 19815 }, -- Punctured Voodoo Doll
				{ 11, 19813 }, -- Punctured Voodoo Doll
			},
		},
	},
}

data["TheRuinsofAhnQiraj"] = { -- AQ20
	MapID = 3429,
	InstanceID = 509,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheRuinsofAhnQiraj",
	AtlasMapFile = "CL_TheRuinsofAhnQiraj",
	AtlasMapFile_AL = "TheRuinsofAhnQiraj",
	ContentType = RAID_CONTENT,
	ContentPhase = 5,
	LevelRange = GetForVersion({60, 60, 60},{60, 60, 60}),
	items = {
		{ -- AQ20Kurinnaxx
			name = AL["Kurinnaxx"],
			npcID = 15348,
			Level = 999,
			DisplayIDs = {{15742}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  234062 }, -- Vestments of the Shifting Sands
				{ 2,  234061 }, -- Qiraji Sacrificial Dagger
				{ 4,  234065 }, -- Sand Reaver Wristguards
				{ 5,  234066 }, -- Toughened Silithid Hide Gloves
				{ 6,  234064 }, -- Belt of the Inquisition
				{ 7,  234063 }, -- Belt of the Sand Reaver
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
			[NORMAL_DIFF] = {
				{ 1,  21499 }, -- Vestments of the Shifting Sands
				{ 2,  21498 }, -- Qiraji Sacrificial Dagger
				{ 4,  21502 }, -- Sand Reaver Wristguards
				{ 5,  21501 }, -- Toughened Silithid Hide Gloves
				{ 6,  21500 }, -- Belt of the Inquisition
				{ 7,  21503 }, -- Belt of the Sand Reaver
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Rajaxx
			name = AL["General Rajaxx"],
			npcID = 15341,
			Level = 999,
			DisplayIDs = {{15376}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1,  234068 }, -- Boots of the Vanguard
				{ 2,  234067 }, -- Manslayer of the Qiraji
				{ 4,  234070 }, -- Bracers of Qiraji Command
				{ 5,  234072 }, -- Southwind's Grasp
				{ 6,  234071 }, -- Legplates of the Qiraji Command
				{ 7,  234069 }, -- Boots of the Qiraji General
				{ 9,  "INV_Box_01", nil, AL["Trash"] },
				{ 10,  21810 }, -- Treads of the Wandering Nomad
				{ 11,  21809 }, -- Fury of the Forgotten Swarm
				{ 12,  21806 }, -- Gavel of Qiraji Authority
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
			[NORMAL_DIFF] = {
				{ 1,  21493 }, -- Boots of the Vanguard
				{ 2,  21492 }, -- Manslayer of the Qiraji
				{ 4,  21496 }, -- Bracers of Qiraji Command
				{ 5,  21494 }, -- Southwind's Grasp
				{ 6,  21495 }, -- Legplates of the Qiraji Command
				{ 7,  21497 }, -- Boots of the Qiraji General
				{ 9,  "INV_Box_01", nil, AL["Trash"] },
				{ 10,  21810 }, -- Treads of the Wandering Nomad
				{ 11,  21809 }, -- Fury of the Forgotten Swarm
				{ 12,  21806 }, -- Gavel of Qiraji Authority
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Moam
			name = AL["Moam"],
			npcID = 15340,
			Level = 999,
			DisplayIDs = {{15392}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1,  234073 }, -- Dustwind Turban
				{ 2,  234077 }, -- Thick Silithid Chestguard
				{ 3,  234075 }, -- Gauntlets of the Immovable
				{ 4,  234076 }, -- Talon of Furious Concentration
				{ 6,  234084 }, -- Southwind Helm
				{ 7,  234082 }, -- Mantle of Maz'Nadir
				{ 8,  234078 }, -- Chitinous Shoulderguards
				{ 9,  234079 }, -- Cloak of the Savior
				{ 10, 234081 }, -- Gauntlets of Southwind
				{ 11, 234087 }, -- Obsidian Scaled Leggings
				{ 12, 234088 }, -- Legplates of the Destroyer
				{ 13, 234083 }, -- Ring of Fury
				{ 14, 234080 }, -- Eye of Moam
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
				{ 24, 22220 }, -- Plans: Black Grasp of the Destroyer
			},
			[NORMAL_DIFF] = {
				{ 1,  21472 }, -- Dustwind Turban
				{ 2,  21467 }, -- Thick Silithid Chestguard
				{ 3,  21479 }, -- Gauntlets of the Immovable
				{ 4,  21471 }, -- Talon of Furious Concentration
				{ 6,  21455 }, -- Southwind Helm
				{ 7,  21468 }, -- Mantle of Maz'Nadir
				{ 8,  21474 }, -- Chitinous Shoulderguards
				{ 9,  21470 }, -- Cloak of the Savior
				{ 10, 21469 }, -- Gauntlets of Southwind
				{ 11, 21476 }, -- Obsidian Scaled Leggings
				{ 12, 21475 }, -- Legplates of the Destroyer
				{ 13, 21477 }, -- Ring of Fury
				{ 14, 21473 }, -- Eye of Moam
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
				{ 24, 22220 }, -- Plans: Black Grasp of the Destroyer
			},
		},
		{ -- AQ20Buru
			name = AL["Buru the Gorger"],
			npcID = 15370,
			Level = 999,
			DisplayIDs = {{15654}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1,  234091 }, -- Slimy Scaled Gauntlets
				{ 2,  234090 }, -- Gloves of the Swarm
				{ 3,  234089 }, -- Buru's Skull Fragment
				{ 5,  234094 }, -- Scaled Bracers of the Gorger
				{ 6,  234093 }, -- Quicksand Waders
				{ 7,  234095 }, -- Slime Kickers
				{ 8,  234092 }, -- Fetish of Chitinous Spikes
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
			[NORMAL_DIFF] = {
				{ 1,  21487, [ATLASLOOT_IT_ALLIANCE] = 21486 }, -- Slimy Scaled Gauntlets
				{ 2,  21486 }, -- Gloves of the Swarm
				{ 3,  21485 }, -- Buru's Skull Fragment
				{ 5,  21491 }, -- Scaled Bracers of the Gorger
				{ 6,  21489 }, -- Quicksand Waders
				{ 7,  21490 }, -- Slime Kickers
				{ 8,  21488 }, -- Fetish of Chitinous Spikes
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ayamiss
			name = AL["Ayamiss the Hunter"],
			npcID = 15369,
			Level = 999,
			DisplayIDs = {{15431}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1,  234075 }, -- Gauntlets of the Immovable
				{ 2,  234096 }, -- Bow of Taut Sinew
				{ 3,  234097 }, -- Stinger of Ayamiss
				{ 5,  234100 }, -- Helm of Regrowth
				{ 6,  234102 }, -- Scaled Silithid Gauntlets
				{ 7,  234099 }, -- Boots of the Fiery Sands
				{ 8,  234098 }, -- Boots of the Desert Protector
				{ 9,  234101 }, -- Ring of the Desert Winds
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
			[NORMAL_DIFF] = {
				{ 1,  21479 }, -- Gauntlets of the Immovable
				{ 2,  21478 }, -- Bow of Taut Sinew
				{ 3,  21466 }, -- Stinger of Ayamiss
				{ 5,  21484 }, -- Helm of Regrowth
				{ 6,  21480 }, -- Scaled Silithid Gauntlets
				{ 7,  21482 }, -- Boots of the Fiery Sands
				{ 8,  21481 }, -- Boots of the Desert Protector
				{ 9,  21483 }, -- Ring of the Desert Winds
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ossirian
			name = AL["Ossirian the Unscarred"],
			npcID = 15339,
			Level = 999,
			DisplayIDs = {{15432}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  234107 }, -- Helm of Domination
				{ 2,  234111 }, -- Runic Stone Shoulders
				{ 3,  234113 }, -- Sandstorm Cloak
				{ 4,  234114 }, -- Shackles of the Unscarred
				{ 5,  234103 }, -- Bracers of Brutality
				{ 6,  234106 }, -- Gloves of Dark Wisdom
				{ 7,  234105 }, -- Gauntlets of New Life
				{ 8,  234110 }, -- Ossirian's Binding
				{ 9,  234108 }, -- Leggings of the Black Blizzard
				{ 10, 234104 }, -- Crossbow of Imminent Doom
				{ 11, 234112 }, -- Sand Polished Hammer
				{ 12, 234115 }, -- Staff of the Ruins
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
				{ 23, 21220 }, -- Head of Ossirian the Unscarred
				{ 25, "INV_Box_01", nil, AL["Hard Mode Mounts"], nil },
				{ 26, 235511 }, -- Flawless Yellow Qiraji Resonating Crystal
				{ 27, 235512 }, -- Flawless Green Qiraji Resonating Crystal
				{ 28, 235513 }, -- Flawless Blue Qiraji Resonating Crystal
				{ 29, 235514 }, -- Flawless Red Qiraji Resonating Crystal
			},
			[NORMAL_DIFF] = {
				{ 1,  21460 }, -- Helm of Domination
				{ 2,  21454, [ATLASLOOT_IT_ALLIANCE] = 21453 }, -- Runic Stone Shoulders
				{ 3,  21456 }, -- Sandstorm Cloak
				{ 4,  21464 }, -- Shackles of the Unscarred
				{ 5,  21457 }, -- Bracers of Brutality
				{ 6,  21462 }, -- Gloves of Dark Wisdom
				{ 7,  21458 }, -- Gauntlets of New Life
				{ 8,  21463 }, -- Ossirian's Binding
				{ 9,  21461 }, -- Leggings of the Black Blizzard
				{ 10, 21459 }, -- Crossbow of Imminent Doom
				{ 11, 21715 }, -- Sand Polished Hammer
				{ 12, 21452 }, -- Staff of the Ruins
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
				{ 23, 21220 }, -- Head of Ossirian the Unscarred
			},
		},
		{ -- AQ20Trash
	name = AL["Trash"],
	ExtraList = true,
	[SOD_DIFF] = {
		{ 1,  234123 }, -- Coif of Elemental Fury
		{ 2,  234120 }, -- Helm of the Holy Avenger
		{ 3,  21805 }, -- Polished Obsidian Pauldrons
		{ 5,  20873 }, -- Alabaster Idol
		{ 6,  20869 }, -- Amber Idol
		{ 7,  20866 }, -- Azure Idol
		{ 8,  20870 }, -- Jasper Idol
		{ 9,  20868 }, -- Lambent Idol
		{ 10, 20871 }, -- Obsidian Idol
		{ 11, 20867 }, -- Onyx Idol
		{ 12, 20872 }, -- Vermillion Idol
		{ 14, 21761 }, -- Scarab Coffer Key
		{ 15, 21156 }, -- Scarab Bag
		{ 16, 234119 }, -- Antenna of Invigoration
		{ 17, 234121 }, -- Silithid Husked Launcher
		{ 18, 234122 }, -- The Lost Kris of Zedd
		{ 20, 20864 }, -- Bone Scarab
		{ 21, 20861 }, -- Bronze Scarab
		{ 22, 20863 }, -- Clay Scarab
		{ 23, 20862 }, -- Crystal Scarab
		{ 24, 20859 }, -- Gold Scarab
		{ 25, 20865 }, -- Ivory Scarab
		{ 26, 20860 }, -- Silver Scarab
		{ 27, 20858 }, -- Stone Scarab
		{ 29, 22203 }, -- Large Obsidian Shard
		{ 30, 22202 }, -- Small Obsidian Shard
	},
	[NORMAL_DIFF] = {
		{ 1,  21804, [ATLASLOOT_IT_ALLIANCE] = 21803 }, -- Coif of Elemental Fury
		{ 2,  21803 }, -- Helm of the Holy Avenger
		{ 3,  21805 }, -- Polished Obsidian Pauldrons
		{ 5,  20873 }, -- Alabaster Idol
		{ 6,  20869 }, -- Amber Idol
		{ 7,  20866 }, -- Azure Idol
		{ 8,  20870 }, -- Jasper Idol
		{ 9,  20868 }, -- Lambent Idol
		{ 10, 20871 }, -- Obsidian Idol
		{ 11, 20867 }, -- Onyx Idol
		{ 12, 20872 }, -- Vermillion Idol
		{ 14, 21761 }, -- Scarab Coffer Key
		{ 15, 21156 }, -- Scarab Bag
		{ 16, 21801 }, -- Antenna of Invigoration
		{ 17, 21800 }, -- Silithid Husked Launcher
		{ 18, 21802 }, -- The Lost Kris of Zedd
		{ 20, 20864 }, -- Bone Scarab
		{ 21, 20861 }, -- Bronze Scarab
		{ 22, 20863 }, -- Clay Scarab
		{ 23, 20862 }, -- Crystal Scarab
		{ 24, 20859 }, -- Gold Scarab
		{ 25, 20865 }, -- Ivory Scarab
		{ 26, 20860 }, -- Silver Scarab
		{ 27, 20858 }, -- Stone Scarab
		{ 29, 22203 }, -- Large Obsidian Shard
		{ 30, 22202 }, -- Small Obsidian Shard
	},
},
{ -- AQ20ClassBooks
	name = AL["Class books"],
	ExtraList = true,
	[SOD_DIFF] = {
		{ 1,  21284 }, -- Codex of Greater Heal V
		{ 2,  21287 }, -- Codex of Prayer of Healing V
		{ 3,  21285 }, -- Codex of Renew X
		{ 4,  21279 }, -- Tome of Fireball XII
		{ 5,  21214 }, -- Tome of Frostbolt XI
		{ 6,  21280 }, -- Tome of Arcane Missiles VIII
		{ 7,  21281 }, -- Grimoire of Shadow Bolt X
		{ 8,  21283 }, -- Grimoire of Corruption VII
		{ 9,  21282 }, -- Grimoire of Immolate VIII
		{ 10, 21300 }, -- Handbook of Backstab IX
		{ 11, 21303 }, -- Handbook of Feint V
		{ 12, 21302 }, -- Handbook of Deadly Poison V
		{ 13, 21294 }, -- Book of Healing Touch XI
		{ 14, 21296 }, -- Book of Rejuvenation XI
		{ 15, 21295 }, -- Book of Starfire VII
		{ 16, 21306 }, -- Guide: Serpent Sting IX
		{ 17, 21304 }, -- Guide: Multi-Shot V
		{ 18, 21307 }, -- Guide: Aspect of the Hawk VII
		{ 19, 21291 }, -- Tablet of Healing Wave X
		{ 20, 21292 }, -- Tablet of Strength of Earth Totem V
		{ 21, 21293 }, -- Tablet of Grace of Air Totem III
		{ 22, 21288 }, -- Libram: Blessing of Wisdom VI
		{ 23, 21289 }, -- Libram: Blessing of Might VII
		{ 24, 21290 }, -- Libram: Holy Light IX
		{ 25, 21298 }, -- Manual of Battle Shout VII
		{ 26, 21299 }, -- Manual of Revenge VI
		{ 27, 21297 }, -- Manual of Heroic Strike IX
	},
	[NORMAL_DIFF] = {
		{ 1,  21284 }, -- Codex of Greater Heal V
		{ 2,  21287 }, -- Codex of Prayer of Healing V
		{ 3,  21285 }, -- Codex of Renew X
		{ 4,  21279 }, -- Tome of Fireball XII
		{ 5,  21214 }, -- Tome of Frostbolt XI
		{ 6,  21280 }, -- Tome of Arcane Missiles VIII
		{ 7,  21281 }, -- Grimoire of Shadow Bolt X
		{ 8,  21283 }, -- Grimoire of Corruption VII
		{ 9,  21282 }, -- Grimoire of Immolate VIII
		{ 10, 21300 }, -- Handbook of Backstab IX
		{ 11, 21303 }, -- Handbook of Feint V
		{ 12, 21302 }, -- Handbook of Deadly Poison V
		{ 13, 21294 }, -- Book of Healing Touch XI
		{ 14, 21296 }, -- Book of Rejuvenation XI
		{ 15, 21295 }, -- Book of Starfire VII
		{ 16, 21306 }, -- Guide: Serpent Sting IX
		{ 17, 21304 }, -- Guide: Multi-Shot V
		{ 18, 21307 }, -- Guide: Aspect of the Hawk VII
		{ 19, 21291 }, -- Tablet of Healing Wave X
		{ 20, 21292 }, -- Tablet of Strength of Earth Totem V
		{ 21, 21293 }, -- Tablet of Grace of Air Totem III
		{ 22, 21288 }, -- Libram: Blessing of Wisdom VI
		{ 23, 21289 }, -- Libram: Blessing of Might VII
		{ 24, 21290 }, -- Libram: Holy Light IX
		{ 25, 21298 }, -- Manual of Battle Shout VII
		{ 26, 21299 }, -- Manual of Revenge VI
		{ 27, 21297 }, -- Manual of Heroic Strike IX
	},
},
		AQ_SCARABS,
		AQ_ENCHANTS,
		AQ_OPENING,
	},
}


data["BlackwingLair"] = {
	MapID = 2677,
	InstanceID = 469,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackwingLair",
	AtlasMapFile = "CL_BlackwingLair",
	AtlasMapFile_AL = "BlackwingLair",
	ContentType = RAID_CONTENT,
	LevelRange = GetForVersion({60, 60, 60},{60, 60, 60}),
	ContentPhase = 3,
	items = {
		{ -- BWLRazorgore
			name = AL["Razorgore the Untamed"],
			npcID = 12435,
			Level = 999,
			DisplayIDs = {{10115}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1, 231729 }, -- Ancient Gloves
				{ 2, 231720 }, -- Primeval Gloves
				{ 3, 231712 }, -- Draconian Gloves
				{ 5, 231722 }, -- Depleted Scythe of Chaos
				{ 6, 229352 }, -- Intelligence Findings
				{ 16, 230237 }, -- Arcane Infused Gem
				{ 17, 230238 }, -- The Black Book
				{ 19, 230240 }, -- Mantle of the Blackwing Cabal
				{ 20, 230239 }, -- Gloves of Rapid Evolution
				{ 21, 230241 }, -- Spineshatter
				{ 22, 230242 }, -- The Untamed Blade
			},
			[NORMAL_DIFF] = {
				{ 1,  16926 }, -- Bindings of Transcendence
				{ 2,  16918 }, -- Netherwind Bindings
				{ 3,  16934 }, -- Nemesis Bracers
				{ 4,  16911 }, -- Bloodfang Bracers
				{ 5,  16904 }, -- Stormrage Bracers
				{ 6,  16935 }, -- Dragonstalker's Bracers
				{ 7,  16943 }, -- Bracers of Ten Storms
				{ 8,  16951 }, -- Judgement Bindings
				{ 9,  16959 }, -- Bracelets of Wrath
				{ 16, 19336 }, -- Arcane Infused Gem
				{ 17, 19337 }, -- The Black Book
				{ 19, 19370 }, -- Mantle of the Blackwing Cabal
				{ 20, 19369 }, -- Gloves of Rapid Evolution
				{ 21, 19335 }, -- Spineshatter
				{ 22, 19334 }, -- The Untamed Blade
			},
		},
		{ -- BWLVaelastrasz
			name = AL["Vaelastrasz the Corrupt"],
			npcID = 13020,
			Level = 999,
			DisplayIDs = {{13992}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1, 231727 }, -- Ancient Leggings
				{ 2, 231718 }, -- Primeval Leggings
				{ 3, 231710 }, -- Draconian Leggings
				{ 5, 230243 }, -- Mind Quickening Gem
				{ 7, 230904 }, -- Scroll: SEENECS FO RIEF
				{ 8, 231378 }, -- Shimmering Golden Disk
				{ 16, 230244 }, -- Shapeshifter's Sigil
				{ 17, 230246 }, -- Helm of Endless Rage
				{ 18, 230245 }, -- Pendant of the Fallen Dragon
				{ 19, 230248 }, -- Red Dragonscale Protector
				{ 20, 230247 }, -- Dragonfang Blade
				{ 21, 230848 }, -- Interlaced Shadow Jerkin
				{ 22, 230843 }, -- Boots of Pure Thought
				{ 23, 230849 }, -- Ringo's Blizzard Boots
				{ 24, 230846 }, -- Band of Dark Dominion
				{ 25, 230845 }, -- Doom's Edge
				{ 26, 232357 }, -- Draconic Avenger
			},
			[NORMAL_DIFF] = {
				{ 1,  16925 }, -- Belt of Transcendence
				{ 2,  16818 }, -- Netherwind Belt
				{ 3,  16933 }, -- Nemesis Belt
				{ 4,  16910 }, -- Bloodfang Belt
				{ 5,  16903 }, -- Stormrage Belt
				{ 6,  16936 }, -- Dragonstalker's Belt
				{ 7,  16944 }, -- Belt of Ten Storms
				{ 8,  16952 }, -- Judgement Belt
				{ 9,  16960 }, -- Waistband of Wrath
				{ 16, 19339 }, -- Mind Quickening Gem
				{ 17, 19340 }, -- Rune of Metamorphosis
				{ 19, 19372 }, -- Helm of Endless Rage
				{ 20, 19371 }, -- Pendant of the Fallen Dragon
				{ 21, 19348 }, -- Red Dragonscale Protector
				{ 22, 19346 }, -- Dragonfang Blade
			},
		},
		{ -- BWLLashlayer
			name = AL["Broodlord Lashlayer"],
			npcID = 12017,
			Level = 999,
			DisplayIDs = {{14308}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1, 231730 }, -- Ancient Boots
				{ 2, 231721 }, -- Primeval Boots
				{ 3, 231713 }, -- Draconian Boots
				{ 5, 231452 }, -- Blood of the Lightbringer
				{ 6, 231882 }, -- Suppression Device Receipt
				{ 7, 231995 }, -- Hardened Elementium Slag
				{ 16, 230249 }, -- Lifegiving Gem
				{ 17, 230250 }, -- Venomous Totem
				{ 19, 230251 }, -- Black Brood Pauldrons
				{ 20, 230252 }, -- Bracers of Arcane Accuracy
				{ 21, 230253 }, -- Heartstriker
				{ 22, 230254 }, -- Maladath, Runed Blade of the Black Flight
				{ 24, 20383 }, -- Head of the Broodlord Lashlayer
			},
			[NORMAL_DIFF] = {
				{ 1,  16919 }, -- Boots of Transcendence
				{ 2,  16912 }, -- Netherwind Boots
				{ 3,  16927 }, -- Nemesis Boots
				{ 4,  16906 }, -- Bloodfang Boots
				{ 5,  16898 }, -- Stormrage Boots
				{ 6,  16941 }, -- Dragonstalker's Greaves
				{ 7,  16949 }, -- Greaves of Ten Storms
				{ 8,  16957 }, -- Judgement Sabatons
				{ 9,  16965 }, -- Sabatons of Wrath
				{ 16, 19341 }, -- Lifegiving Gem
				{ 17, 19342 }, -- Venomous Totem
				{ 19, 19373 }, -- Black Brood Pauldrons
				{ 20, 19374 }, -- Bracers of Arcane Accuracy
				{ 21, 19350 }, -- Heartstriker
				{ 22, 19351 }, -- Maladath, Runed Blade of the Black Flight
				{ 24, 20383 }, -- Head of the Broodlord Lashlayer
			},
		},
		{ -- BWLFiremaw
			name = AL["Firemaw"],
			npcID = 11983,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1, 231727 }, -- Ancient Leggings
				{ 2, 231718 }, -- Primeval Leggings
				{ 3, 231710 }, -- Draconian Leggings
				{ 5, 230273 }, -- Natural Alignment Crystal
				{ 6, 230272 }, -- Scrolls of Blinding Light
				{ 7, 230282 }, -- Drake Fang Talisman
				{ 9, 230847 }, -- Essence Gatherer (firemaw Flamegor)
				{ 10, 230844 }, -- Draconic Maul (firemaw flamegor)
				{ 11, 230276 }, -- Claw of the Black Drake
				--{ 12, 230271 }, -- Drake Talon Cleaver
				{ 12, 230270 }, -- Shadow Wing Focus Staff
				{ 16, 230256 }, -- Drake Talon Pauldrons
				{ 17, 230277 }, -- Cloak of Firemaw
				{ 18, 230274 }, -- Black Ash Robe
				{ 19, 230275 }, -- Firemaw's Clutch
				{ 20, 230255 }, -- Taut Dragonhide Belt
				{ 21, 230279 }, -- Primalist's Linked Legguards
				{ 22, 230278 }, -- Legguards of the Fallen Crusader
				{ 23, 230842 }, -- Cloak of Draconic Might (firemaw Flamegor)
				{ 25, 230257 }, -- Ring of Blackrock
				{ 26, 230269 }, -- Rejuvenating Gem
			},
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 13, 19344 }, -- Natural Alignment Crystal
				{ 14, 19343 }, -- Scrolls of Blinding Light
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19398 }, -- Cloak of Firemaw
				{ 18, 19399 }, -- Black Ash Robe
				{ 19, 19400 }, -- Firemaw's Clutch
				{ 20, 19396 }, -- Taut Dragonhide Belt
				{ 21, 19401 }, -- Primalist's Linked Legguards
				{ 22, 19402 }, -- Legguards of the Fallen Crusader
				{ 24, 19365 }, -- Claw of the Black Drake
				{ 25, 19353 }, -- Drake Talon Cleaver
				{ 26, 19355 }, -- Shadow Wing Focus Staff
				{ 28, 19397 }, -- Ring of Blackrock
				{ 29, 19395 }, -- Rejuvenating Gem
			},
			
		},
		{ -- BWLEbonroc
			name = AL["Ebonroc"],
			npcID = 14601,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1, 231728 }, -- Ancient Helm
				{ 2, 231719 }, -- Primeval Helm
				{ 3, 231711 }, -- Draconian Hood
				{ 5, 230280 }, -- Aegis of Preservation
				{ 7, 230269 }, -- Rejuvenating Gem
				{ 16, 230256 }, -- Drake Talon Pauldrons
				{ 17, 19407 }, -- Ebony Flame Gloves
				{ 18, 230255 }, -- Taut Dragonhide Belt
				{ 19, 230725 }, -- Malfurion's Blessed Bulwark
				{ 20, 230726 }, -- Dragonbreath Hand Cannon
				{ 21, 230271 }, -- Drake Talon Cleaver
				{ 22, 230270 }, -- Shadow Wing Focus Staff
				{ 23, 230281 }, -- Band of Forced Concentration
				{ 24, 230257 }, -- Ring of Blackrock
			},
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 11, 19345 }, -- Aegis of Preservation
				{ 12, 19406 }, -- Drake Fang Talisman
				{ 13, 19395 }, -- Rejuvenating Gem
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19407 }, -- Ebony Flame Gloves
				{ 18, 19396 }, -- Taut Dragonhide Belt
				{ 19, 19405 }, -- Malfurion's Blessed Bulwark
				{ 21, 19368 }, -- Dragonbreath Hand Cannon
				{ 22, 19353 }, -- Drake Talon Cleaver
				{ 23, 19355 }, -- Shadow Wing Focus Staff
				{ 26, 19403 }, -- Band of Forced Concentration
				{ 27, 19397 }, -- Ring of Blackrock
			},
		},
		{ -- BWLFlamegor
			name = AL["Flamegor"],
			npcID = 11981,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1, 230269 }, -- Rejuvenating Gem
				{ 2, 230736 }, -- Styleen's Impeding Scarab
				{ 3, 230282 }, -- Drake Fang Talisman
				{ 5, 230256 }, -- Drake Talon Pauldrons
				{ 6, 230733 }, -- Shroud of Pure Thought
				{ 7, 230255 }, -- Taut Dragonhide Belt
				{ 8, 230735 }, -- Emberweave Leggings
				{ 9,  230842 }, -- Cloak of Draconic Might (firemaw Flamegor)
				{ 11, 230734 }, -- Circle of Applied Force
				{ 12, 230257 }, -- Ring of Blackrock
				{ 16, 230737 }, -- Dragon's Touch
				{ 17, 230738 }, -- Herald of Woe
				{ 18, 230844 }, -- Draconic Maul
				{ 19, 230847 }, -- Essence Gatherer (firemaw Flamegor)
				{ 20, 230270 }, -- Shadow Wing Focus Staff
			},
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 11, 19395 }, -- Rejuvenating Gem
				{ 12, 19431 }, -- Styleen's Impeding Scarab
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19430 }, -- Shroud of Pure Thought
				{ 18, 19396 }, -- Taut Dragonhide Belt
				{ 19, 19433 }, -- Emberweave Leggings
				{ 21, 19367 }, -- Dragon's Touch
				{ 22, 19353 }, -- Drake Talon Cleaver
				{ 23, 19357 }, -- Herald of Woe
				{ 24, 19355 }, -- Shadow Wing Focus Staff
				{ 26, 19432 }, -- Circle of Applied Force
				{ 27, 19397 }, -- Ring of Blackrock
			},
		},
		{ -- BWLChromaggus
			name = AL["Chromaggus"],
			npcID = 14020,
			Level = 999,
			DisplayIDs = {{14367}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, 231726 }, -- Ancient Shoulderpads
				{ 2, 231717 }, -- Primeval Shoulderpads
				{ 3, 231709 }, -- Draconian Shoulderpads
				{ 5, 231814 }, -- Chromatic Heart
				{ 6, 229906 }, -- Tarnished Bronze Scale
				{ 16, 230740 }, -- Taut Dragonhide Shoulderpads
				{ 17, 230744 }, -- Elementium Threaded Cloak
				{ 18, 230742 }, -- Taut Dragonhide Gloves
				{ 19, 230739 }, -- Angelista's Grasp
				{ 20, 230800 }, -- Primalist's Linked Waistguard
				{ 21, 230745 }, -- Girdle of the Fallen Crusader
				{ 22, 230746 }, -- Empowered Leggings
				{ 23, 230743 }, -- Shimmering Geta
				{ 24, 230741 }, -- Chromatic Boots
				{ 26, 230801 }, -- Ashjre'thul, Crossbow of Smiting
				{ 27, 230802 }, -- Elementium Reinforced Bulwark
				{ 28, 230794 }, -- Claw of Chromaggus
				{ 29, 230747 }, -- Chromatically Tempered Sword
			},
			[NORMAL_DIFF] = {
				{ 1,  16924 }, -- Pauldrons of Transcendence
				{ 2,  16917 }, -- Netherwind Mantle
				{ 3,  16932 }, -- Nemesis Spaulders
				{ 4,  16832 }, -- Bloodfang Spaulders
				{ 5,  16902 }, -- Stormrage Pauldrons
				{ 6,  16937 }, -- Dragonstalker's Spaulders
				{ 7,  16945 }, -- Epaulets of Ten Storms
				{ 8,  16953 }, -- Judgement Spaulders
				{ 9,  16961 }, -- Pauldrons of Wrath
				{ 16, 19389 }, -- Taut Dragonhide Shoulderpads
				{ 17, 19386 }, -- Elementium Threaded Cloak
				{ 18, 19390 }, -- Taut Dragonhide Gloves
				{ 19, 19388 }, -- Angelista's Grasp
				{ 20, 19393 }, -- Primalist's Linked Waistguard
				{ 21, 19392 }, -- Girdle of the Fallen Crusader
				{ 22, 19385 }, -- Empowered Leggings
				{ 23, 19391 }, -- Shimmering Geta
				{ 24, 19387 }, -- Chromatic Boots
				{ 26, 19361 }, -- Ashjre'thul, Crossbow of Smiting
				{ 27, 19349 }, -- Elementium Reinforced Bulwark
				{ 28, 19347 }, -- Claw of Chromaggus
				{ 29, 19352 }, -- Chromatically Tempered Sword
			},
		},
		{ -- BWLNefarian
			name = AL["Nefarian"],
			npcID = 11583,
			Level = 999,
			DisplayIDs = {{11380}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1, 19003 }, -- Head of Nefarian
				{ 2, 230838 }, -- Lok'amir il Romathis
				{ 3, 230837 }, -- Crul'shorukh, Edge of Chaos
				{ 4, 230818 }, -- Ashkandi, Greatsword of the Brotherhood
				{ 5, 230813 }, -- Staff of the Shadow Flame
				{ 6, 230812 }, -- Mish'undare, Circlet of the Mind Flayer
				{ 7, 231803 }, -- Prestor's Talisman of Connivery
				{ 8, 230804 }, -- Cloak of the Brood Lord
				{ 9, 230806 }, -- Therazane's Link
				{ 10, 230805 }, -- Boots of the Shadow Flame
				{ 11, 230808 }, -- Archimtiros' Ring of Reckoning
				{ 12, 230811 }, -- Pure Elementium Band
				{ 13, 230810 }, -- Neltharion's Tear
				{ 15, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
				{ 16, 231726 }, -- Ancient Shoulderpads
				{ 17, 231717 }, -- Primeval Shoulderpads
				{ 18, 231709 }, -- Draconian Shoulderpads
				{ 20, 231731 }, -- Ancient Chest
				{ 21, 231723 }, -- Primeval Chest
				{ 22, 231714 }, -- Draconian Robe
				{ 24, 231727 }, -- Ancient Leggings
				{ 25, 231718 }, -- Primeval Leggings
				{ 26, 231710 }, -- Draconian Leggings
				{ 30, "INV_Box_01", nil, AL["Continued-->"], nil },
				{ 101, 231724 }, -- Ancient Bindings
				{ 102, 231715 }, -- Primeval Bindings
				{ 103, 231707 }, -- Draconian Bindings
				{ 105, 231729 }, -- Ancient Gloves
				{ 106, 231720 }, -- Primeval Gloves
				{ 107, 231712 }, -- Draconian Gloves
				{ 109, 231730 }, -- Ancient Boots
				{ 110, 231721 }, -- Primeval Boots
				{ 111, 231713 }, -- Draconian Boots
				{ 113, 231725 }, -- Ancient Belt
				{ 114, 231716 }, -- Primeval Belt
				{ 115, 231708 }, -- Draconian Belt
				{ 116, 231728 }, -- Ancient Helm
				{ 117, 231719 }, -- Primeval Helm
				{ 118, 231711 }, -- Draconian Hood
			},
			[NORMAL_DIFF] = {
				{ 1,  16923 }, -- Robes of Transcendence
				{ 2,  16916 }, -- Netherwind Robes
				{ 3,  16931 }, -- Nemesis Robes
				{ 4,  16905 }, -- Bloodfang Chestpiece
				{ 5,  16897 }, -- Stormrage Chestguard
				{ 6,  16942 }, -- Dragonstalker's Breastplate
				{ 7,  16950 }, -- Breastplate of Ten Storms
				{ 8,  16958 }, -- Judgement Breastplate
				{ 9,  16966 }, -- Breastplate of Wrath
				{ 11, 19003 }, -- Head of Nefarian
				{ 16, 19360 }, -- Lok'amir il Romathis
				{ 17, 19363 }, -- Crul'shorukh, Edge of Chaos
				{ 18, 19364 }, -- Ashkandi, Greatsword of the Brotherhood
				{ 19, 19356 }, -- Staff of the Shadow Flame
				{ 21, 19375 }, -- Mish'undare, Circlet of the Mind Flayer
				{ 22, 19377 }, -- Prestor's Talisman of Connivery
				{ 23, 19378 }, -- Cloak of the Brood Lord
				{ 24, 19380 }, -- Therazane's Link
				{ 25, 19381 }, -- Boots of the Shadow Flame
				{ 26, 19376 }, -- Archimtiros' Ring of Reckoning
				{ 27, 19382 }, -- Pure Elementium Band
				{ 28, 19379 }, -- Neltharion's Tear
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- BWLSets
			name = AL["Tier 2 Tokens"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1, 231728 }, -- Ancient Helm
				{ 2, 231726 }, -- Ancient Shoulderpads
				{ 3, 231731 }, -- Ancient Chest
				{ 4, 231727 }, -- Ancient Leggings
				{ 5, 231725 }, -- Ancient Belt
				{ 6, 231724 }, -- Ancient Bindings
				{ 7, 231729 }, -- Ancient Gloves
				{ 8, 231730 }, -- Ancient Boots
				{ 16, 231719 }, -- Primeval Helm
				{ 17, 231717 }, -- Primeval Shoulderpads
				{ 18, 231723 }, -- Primeval Chest
				{ 19, 231718 }, -- Primeval Leggings
				{ 20, 231716 }, -- Primeval Belt
				{ 21, 231715 }, -- Primeval Bindings
				{ 22, 231720 }, -- Primeval Gloves
				{ 23, 231721 }, -- Primeval Boots
				{ 11, 231711 }, -- Draconian Hood
				{ 12, 231709 }, -- Draconian Shoulderpads
				{ 13, 231714 }, -- Draconian Robe
				{ 14, 231710 }, -- Draconian Leggings
				{ 26, 231708 }, -- Draconian Belt
				{ 27, 231707 }, -- Draconian Bindings
				{ 28, 231712 }, -- Draconian Gloves
				{ 29, 231713 }, -- Draconian Boots
			},
		},
		{ -- BWLTrashMobs
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 11, 18562 }, -- Elementium Ore
			},
			[NORMAL_DIFF] = {
				{ 1,  19436 }, -- Cloak of Draconic Might
				{ 2,  19439 }, -- Interlaced Shadow Jerkin
				{ 3,  19437 }, -- Boots of Pure Thought
				{ 4,  19438 }, -- Ringo's Blizzard Boots
				{ 5,  19434 }, -- Band of Dark Dominion
				{ 6,  19435 }, -- Essence Gatherer
				{ 7,  19362 }, -- Doom's Edge
				{ 8,  19354 }, -- Draconic Avenger
				{ 9,  19358 }, -- Draconic Maul
				{ 11, 18562 }, -- Elementium Ore
			},
		},
	},
}

data["TheTempleofAhnQiraj"] = { -- AQ40
	MapID = 3428,
	InstanceID = 531,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheTempleofAhnQiraj",
	AtlasMapFile = "CL_TheTempleofAhnQiraj",
	AtlasMapFile_AL = "TheTempleofAhnQiraj",
	ContentType = RAID_CONTENT,
	ContentPhase = 5,
	LevelRange = GetForVersion({60, 60, 60},{60, 60, 60}),
	items = {
		{ -- AQ40Skeram
			name = AL["The Prophet Skeram"],
			npcID = 15263,
			Level = 999,
			DisplayIDs = {{15345}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  233496 }, -- Barrage Shoulders
				{ 2,  233516 }, -- Breastplate of Annihilation
				{ 3,  233506 }, -- Beetle Scaled Wristguards
				{ 4,  233505 }, -- Leggings of Immersion
				{ 5,  233518 }, -- Boots of the Fallen Prophet
				{ 6,  233517 }, -- Boots of the Redeemed Prophecy
				{ 7,  233514 }, -- Boots of the Unwavering Will
				{ 9,  233502 }, -- Amulet of Foul Warding
				{ 10, 233503 }, -- Pendant of the Qiraji Guardian
				{ 11, 233504 }, -- Cloak of Concentrated Hatred
				{ 12, 233507 }, -- Ring of Swarming Thought
				{ 13, 233515 }, -- Hammer of Ji'zhi
				{ 14, 233509 }, -- Staff of the Qiraji Prophets
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
				{ 19, 22222 }, -- Plans: Thick Obsidian Breastplate
				--{ 20, 22196 }, -- Thick Obsidian Breastplate
			},
			[NORMAL_DIFF] = {
				{ 1,  21699 }, -- Barrage Shoulders
				{ 2,  21814 }, -- Breastplate of Annihilation
				{ 3,  21708 }, -- Beetle Scaled Wristguards
				{ 4,  21698 }, -- Leggings of Immersion
				{ 5,  21705 }, -- Boots of the Fallen Prophet
				{ 6,  21704 }, -- Boots of the Redeemed Prophecy
				{ 7,  21706 }, -- Boots of the Unwavering Will
				{ 9,  21702 }, -- Amulet of Foul Warding
				{ 10, 21700 }, -- Pendant of the Qiraji Guardian
				{ 11, 21701 }, -- Cloak of Concentrated Hatred
				{ 12, 21707 }, -- Ring of Swarming Thought
				{ 13, 21703 }, -- Hammer of Ji'zhi
				{ 14, 21128 }, -- Staff of the Qiraji Prophets
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 22222 }, -- Plans: Thick Obsidian Breastplate
				--{ 20, 22196 }, -- Thick Obsidian Breastplate
			},
		},
		{ -- AQ40Trio
			name = AL["Bug Trio"],
			npcID = {15543, 15544, 15511},
			Level = 999,
			DisplayIDs = {{15657},{15658},{15656}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1,  233522 }, -- Guise of the Devourer
				{ 2,  233521 }, -- Ternary Mantle
				{ 3,  233519 }, -- Cape of the Trinity
				{ 4,  233520 }, -- Robes of the Triumvirate
				{ 5,  233523 }, -- Triad Girdle
				{ 6,  233524 }, -- Angelista's Touch
				{ 8,  235045 }, -- Imperial Qiraji Regalia
				{ 9,  235046 }, -- Imperial Qiraji Armaments
				{ 12, 233568 }, -- Vest of Swift Execution
				{ 13, 233569 }, -- Ring of the Devoured
				{ 14, 233570 }, -- Petrified Scarab
				{ 15, 233571 }, -- Wand of Qiraji Nobility
				{ 17, 233562 }, -- Angelista's Charm
				{ 18, 233559 }, -- Gloves of Ebru
				{ 19, 233560 }, -- Ooze-ridden Gauntlets
				{ 20, 233561 }, -- Boots of the Fallen Hero
				{ 23, 233563 }, -- Mantle of Phrenic Power
				{ 24, 233566 }, -- Mantle of the Desert's Fury
				{ 25, 233567 }, -- Mantle of the Desert Crusade
				{ 26, 233564 }, -- Bile-Covered Gauntlets
				{ 27, 233565 }, -- Ukko's Ring of Darkness
			},
			[NORMAL_DIFF] = {
				{ 1,  21693 }, -- Guise of the Devourer
				{ 2,  21694 }, -- Ternary Mantle
				{ 3,  21697 }, -- Cape of the Trinity
				{ 4,  21696 }, -- Robes of the Triumvirate
				{ 5,  21692 }, -- Triad Girdle
				{ 6,  21695 }, -- Angelista's Touch
				{ 8,  21237 }, -- Imperial Qiraji Regalia
				{ 9,  21232 }, -- Imperial Qiraji Armaments
				{ 12, 21680 }, -- Vest of Swift Execution
				{ 13, 21681 }, -- Ring of the Devoured
				{ 14, 21685 }, -- Petrified Scarab
				{ 15, 21603 }, -- Wand of Qiraji Nobility
				{ 17, 21690 }, -- Angelista's Charm
				{ 18, 21689 }, -- Gloves of Ebru
				{ 19, 21691 }, -- Ooze-ridden Gauntlets
				{ 20, 21688 }, -- Boots of the Fallen Hero
				{ 23, 21686 }, -- Mantle of Phrenic Power
				{ 24, 21684 }, -- Mantle of the Desert's Fury
				{ 25, 21683 }, -- Mantle of the Desert Crusade
				{ 26, 21682 }, -- Bile-Covered Gauntlets
				{ 27, 21687 }, -- Ukko's Ring of Darkness
			},
		},
		{ -- AQ40Sartura
			name = AL["Battleguard Sartura"],
			npcID = 15516,
			Level = 999,
			DisplayIDs = {{15583}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1,  233578 }, -- Creeping Vine Helm
				{ 2,  233572 }, -- Necklace of Purity
				{ 3,  233575 }, -- Robes of the Battleguard
				{ 4,  233579 }, -- Gloves of Enforcement
				{ 5,  233582 }, -- Gauntlets of Steadfast Determination
				{ 6,  233577 }, -- Thick Qirajihide Belt
				{ 7,  233574 }, -- Leggings of the Festering Swarm
				{ 8,  233584 }, -- Scaled Leggings of Qiraji Fury
				{ 9,  233583 }, -- Legplates of Blazing Light
				{ 10, 233573 }, -- Recomposed Boots
				{ 11, 233580 }, -- Badge of the Swarmguard
				{ 12, 233581 }, -- Sartura's Might
				{ 13, 233576 }, -- Silithid Claw
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
			},
			[NORMAL_DIFF] = {
				{ 1,  21669 }, -- Creeping Vine Helm
				{ 2,  21678 }, -- Necklace of Purity
				{ 3,  21671 }, -- Robes of the Battleguard
				{ 4,  21672 }, -- Gloves of Enforcement
				{ 5,  21674 }, -- Gauntlets of Steadfast Determination
				{ 6,  21675 }, -- Thick Qirajihide Belt
				{ 7,  21676 }, -- Leggings of the Festering Swarm
				{ 8,  21668 }, -- Scaled Leggings of Qiraji Fury
				{ 9,  21667 }, -- Legplates of Blazing Light
				{ 10, 21648 }, -- Recomposed Boots
				{ 11, 21670 }, -- Badge of the Swarmguard
				{ 12, 21666 }, -- Sartura's Might
				{ 13, 21673 }, -- Silithid Claw
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
			},
		},
		{ -- AQ40Fankriss
			name = AL["Fankriss the Unyielding"],
			npcID = 15510,
			Level = 999,
			DisplayIDs = {{15743}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1,  233592 }, -- Mantle of Wicked Revenge
				{ 2,  233593 }, -- Pauldrons of the Unrelenting
				{ 3,  233588 }, -- Cloak of Untold Secrets
				{ 4,  233594 }, -- Robes of the Guardian Saint
				{ 5,  233591 }, -- Silithid Carapace Chestguard
				{ 6,  233595 }, -- Scaled Sand Reaver Leggings
				{ 7,  233590 }, -- Hive Tunneler's Boots
				{ 8,  233585 }, -- Ancient Qiraji Ripper
				{ 9,  233586 }, -- Barb of the Sand Reaver
				{ 11, 233587 }, -- Barbed Choker
				{ 12, 233589 }, -- Fetish of the Sand Reaver
				{ 13, 233596 }, -- Libram of Grace
				{ 14, 233597 }, -- Totem of Life
				{ 16, 233370 }, -- Qiraji Bindings of Command
				{ 17, 233369 }, -- Qiraji Bindings of Dominance
				{ 18, 233371 }, -- Qiraji Bindings of Sovereignty
				{ 20, 235045 }, -- Imperial Qiraji Regalia
				{ 21, 235046 }, -- Imperial Qiraji Armaments
			},
			[NORMAL_DIFF] = {
				{ 1,  21665 }, -- Mantle of Wicked Revenge
				{ 2,  21639 }, -- Pauldrons of the Unrelenting
				{ 3,  21627 }, -- Cloak of Untold Secrets
				{ 4,  21663 }, -- Robes of the Guardian Saint
				{ 5,  21652 }, -- Silithid Carapace Chestguard
				{ 6,  21651 }, -- Scaled Sand Reaver Leggings
				{ 7,  21645 }, -- Hive Tunneler's Boots
				{ 8,  21650 }, -- Ancient Qiraji Ripper
				{ 9,  21635 }, -- Barb of the Sand Reaver
				{ 11, 21664 }, -- Barbed Choker
				{ 12, 21647 }, -- Fetish of the Sand Reaver
				{ 13, 22402 }, -- Libram of Grace
				{ 14, 22396 }, -- Totem of Life
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
			},
		},
		{ -- AQ40Viscidus
			name = AL["Viscidus"],
			npcID = 15299,
			Level = 999,
			DisplayIDs = {{15686}},
			AtlasMapBossID = 5,
			[SOD_DIFF] = {
				{ 1,  233604 }, -- Gauntlets of Kalimdor
				{ 2,  233603 }, -- Gauntlets of the Righteous Champion
				{ 3,  233598 }, -- Slime-coated Leggings
				{ 4,  233599 }, -- Sharpened Silithid Femur
				{ 6,  233600 }, -- Ring of the Qiraji Fury
				{ 7,  233601 }, -- Scarab Brooch
				{ 8,  233602 }, -- Idol of Health
				{ 16, 233370 }, -- Qiraji Bindings of Command
				{ 17, 233369 }, -- Qiraji Bindings of Dominance
				{ 18, 233371 }, -- Qiraji Bindings of Sovereignty
				{ 20, 235045 }, -- Imperial Qiraji Regalia
				{ 21, 235046 }, -- Imperial Qiraji Armaments
			},
			[NORMAL_DIFF] = {
				{ 1,  21624 }, -- Gauntlets of Kalimdor
				{ 2,  21623 }, -- Gauntlets of the Righteous Champion
				{ 3,  21626 }, -- Slime-coated Leggings
				{ 4,  21622 }, -- Sharpened Silithid Femur
				{ 6,  21677 }, -- Ring of the Qiraji Fury
				{ 7,  21625 }, -- Scarab Brooch
				{ 8,  22399 }, -- Idol of Health
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 20928 }, -- Qiraji Bindings of Command
				{ 20, 20932 }, -- Qiraji Bindings of Dominance
			},
		},
		{ -- AQ40Huhuran
			name = AL["Princess Huhuran"],
			npcID = 15509,
			Level = 999,
			DisplayIDs = {{15739}},
			AtlasMapBossID = 6,
			[SOD_DIFF] = {
				{ 1,  233606 }, -- Cloak of the Golden Hive
				{ 2,  233610 }, -- Hive Defiler Wristguards
				{ 3,  233607 }, -- Gloves of the Messiah
				{ 4,  233608 }, -- Wasphide Gauntlets
				{ 5,  233609 }, -- Ring of the Martyr
				{ 6,  233605 }, -- Huhuran's Stinger
				{ 16, 233370 }, -- Qiraji Bindings of Command
				{ 17, 233369 }, -- Qiraji Bindings of Dominance
				{ 18, 233371 }, -- Qiraji Bindings of Sovereignty
				{ 20, 235045 }, -- Imperial Qiraji Regalia
				{ 21, 235046 }, -- Imperial Qiraji Armaments
			},
			[NORMAL_DIFF] = {
				{ 1,  21621 }, -- Cloak of the Golden Hive
				{ 2,  21618 }, -- Hive Defiler Wristguards
				{ 3,  21619 }, -- Gloves of the Messiah
				{ 4,  21617 }, -- Wasphide Gauntlets
				{ 5,  21620 }, -- Ring of the Martyr
				{ 6,  21616 }, -- Huhuran's Stinger
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 20928 }, -- Qiraji Bindings of Command
				{ 20, 20932 }, -- Qiraji Bindings of Dominance
			},
		},
		{ -- AQ40Emperors
			name = AL["Twin Emperors"],
			npcID = {15275, 15276},
			Level = 999,
			DisplayIDs = {{15761},{15778}},
			AtlasMapBossID = 7,
			[SOD_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Emperor Vek'lor"], nil },
				{ 2, 233365 }, -- Intact Viscera
				{ 3, 233367 }, -- Intact Peritoneum
				{ 4, 233368 }, -- Intact Entrails
				{ 5,  233612 }, -- Qiraji Execution Bracers
				{ 6,  233613 }, -- Vek'lor's Gloves of Devastation
				{ 7,  233614 }, -- Royal Qiraji Belt
				{ 8,  233611 }, -- Boots of Epiphany
				{ 9,  233615 }, -- Ring of Emperor Vek'lor
				{ 10,  233616 }, -- Royal Scepter of Vek'lor
				{ 11,  20735 }, -- Formula: Enchant Cloak - Subtlety
				{ 14, 235046 }, -- Imperial Qiraji Armaments
				{ 16, "INV_Box_01", nil, AL["Emperor Vek'nilash"], nil },
				{ 17, 233365 }, -- Intact Viscera
				{ 18, 233367 }, -- Intact Peritoneum
				{ 19, 233368 }, -- Intact Entrails
				{ 20, 233620 }, -- Amulet of Vek'nilash
				{ 21, 233617 }, -- Bracelets of Royal Redemption
				{ 22, 233618 }, -- Gloves of the Hidden Temple
				{ 23, 21609 }, -- Regenerating Belt of Vek'nilash
				{ 24, 233622 }, -- Grasp of the Fallen Emperor
				{ 25, 233623 }, -- Belt of the Fallen Emperor
				{ 26, 233621 }, -- Kalimdor's Revenge
				{ 27, 20726 }, -- Formula: Enchant Gloves - Threat
				{ 29, 235045 }, -- Imperial Qiraji Regalia
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Emperor Vek'lor"], nil },
				{ 2,  20930 }, -- Vek'lor's Diadem
				{ 3,  21602 }, -- Qiraji Execution Bracers
				{ 4,  21599 }, -- Vek'lor's Gloves of Devastation
				{ 5,  21598 }, -- Royal Qiraji Belt
				{ 6,  21600 }, -- Boots of Epiphany
				{ 7,  21601 }, -- Ring of Emperor Vek'lor
				{ 8,  21597 }, -- Royal Scepter of Vek'lor
				{ 9,  20735 }, -- Formula: Enchant Cloak - Subtlety
				{ 12, 21232 }, -- Imperial Qiraji Armaments
				{ 16, "INV_Box_01", nil, AL["Emperor Vek'nilash"], nil },
				{ 17, 20926 }, -- Vek'nilash's Circlet
				{ 18, 21608 }, -- Amulet of Vek'nilash
				{ 19, 21604 }, -- Bracelets of Royal Redemption
				{ 20, 21605 }, -- Gloves of the Hidden Temple
				{ 21, 21609 }, -- Regenerating Belt of Vek'nilash
				{ 22, 21607 }, -- Grasp of the Fallen Emperor
				{ 23, 21606 }, -- Belt of the Fallen Emperor
				{ 24, 21679 }, -- Kalimdor's Revenge
				{ 25, 20726 }, -- Formula: Enchant Gloves - Threat
				{ 27, 21237 }, -- Imperial Qiraji Regalia
			},
		},
		{ -- AQ40Ouro
			name = AL["Ouro"],
			npcID = 15517,
			Level = 999,
			DisplayIDs = {{15509}},
			AtlasMapBossID = 8,
			[SOD_DIFF] = {
				{ 1,  233624 }, -- Don Rigoberto's Lost Hat
				{ 2,  233625 }, -- Burrower Bracers
				{ 3,  233628 }, -- The Burrower's Shell
				{ 4,  233627 }, -- Jom Gabbar
				{ 5,  21610 }, -- Wormscale Blocker
				{ 6,  233626 }, -- Larvae of the Great Worm
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
				{ 19, 233365 }, -- Intact Viscera
				{ 20, 233367 }, -- Intact Peritoneum
				{ 21, 233368 }, -- Intact Entrails
			},
			[NORMAL_DIFF] = {
				{ 1,  21615 }, -- Don Rigoberto's Lost Hat
				{ 2,  21611 }, -- Burrower Bracers
				{ 3,  23558 }, -- The Burrower's Shell
				{ 4,  23570 }, -- Jom Gabbar
				{ 5,  21610 }, -- Wormscale Blocker
				{ 6,  23557 }, -- Larvae of the Great Worm
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 20927 }, -- Ouro's Intact Hide
				{ 20, 20931 }, -- Skin of the Great Sandworm
			},
		},
		{ -- AQ40CThun
			name = AL["C'Thun"],
			npcID = 15727,
			Level = 999,
			DisplayIDs = {{15787}},
			AtlasMapBossID = 9,
			[SOD_DIFF] = {
				{ 1,  233642 }, -- Mark of C'Thun
				{ 2,  233641 }, -- Cloak of Clarity
				{ 3,  233630 }, -- Cloak of the Devoured
				{ 4,  233633 }, -- Eyestalk Waist Cord
				{ 5,  233632 }, -- Grasp of the Old God
				{ 6,  233635 }, -- Belt of Never-ending Agony
				{ 7,  233631 }, -- Dark Storm Gauntlets
				{ 8,  233637 }, -- Gauntlets of Annihilation
				{ 9,  233638 }, -- Ring of the Godslayer
				{ 10, 233639 }, -- Vanquished Tentacle of C'Thun
				{ 11, 233636 }, -- Scepter of the False Prophet
				{ 12, 233634 }, -- Death's Sting
				{ 13, 233640 }, -- Dark Edge of Insanity
				{ 16, 233363 }, -- Carapace of the Old God
				{ 17, 233362 }, -- Husk of the Old God
				{ 18, 233364 }, -- Skin of the Old God
				{ 20, 21221 }, -- Eye of C'Thun
				{ 22, 22734 }, -- Base of Atiesh
				{ 24, "INV_Box_01", nil, AL["Hard Mode Mounts"], nil },
				{ 25, 233351 }, -- Light Green Qiraji Resonating Crystal
				{ 26, 233352 }, -- Dark Blue Qiraji Resonating Crystal
				{ 27, 233353 }, -- Light Blue Qiraji Resonating Crystal
				{ 28, 233356 }, -- Orange Qiraji Resonating Crystal
				{ 29, 233357 }, -- Twilight Qiraji Resonating Crystal
			},
			[NORMAL_DIFF] = {
				{ 1,  22732 }, -- Mark of C'Thun
				{ 2,  21583 }, -- Cloak of Clarity
				{ 3,  22731 }, -- Cloak of the Devoured
				{ 4,  22730 }, -- Eyestalk Waist Cord
				{ 5,  21582 }, -- Grasp of the Old God
				{ 6,  21586 }, -- Belt of Never-ending Agony
				{ 7,  21585 }, -- Dark Storm Gauntlets
				{ 8,  21581 }, -- Gauntlets of Annihilation
				{ 9,  21596 }, -- Ring of the Godslayer
				{ 10, 21579 }, -- Vanquished Tentacle of C'Thun
				{ 11, 21839 }, -- Scepter of the False Prophet
				{ 12, 21126 }, -- Death's Sting
				{ 13, 21134 }, -- Dark Edge of Insanity
				{ 16, 20929 }, -- Carapace of the Old God
				{ 17, 20933 }, -- Husk of the Old God
				{ 19, 21221 }, -- Eye of C'Thun
				{ 21, 22734 }, -- Base of Atiesh
			},
		},
		{ -- AQ40Trash1
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  233644 }, -- Garb of Royal Ascension
				{ 2,  233645 }, -- Gloves of the Immortal
				{ 3,  233646 }, -- Gloves of the Redeemed Prophecy
				{ 4,  233647 }, -- Neretzek, The Blood Drinker
				{ 5,  233643 }, -- Anubisath Warhammer
				{ 6,  233648 }, -- Ritssyn's Ring of Chaos
				{ 7,  233649 }, -- Shard of the Fallen Star
				{ 16, 21218 }, -- Blue Qiraji Resonating Crystal
				{ 17, 21324 }, -- Yellow Qiraji Resonating Crystal
				{ 18, 21323 }, -- Green Qiraji Resonating Crystal
				{ 19, 21321 }, -- Red Qiraji Resonating Crystal
			},
			[NORMAL_DIFF] = {
				{ 1,  21838 }, -- Garb of Royal Ascension
				{ 2,  21888 }, -- Gloves of the Immortal
				{ 3,  21889 }, -- Gloves of the Redeemed Prophecy
				{ 4,  21856 }, -- Neretzek, The Blood Drinker
				{ 5,  21837 }, -- Anubisath Warhammer
				{ 6,  21836 }, -- Ritssyn's Ring of Chaos
				{ 7,  21891 }, -- Shard of the Fallen Star
				{ 16, 21218 }, -- Blue Qiraji Resonating Crystal
				{ 17, 21324 }, -- Yellow Qiraji Resonating Crystal
				{ 18, 21323 }, -- Green Qiraji Resonating Crystal
				{ 19, 21321 }, -- Red Qiraji Resonating Crystal
			},
		},
		AQ_SCARABS,
		AQ_ENCHANTS,
		AQ_OPENING,
	},
}

data["Naxxramas"] = {
	MapID = 3456,
	InstanceID = AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM,533,nil),
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Naxxramas",
	AtlasMapFile = "CL_Naxxramas",
	AtlasMapFile_AL = "Naxxramas",
	ContentType = RAID_CONTENT,
	ContentPhase = 6,
	LevelRange = GetForVersion({60, 60, 60},{60, 60, 60}),
	items = {
		-- The Arachnid Quarter
		{ -- NAXAnubRekhan
			name = AL["Anub'Rekhan"],
			npcID = 15956,
			Level = 999,
			DisplayIDs = {{15931}},
			AtlasMapBossID = "1",
			NameColor = BLUE,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236247 }, -- Desecrated Wristguards
				{ 5,  236235 }, -- Desecrated Bracers
				{ 6,  236245 }, -- Desecrated Bindings
				{ 8,  236256 }, -- Touch of Frost
				{ 9,  236258 }, -- Cryptfiend Silk Cloak
				{ 10, 236255 }, -- Wristguards of Vengeance
				{ 11, 236259 }, -- Band of Unanswered Prayers
				{ 12, 236257 }, -- Gem of Nerubis
				{ 15, "INV_Box_01", nil, AL["*Boss Loot Unconfirmed*"], nil },
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22369 }, -- Desecrated Bindings
				{ 5,  22362 }, -- Desecrated Wristguards
				{ 6,  22355 }, -- Desecrated Bracers
				{ 8,  22935 }, -- Touch of Frost
				{ 9,  22938 }, -- Cryptfiend Silk Cloak
				{ 10, 22936 }, -- Wristguards of Vengeance
				{ 11, 22939 }, -- Band of Unanswered Prayers
				{ 12, 22937 }, -- Gem of Nerubis
			},
		},
		{ -- NAXGrandWidowFaerlina
			name = AL["Grand Widow Faerlina"],
			npcID = 15953,
			Level = 999,
			DisplayIDs = {{15940}},
			AtlasMapBossID = "2",
			NameColor = BLUE,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236247 }, -- Desecrated Wristguards
				{ 5,  236235 }, -- Desecrated Bracers
				{ 6,  236245 }, -- Desecrated Bindings
				{ 8,  236261 }, -- Malice Stone Pendant
				{ 9,  236262 }, -- Polar Shoulder Pads
				{ 10, 236260 }, -- Icebane Pauldrons
				{ 11, 236264 }, -- The Widow's Embrace
				{ 12, 236263 }, -- Widow's Remorse
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22369 }, -- Desecrated Bindings
				{ 5,  22362 }, -- Desecrated Wristguards
				{ 6,  22355 }, -- Desecrated Bracers
				{ 8,  22943 }, -- Malice Stone Pendant
				{ 9,  22941 }, -- Polar Shoulder Pads
				{ 10, 22940 }, -- Icebane Pauldrons
				{ 11, 22942 }, -- The Widow's Embrace
				{ 12, 22806 }, -- Widow's Remorse
			},
		},
		{ -- NAXMaexxna
			name = AL["Maexxna"],
			npcID = 15952,
			Level = 999,
			DisplayIDs = {{15928}},
			AtlasMapBossID = "3",
			NameColor = BLUE,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236243 }, -- Desecrated Gloves
				{ 5,  236250 }, -- Desecrated Handguards
				{ 6,  236233 }, -- Desecrated Gauntlets
				{ 8,  236266 }, -- Pendant of Forgotten Names
				{ 9,  236267 }, -- Crystal Webbed Robe
				{ 10, 236268 }, -- Kiss of the Spider
				{ 11, 236265 }, -- Wraith Blade
				{ 12, 236269 }, -- Maexxna's Fang
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22371 }, -- Desecrated Gloves
				{ 5,  22364 }, -- Desecrated Handguards
				{ 6,  22357 }, -- Desecrated Gauntlets
				{ 8,  22947 }, -- Pendant of Forgotten Names
				{ 9,  23220 }, -- Crystal Webbed Robe
				{ 10, 22954 }, -- Kiss of the Spider
				{ 11, 22807 }, -- Wraith Blade
				{ 12, 22804 }, -- Maexxna's Fang
			},
		},
		-- The Plague Quarter
		{ -- NAXNoththePlaguebringer
			name = AL["Noth the Plaguebringer"],
			npcID = 15954,
			Level = 999,
			DisplayIDs = {{16590}},
			AtlasMapBossID = "1",
			NameColor = PURP,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236244 }, -- Desecrated Belt
				{ 5,  236252 }, -- Desecrated Girdle
				{ 6,  236232 }, -- Desecrated Waistguard
				{ 8,  236272 }, -- Cloak of the Scourge
				{ 9,  236273 }, -- Band of the Inevitable
				{ 10, 236274 }, -- Hailstone Band
				{ 11, 236275 }, -- Noth's Frigid Heart
				{ 12, 236271 }, -- Libram of Light
				{ 13, 236276 }, -- Totem of Flowing Water
				{ 14, 236270 }, -- Hatchet of Sundered Bone
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22370 }, -- Desecrated Belt
				{ 5,  22363 }, -- Desecrated Girdle
				{ 6,  22356 }, -- Desecrated Waistguard
				{ 8,  23030 }, -- Cloak of the Scourge
				{ 9,  23031 }, -- Band of the Inevitable
				{ 10, 23028 }, -- Hailstone Band
				{ 11, 23029 }, -- Noth's Frigid Heart
				{ 12, 23006 }, -- Libram of Light
				{ 13, 23005 }, -- Totem of Flowing Water
				{ 14, 22816 }, -- Hatchet of Sundered Bone
			},
		},
		{ -- NAXHeigantheUnclean
			name = AL["Heigan the Unclean"],
			npcID = 15936,
			Level = 999,
			DisplayIDs = {{16309}},
			AtlasMapBossID = "2",
			NameColor = PURP,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236244 }, -- Desecrated Belt
				{ 5,  236252 }, -- Desecrated Girdle
				{ 6,  236232 }, -- Desecrated Waistguard
				{ 8,  236279 }, -- Preceptor's Hat
				{ 9,  236281 }, -- Icy Scale Coif
				{ 10, 237275 }, -- Icebane Helmet
				{ 11, 236277 }, -- Necklace of Necropsy
				{ 12, 236280 }, -- Legplates of Carnage
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22370 }, -- Desecrated Belt
				{ 5,  22363 }, -- Desecrated Girdle
				{ 6,  22356 }, -- Desecrated Waistguard
				{ 8,  23035 }, -- Preceptor's Hat
				{ 9,  23033 }, -- Icy Scale Coif
				{ 10, 23019 }, -- Icebane Helmet
				{ 11, 23036 }, -- Necklace of Necropsy
				{ 12, 23068 }, -- Legplates of Carnage
			},
		},
		{ -- NAXLoatheb
			name = AL["Loatheb"],
			npcID = 16011,
			Level = 999,
			DisplayIDs = {{16110}},
			AtlasMapBossID = "3",
			NameColor = PURP,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236246 }, -- Desecrated Leggings
				{ 5,  236253 }, -- Desecrated Legguards
				{ 6,  236238 }, -- Desecrated Legplates
				{ 8,  236286 }, -- Band of Unnatural Forces
				{ 9,  236283 }, -- Ring of Spiritual Fervor
				{ 10, 236282 }, -- Loatheb's Reflection
				{ 11, 236285 }, -- The Eye of Nerub
				{ 12, 236284 }, -- Brimstone Staff
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22366 }, -- Desecrated Leggings
				{ 5,  22359 }, -- Desecrated Legguards
				{ 6,  22352 }, -- Desecrated Legplates
				{ 8,  23038 }, -- Band of Unnatural Forces
				{ 9,  23037 }, -- Ring of Spiritual Fervor
				{ 10, 23042 }, -- Loatheb's Reflection
				{ 11, 23039 }, -- The Eye of Nerub
				{ 12, 22800 }, -- Brimstone Staff
			},
		},
		-- The Military Quarter
		{ -- NAXInstructorRazuvious
			name = AL["Instructor Razuvious"],
			npcID = 16061,
			Level = 999,
			DisplayIDs = {{16582}},
			AtlasMapBossID = "1",
			NameColor = _RED,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236239 }, -- Desecrated Sandals
				{ 5,  236248 }, -- Desecrated Boots
				{ 6,  236234 }, -- Desecrated Sabatons
				{ 8,  236307 }, -- Veil of Eclipse
				{ 9,  236309}, -- Girdle of the Mentor
				{ 10, 236311 }, -- Signet of the Fallen Defender
				{ 11, 236308 }, -- Idol of Longevity
				{ 12, 236310 }, -- Wand of the Whispering Dead
				{ 13, 236312 }, -- Iblis, Blade of the Fallen Seraph
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22372 }, -- Desecrated Sandals
				{ 5,  22365 }, -- Desecrated Boots
				{ 6,  22358 }, -- Desecrated Sabatons
				{ 8,  23017 }, -- Veil of Eclipse
				{ 9,  23219 }, -- Girdle of the Mentor
				{ 10, 23018 }, -- Signet of the Fallen Defender
				{ 11, 23004 }, -- Idol of Longevity
				{ 12, 23009 }, -- Wand of the Whispering Dead
				{ 13, 23014 }, -- Iblis, Blade of the Fallen Seraph
			},
		},
		{ -- NAXGothiktheHarvester
			name = AL["Gothik the Harvester"],
			npcID = 16060,
			Level = 999,
			DisplayIDs = {{16279}},
			AtlasMapBossID = "2",
			NameColor = _RED,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236239 }, -- Desecrated Sandals
				{ 5,  236248 }, -- Desecrated Boots
				{ 6,  236234 }, -- Desecrated Sabatons
				{ 8,  236278 }, -- Glacial Headdress
				{ 9,  236315 }, -- Polar Helmet
				{ 10, 236316 }, -- Sadist's Collar
				{ 11, 236313 }, -- The Soul Harvester's Bindings
				{ 12, 236314 }, -- Boots of Displacement
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22372 }, -- Desecrated Sandals
				{ 5,  22365 }, -- Desecrated Boots
				{ 6,  22358 }, -- Desecrated Sabatons
				{ 8,  23032 }, -- Glacial Headdress
				{ 9,  23020 }, -- Polar Helmet
				{ 10, 23023 }, -- Sadist's Collar
				{ 11, 23021 }, -- The Soul Harvester's Bindings
				{ 12, 23073 }, -- Boots of Displacement
			},
		},
		{ -- NAXTheFourHorsemen
			name = AL["The Four Horsemen"],
			npcID = {16064, 16065, 16062, 16063},
			Level = 999,
			DisplayIDs = {{16155},{16153},{16139},{16154}},
			AtlasMapBossID = "3",
			NameColor = _RED,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236242 }, -- Desecrated Robe
				{ 5,  236251 }, -- Desecrated Tunic
				{ 6,  236231 }, -- Desecrated Breastplate
				{ 8,  236319 }, -- Leggings of Apocalypse
				{ 9,  236318 }, -- Seal of the Damned
				{ 10, 236320 }, -- Warmth of Forgiveness
				{ 11, 236322 }, -- Soulstring
				{ 12, 236321 }, -- Maul of the Redeemed Crusader
				{ 16, 237512 }, -- BOIBLADE

				{ 29, "INV_drink_15", nil, AL["GM WEAPON???"], nil },
				{ 30, 236317 }, -- Corrupted Ashbringer
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22351 }, -- Desecrated Robe
				{ 5,  22350 }, -- Desecrated Tunic
				{ 6,  22349 }, -- Desecrated Breastplate
				{ 8,  23071 }, -- Leggings of Apocalypse
				{ 9,  23025 }, -- Seal of the Damned
				{ 10, 23027 }, -- Warmth of Forgiveness
				{ 11, 22811 }, -- Soulstring
				{ 12, 22809 }, -- Maul of the Redeemed Crusader
				{ 13, 22691 }, -- Corrupted Ashbringer
			},
		},
		-- The Construct Quarter
		{ -- NAXPatchwerk
			name = AL["Patchwerk"],
			npcID = 16028,
			Level = 999,
			DisplayIDs = {{16174}},
			AtlasMapBossID = 1,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236240 }, -- Desecrated Shoulderpads
				{ 5,  236254 }, -- Desecrated Spaulders
				{ 6,  236237 }, -- Desecrated Pauldrons
				{ 8,  236289 }, -- Cloak of Suturing
				{ 9,  236291 }, -- Band of Reanimation
				{ 10, 236290}, -- Wand of Fates
				{ 11, 236288 }, -- The Plague Bearer
				{ 12, 236287 }, -- Severance
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22368 }, -- Desecrated Shoulderpads
				{ 5,  22361 }, -- Desecrated Spaulders
				{ 6,  22354 }, -- Desecrated Pauldrons
				{ 8,  22960 }, -- Cloak of Suturing
				{ 9,  22961 }, -- Band of Reanimation
				{ 10, 22820 }, -- Wand of Fates
				{ 11, 22818 }, -- The Plague Bearer
				{ 12, 22815 }, -- Severance
			},
		},
		{ -- NAXGrobbulus
			name = AL["Grobbulus"],
			npcID = 15931,
			Level = 999,
			DisplayIDs = {{16035}},
			AtlasMapBossID = 2,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236240 }, -- Desecrated Shoulderpads
				{ 5,  236254 }, -- Desecrated Spaulders
				{ 6,  236237 }, -- Desecrated Pauldrons
				{ 8,  236295 }, -- Glacial Mantle
				{ 9,  236294 }, -- Icy Scale Spaulders
				{ 10, 236293 }, -- Toxin Injector
				{ 11, 236292 }, -- Midnight Haze
				{ 12, 236297 }, -- The End of Dreams
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22368 }, -- Desecrated Shoulderpads
				{ 5,  22361 }, -- Desecrated Spaulders
				{ 6,  22354 }, -- Desecrated Pauldrons
				{ 8,  22968 }, -- Glacial Mantle
				{ 9,  22967 }, -- Icy Scale Spaulders
				{ 10, 22810 }, -- Toxin Injector
				{ 11, 22803 }, -- Midnight Haze
				{ 12, 22988 }, -- The End of Dreams
			},
		},
		{ -- NAXGluth
			name = AL["Gluth"],
			npcID = 15932,
			Level = 999,
			DisplayIDs = {{16064}},
			AtlasMapBossID = 3,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236298 }, -- Rime Covered Mantle
				{ 5,  236300 }, -- Gluth's Missing Collar
				{ 6,  236301 }, -- Digested Hand of Power
				{ 7,  236296 }, -- Death's Bargain
				{ 8,  236299 }, -- Claymore of Unholy Might
				{ 9,  237577 }, -- TUM
				{ 16,  236240 }, -- Desecrated Shoulderpads
				{ 17,  236245 }, -- Desecrated Bindings
				{ 18,  236244 }, -- Desecrated Belt
				{ 19,  236239 }, -- Desecrated Sandals
				{ 20,  236254 }, -- Desecrated Spaulders
				{ 21,  236247 }, -- Desecrated Wristguards
				{ 22,  236252 }, -- Desecrated Girdle
				{ 23,  236248 }, -- Desecrated Boots
				{ 24,  236237 }, -- Desecrated Pauldrons
				{ 25,  236235 }, -- Desecrated Bracers
				{ 26,  236232 }, -- Desecrated Waistguard
				{ 27,  236234 }, -- Desecrated Sabatons
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22983 }, -- Rime Covered Mantle
				{ 5,  22981 }, -- Gluth's Missing Collar
				{ 6,  22994 }, -- Digested Hand of Power
				{ 7,  23075 }, -- Death's Bargain
				{ 8,  22813 }, -- Claymore of Unholy Might
				{ 16, 22368 }, -- Desecrated Shoulderpads
				{ 17, 22369 }, -- Desecrated Bindings
				{ 18, 22370 }, -- Desecrated Belt
				{ 19, 22372 }, -- Desecrated Sandals
				{ 20, 22361 }, -- Desecrated Spaulders
				{ 21, 22362 }, -- Desecrated Wristguards
				{ 22, 22363 }, -- Desecrated Girdle
				{ 23, 22365 }, -- Desecrated Boots
				{ 24, 22354 }, -- Desecrated Pauldrons
				{ 25, 22355 }, -- Desecrated Bracers
				{ 26, 22356 }, -- Desecrated Waistguard
				{ 27, 22358 }, -- Desecrated Sabatons
			},
		},
		{ -- NAXThaddius
			name = AL["Thaddius"],
			npcID = 15928,
			Level = 999,
			DisplayIDs = {{16137}},
			AtlasMapBossID = 4,
			[SOD_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236241 }, -- Desecrated Circlet
				{ 5,  236249 }, -- Desecrated Headpiece
				{ 6,  236236 }, -- Desecrated Helmet
				{ 8,  236304 }, -- Plated Abomination Ribcage
				{ 9,  236303 }, -- Leggings of Polarity
				{ 10, 236302 }, -- Eye of Diminution
				{ 11, 236306 }, -- The Castigator
				{ 12, 236305 }, -- Spire of Twilight
			},
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22367 }, -- Desecrated Circlet
				{ 5,  22360 }, -- Desecrated Headpiece
				{ 6,  22353 }, -- Desecrated Helmet
				{ 8,  23000 }, -- Plated Abomination Ribcage
				{ 9,  23070 }, -- Leggings of Polarity
				{ 10, 23001 }, -- Eye of Diminution
				{ 11, 22808 }, -- The Castigator
				{ 12, 22801 }, -- Spire of Twilight
			},
		},
		-- Frostwyrm Lair
		{ -- NAXSapphiron
			name = AL["Sapphiron"],
			npcID = 15989,
			Level = 999,
			DisplayIDs = {{16033}},
			AtlasMapBossID = "1",
			NameColor = GREEN,
			[SOD_DIFF] = {
				{ 1,  236327 }, -- Cloak of the Necropolis
				{ 2,  236333 }, -- Shroud of Dominion
				{ 3,  236337 }, -- Glyph of Deflection
				{ 4,  236329 }, -- Eye of the Dead
				{ 5,  236334 }, -- Slayer's Crest
				{ 6,  236331 }, -- The Restrained Essence of Sapphiron
				{ 7,  236328 }, -- Sapphiron's Left Eye
				{ 8,  236330 }, -- Sapphiron's Right Eye
				{ 9,  236336 }, -- The Face of Death
				{ 10, 236338 }, -- Claw of the Frost Wyrm
				{ 16, 236325 }, -- Fortitude of the Scourge
				{ 17, 236326 }, -- Might of the Scourge
				{ 18, 236324 }, -- Power of the Scourge
				{ 19, 236323 }, -- Resilience of the Scourge
			},
			[NORMAL_DIFF] = {
				{ 1,  23050 }, -- Cloak of the Necropolis
				{ 2,  23045 }, -- Shroud of Dominion
				{ 3,  23040 }, -- Glyph of Deflection
				{ 4,  23047 }, -- Eye of the Dead
				{ 5,  23041 }, -- Slayer's Crest
				{ 6,  23046 }, -- The Restrained Essence of Sapphiron
				{ 7,  23049 }, -- Sapphiron's Left Eye
				{ 8,  23048 }, -- Sapphiron's Right Eye
				{ 9,  23043 }, -- The Face of Death
				{ 10, 23242 }, -- Claw of the Frost Wyrm
				{ 16, 23549 }, -- Fortitude of the Scourge
				{ 17, 23548 }, -- Might of the Scourge
				{ 18, 23545 }, -- Power of the Scourge
				{ 19, 23547 }, -- Resilience of the Scourge
			},
		},
		{ -- NAXKelThuzard
			name = AL["Kel'Thuzad"],
			npcID = 15990,
			Level = 999,
			DisplayIDs = {{15945}},
			AtlasMapBossID = "2",
			NameColor = GREEN,
			[SOD_DIFF] = {
				{ 1,  236345 }, -- Gem of Trapped Innocents
				{ 2,  236342 }, -- Stormrage's Talisman of Seething
				{ 3,  236344 }, -- Nerubian Slavemaker
				{ 4,  236349 }, -- Doomfinger
				{ 5,  236347 }, -- Shield of Condemnation
				{ 6,  236343 }, -- Kingsfall
				{ 7,  236348 }, -- Hammer of the Twisting Nether
				{ 8,  236339 }, -- Gressil, Dawn of Ruin
				{ 9,  236341 }, -- The Hungering Cold
				{ 10, 236340 }, -- Might of Menethil
				{ 11, 236346 }, -- Soulseeker
				{ 13, 236350 }, -- The Phylactery of Kel'Thuzad
				{ 15, 22733 }, -- Staff Head of Atiesh
				{ 16, 237381 }, -- Desecrated Ring
				{ 30, "INV_Box_01", nil, AL["Loot Not Yet Confirmed"], nil },
			},
			[NORMAL_DIFF] = {
				{ 1,  23057 }, -- Gem of Trapped Innocents
				{ 2,  23053 }, -- Stormrage's Talisman of Seething
				{ 3,  22812 }, -- Nerubian Slavemaker
				{ 4,  22821 }, -- Doomfinger
				{ 5,  22819 }, -- Shield of Condemnation
				{ 6,  22802 }, -- Kingsfall
				{ 7,  23056 }, -- Hammer of the Twisting Nether
				{ 8,  23054 }, -- Gressil, Dawn of Ruin
				{ 9,  23577 }, -- The Hungering Cold
				{ 10, 22798 }, -- Might of Menethil
				{ 11, 22799 }, -- Soulseeker
				{ 13, 22520 }, -- The Phylactery of Kel'Thuzad
				{ 16, 23061 }, -- Ring of Faith
				{ 17, 23062 }, -- Frostfire Ring
				{ 18, 23063 }, -- Plagueheart Ring
				{ 19, 23060 }, -- Bonescythe Ring
				{ 20, 23064 }, -- Ring of the Dreamwalker
				{ 21, 23067 }, -- Ring of the Cryptstalker
				{ 22, 23065 }, -- Ring of the Earthshatterer
				{ 23, 23066 }, -- Ring of Redemption
				{ 24, 23059 }, -- Ring of the Dreadnaught
				{ 26, 22733 }, -- Staff Head of Atiesh
			},
		},
		{ -- NAXTrash
			name = AL["Trash"],
			ExtraList = true,
			[SOD_DIFF] = {
				{ 1,  236226 }, -- Pauldrons of Elemental Fury
				{ 2,  236228 }, -- Spaulders of the Grand Crusader
				{ 3,  236220 }, -- Necro-Knight's Garb
				{ 4,  236222 }, -- Ghoul Skin Tunic
				{ 5,  236225 }, -- Girdle of Elemental Fury
				{ 6,  236227 }, -- Belt of the Grand Crusader
				{ 7,  236230 }, -- Leggings of Elemental Fury
				{ 8,  236229 }, -- Leggings of the Grand Crusader
				{ 9,  236223 }, -- Ring of the Eternal Flame
				{ 10, 236224 }, -- Stygian Buckler
				{ 11, 236219 }, -- Harbinger of Doom
				{ 12, 236221 }, -- Misplaced Servo Arm
				{ 16, 22376 }, -- Wartorn Cloth Scrap
				{ 17, 22373 }, -- Wartorn Leather Scrap
				{ 18, 22374 }, -- Wartorn Chain Scrap
				{ 19, 22375 }, -- Wartorn Plate Scrap
				{ 21, 237773 }, -- Word of Thawing
				{ 22, 236656 }, -- Frozen Rune
			},
			[NORMAL_DIFF] = {
				{ 1,  23664 }, -- Pauldrons of Elemental Fury
				{ 2,  23667 }, -- Spaulders of the Grand Crusader
				{ 3,  23069 }, -- Necro-Knight's Garb
				{ 4,  23226 }, -- Ghoul Skin Tunic
				{ 5,  23663 }, -- Girdle of Elemental Fury
				{ 6,  23666 }, -- Belt of the Grand Crusader
				{ 7,  23665 }, -- Leggings of Elemental Fury
				{ 8,  23668 }, -- Leggings of the Grand Crusader
				{ 9,  23237 }, -- Ring of the Eternal Flame
				{ 10, 23238 }, -- Stygian Buckler
				{ 11, 23044 }, -- Harbinger of Doom
				{ 12, 23221 }, -- Misplaced Servo Arm
				{ 16, 22376 }, -- Wartorn Cloth Scrap
				{ 17, 22373 }, -- Wartorn Leather Scrap
				{ 18, 22374 }, -- Wartorn Chain Scrap
				{ 19, 22375 }, -- Wartorn Plate Scrap
				{ 21, 23055 }, -- Word of Thawing
				{ 22, 22682 }, -- Frozen Rune
			},
		},
		T3_SET,
	},
}
