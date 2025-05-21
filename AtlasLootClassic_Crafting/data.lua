-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local RAID_CLASS_COLORS = _G["RAID_CLASS_COLORS"]

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CLASSIC_VERSION_NUM)

local GetColorSkill = AtlasLoot.Data.Profession.GetColorSkillRankNoSpell

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local LEATHER_DIFF = data:AddDifficulty(ALIL["Leather"], "leather", 0)
local MAIL_DIFF = data:AddDifficulty(ALIL["Mail"], "mail", 0)
local PLATE_DIFF = data:AddDifficulty(ALIL["Plate"], "plate", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PROF_CONTENT = data:AddContentType(ALIL["Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_GATH_CONTENT = data:AddContentType(ALIL["Gathering Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_SEC_CONTENT = data:AddContentType(AL["Secondary Professions"], ATLASLOOT_SECPROFESSION_COLOR)
local PROF_CLASS_CONTENT = data:AddContentType(AL["Class Professions"], ATLASLOOT_CLASSPROFESSION_COLOR)
--local RAID20_CONTENT = data:AddContentType(AL["20 Raids"], ATLASLOOT_RAID20_COLOR)
--local RAID40_CONTENT = data:AddContentType(AL["40 Raids"], ATLASLOOT_RAID40_COLOR)

data["Alchemy"] = {
	name = ALIL["Alchemy"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ALCHEMY_LINK,
	items = {
		{
			name = AL["SoD Phase 1-8"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Phase 1"], nil },
				{ 2, 426607 }, --Elixir of Coalesced Regret
				{ 4, "INV_Box_01", nil, AL["Phase 2"], nil },
				{ 5, 435969 }, --Insulating Gniodine
				{ 6, 435971 }, --Mildly Irradiated Rejuvenation Potion
				{ 7, 439960 }, --Recipe: Lesser Arcane Elixir
				{ 9, "INV_Box_01", nil, AL["Phase 3"], nil },
				{ 10, 448085 }, --Flask of Restless Dreams
				{ 11, 446226 }, --Flask of Everlasting Nightmares
				{ 12, 446851 }, --Flask of Nightmarish Mojo
				{ 14, "INV_Box_01", nil, AL["Phase 5"], nil },
				{ 15, 471400 }, -- Magnificent Trollshine
				{ 16, "INV_Box_01", nil, AL["Phase 6"], nil },
				{ 17, 1213571 }, -- Elixir of Alacrity
				{ 18, 1213559 }, -- Elixir of the Honey Badger
				{ 19, 1213563 }, -- Elixir of the Mage-Lord
				{ 20, 1213565 }, -- Elixir of the Ironside
				{ 21, 1213546 }, -- Flask of Ancient Knowledge
				{ 22, 1213552 }, -- Flask of Madness
				{ 23, 1213548 }, -- Flask of the Old Gods
				{ 24, 1213544 }, -- Flask of Unyielding Sorrow
				{ 26, "INV_Box_01", nil, AL["Phase 8"], nil },
				{ 27, 17579 }, -- Flask of Unyielding Sorrow
				{ 28, 1231583 }, -- Major Discolored Healing Potion
			},
		},
		{
			name = AL["Flasks"],
			[NORMAL_DIFF] = {
				{ 1, 17635 }, --Flask of the Titans
				{ 2, 17636 }, --Flask of Distilled Wisdom
				{ 3, 17637 }, --Flask of Supreme Power
				{ 4, 17638 }, --Flask of Chromatic Resistance
				{ 16, 17634 }, --Flask of Petrification
			},
		},
		{
			name = AL["Transmutes"],
			[NORMAL_DIFF] = {
				{ 1, 17560 }, --Transmute: Fire to Earth
				{ 2, 17565 }, --Transmute: Life to Earth
				{ 4, 17561 }, --Transmute: Earth to Water
				{ 5, 17563 }, --Transmute: Undeath to Water
				{ 7, 17562 }, --Transmute: Water to Air
				{ 9, 17564 }, --Transmute: Water to Undeath
				{ 11, 17566 }, --Transmute: Earth to Life
				{ 13, 17559 }, --Transmute: Air to Fire
				{ 16, 17187 }, --Transmute: Arcanite
				{ 17, 11479 }, --Transmute: Iron to Gold
				{ 18, 11480 }, --Transmute: Mithril to Truesilver
				{ 20, 25146 }, --Transmute: Elemental Fire
			},
		},
		{
			name = AL["Healing/Mana Potions"],
			[NORMAL_DIFF] = {
				{ 1, 17556 }, --Major Healing Potion
				{ 2, 11457 }, --Superior Healing Potion
				{ 3, 7181 }, --Greater Healing Potion
				{ 4, 3447 }, --Healing Potion
				{ 5, 2337 }, --Lesser Healing Potion
				{ 6, 2330 }, --Minor Healing Potion
				{ 8, 2332 }, --Minor Rejuvenation Potion
				{ 10, 24366 }, --Greater Dreamless Sleep Potion
				{ 12, 11458 }, --Wildvine Potion
				{ 13, 4508 }, --Discolored Healing Potion
				{ 16, 17580 }, --Major Mana Potion
				{ 17, 17553 }, --Superior Mana Potion
				{ 18, 11448 }, --Greater Mana Potion
				{ 19, 3452 }, --Mana Potion
				{ 20, 3173 }, --Lesser Mana Potion
				{ 21, 2331 }, --Minor Mana Potion
				{ 23, 22732 }, --Major Rejuvenation Potion
				{ 25, 15833 }, --Dreamless Sleep Potion
				{ 27, 24365 }, --Mageblood Potion
			},
		},
		{
			name = AL["Protection Potions"],
			[NORMAL_DIFF] = {
				{ 1, 17574 }, --Greater Fire Protection Potion
				{ 2, 17576 }, --Greater Nature Protection Potion
				{ 3, 17575 }, --Greater Frost Protection Potion
				{ 4, 17578 }, --Greater Shadow Protection Potion
				{ 5, 17577 }, --Greater Arcane Protection Potion
				{ 7, 11453 }, --Magic Resistance Potion
				{ 8, 3174 }, --Elixir of Poison Resistance
				{ 16, 7257 }, --Fire Protection Potion
				{ 17, 7259 }, --Nature Protection Potion
				{ 18, 7258 }, --Frost Protection Potion
				{ 19, 7256 }, --Shadow Protection Potion
				{ 20, 7255 }, --Holy Protection Potion
				{ 22, 3172 }, --Minor Magic Resistance Potion
			},
		},
		{
			name = AL["Util Potions"],
			[NORMAL_DIFF] = {
				{ 1, 11464 }, --Invisibility Potion
				{ 2, 2335 }, --Swiftness Potion
				{ 3, 6624 }, --Free Action Potion
				{ 4, 3175 }, --Limited Invulnerability Potion
				{ 5, 24367 }, --Living Action Potion
				{ 6, 7841 }, --Swim Speed Potion
				{ 8, 17572 }, --Purification Potion
				{ 10, 17552 }, --Mighty Rage Potion
				{ 11, 6618 }, --Great Rage Potion
				{ 12, 6617 }, --Rage Potion
				{ 16, 3448 }, --Lesser Invisibility Potion
				{ 23, 11452 }, --Restorative Potion
				{ 25, 17570 }, --Greater Stoneshield Potion
				{ 26, 4942 }, --Lesser Stoneshield Potion
			},
		},
		{
			name = AL["Stat Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 24368 }, --Mighty Troll
				{ 2, 3451 }, --Major Troll
				{ 3, 3176 }, --Strong Troll
				{ 4, 3170 }, --Weak Troll
				{ 6, 17554 }, --Elixir of Superior Defense
				{ 7, 11450 }, --Elixir of Greater Defense
				{ 8, 3177 }, --Elixir of Defense
				{ 9, 7183 }, --Elixir of Minor Defense
				{ 11, 11472 }, --Elixir of Giants
				{ 12, 3188 }, --Elixir of Ogre
				{ 13, 2329 }, --Elixir of Lion
				{ 16, 11467 }, --Elixir of Greater Agility
				{ 17, 11449 }, --Elixir of Agility
				{ 18, 2333 }, --Elixir of Lesser Agility
				{ 19, 3230 }, --Elixir of Minor Agility
				{ 21, 11465 }, --Elixir of Greater Intellect
				{ 22, 3171 }, --Elixir of Wisdom
				{ 24, 17573 }, --Greater Arcane Elixir
				{ 25, 11461 }, --Arcane Elixir
			},
		},
		{
			name = AL["Special Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 26277 }, --Elixir of Greater Firepower
				{ 2, 17555 }, --Elixir of the Sages
				{ 5, 3450 }, --Elixir of Fortitude
				{ 7, 17557 }, --Elixir of Brute Force
				{ 8, 17571 }, --Elixir of the Mongoose
				{ 10, 11477 }, --Elixir of Demonslaying
				{ 16, 7845 }, --Elixir of Firepower
				{ 17, 21923 }, --Elixir of Frost Power
				{ 18, 11476 }, --Elixir of Shadow Power
				{ 20, 2334 }, --Elixir of Minor Fortitude
				{ 22, 8240 }, --Elixir of Giant Growth
			},
		},
		{
			name = AL["Misc Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 11478 }, --Elixir of Detect Demon
				{ 2, 12609 }, --Catseye Elixir
				{ 4, 22808 }, --Elixir of Greater Water Breathing
				{ 6, 11468 }, --Elixir of Dream Vision

				{ 16, 11460 }, --Elixir of Detect Undead
				{ 17, 3453 }, --Elixir of Detect Lesser Invisibility
				{ 19, 7179 }, --Elixir of Water Breathing
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 17632 }, --Alchemist's Stone
				{ 3, 11473 }, --Ghost Dye
				{ 5, 24266 }, --Gurubashi Mojo Madness
				{ 7, 11466 }, --Gift of Arthas
				{ 8, 3449 }, --Shadow Oil
				{ 9, 3454 }, --Frost Oil
				{ 10, 11451 }, --Oil of Immolation
				{ 16, 11459 }, --Philosophers' Stone
				{ 18, 11456 }, --Goblin Rocket Fuel
				{ 23, 7836 }, --Blackmouth Oil
				{ 24, 7837 }, --Fire Oil
				{ 25, 17551 }, --Stonescale Oil
			},
		},
	},
}

data["Blacksmithing"] = {
	name = ALIL["Blacksmithing"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.BLACKSMITHING_LINK,
	items = {
			{
			name = AL["SoD Phase 8"],
			[NORMAL_DIFF] = {
			{ 1, 1224631 }, -- Scarlet Soldier's Helmet
			{ 2, 1224632 }, -- Scarlet Soldier's Spaulders
			{ 3, 1224633 }, -- Scarlet Soldier's Chestplate
			{ 4, 1224635 }, -- Scarlet Soldier's Protectors
			{ 5, 1224636 }, -- Scarlet Soldier's Grips
			{ 6, 1224637 }, -- Scarlet Soldier's Waistguard
			{ 7, 1224638 }, -- Scarlet Soldier's Legplates
			{ 8, 1224639 }, -- Scarlet Soldier's Stompers
			}
		},
			{
			name = AL["SoD Phase 6"],
			[NORMAL_DIFF] = {
			{ 1, 1213746 }, -- Heavy Obsidian Belt
			{ 2, 1213709 }, -- Ironvine Belt
			{ 3, 1213711 }, -- Ironvine Gloves
			{ 4, 1213715 }, -- Ironvine Breastplate
			{ 5, 1213748 }, -- Light Obsidian Belt
			{ 6, 1214274 }, -- Obsidian Mail Tunic
			{ 7, 1213481 }, -- Razorspike Headcage
			{ 8, 1213484 }, -- Razorspike Shoulderplate
			{ 9, 1213490 }, -- Razorspike Battleplate
			{ 10, 1214309 }, -- Dreamscale Visor
			{ 11, 1215507 }, -- Thick Obsidian Breastplate
			{ 12, 1214257 }, -- Black Grasp of the Destroyer
			{ 14, 1214270 }, -- Jagged Obsidian Shield
			{ 16, 1213498 }, -- Obsidian Champion
			{ 17, 1213506 }, -- Obsidian Defender
			{ 18, 1213500 }, -- Obsidian Destroyer
			{ 19, 1214137 }, -- Obsidian Heartseeker
			{ 20, 1213492 }, -- Obsidian Reaver
			{ 21, 1213504 }, -- Obsidian Sageblade
			{ 22, 1213502 }, -- Obsidian Stormhammer
			{ 25, 1213643 }, -- Obsidian Grinding Stone
			}
		},
			{
			name = AL["SoD Phase 4"],
			[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Phase 4"], nil },
			{ 2, "INV_Box_01", nil, AL["Armor"], nil },
			{ 3, 461737 }, -- Tempest Gauntlets
			{ 4, 461739 }, -- Warcrest of the Great Chief
			{ 5, 461735 }, -- Invincible Mail
			{ 6, 461671 }, -- Stronger-hold Gauntlets
			{ 7, 461667 }, -- Tempered Dark Iron Plate 227871
			--{ 7, }, -- Argent Elite Shoulders
			--{ 8,  }, -- Shimmering Dawnbringer Shoulders
			--{ 9,  }, -- Radiant Gloves of the Dawn
			--{ 10,  }, -- Radiant Girdle of the Dawn
			--{ 11,  }, -- Dense Timbermaw Boots
			--{ 12,  }, -- Dense Timbermaw Belt
			--{ 16, }, -- Tempered Dark Iron Leggings 227836
			--{ 17, }, -- Tempered Dark Iron Boots
			--{ 18, }, -- Tempered Dark Iron Gauntlets
			--{ 19, }, -- Molten Chain Shoulders 227834
			--{ 20, }, -- Molten Chain Girdle 227827
			--{ 21, }, -- Tempered Dark Iron Helm 227824
			--{ 22, }, -- Tempered Dark Iron Bracers 227820
			{ 16, "INV_Box_01", nil, AL["Weapons"], nil },
			{ 17, 461716 }, -- Deadly Heartseeker
			{ 18, 461733 }, -- Finely-Enchanted Battlehammer
			{ 19, 461718 }, -- Tranquility
			{ 20, 461712 }, -- Refined Hammer of the Titans
			{ 21, 461714 }, -- Desecration
			{ 22, 461730 }, -- Hardened Frostguard
			{ 23, 461743 }, -- Sageblade of the Archmagus
			{ 24, 461675 }, -- Refined Arcanite Reaper
			{ 25, 460460 }, -- Sulfuron Hammer
			{ 26, 461647 }, -- Skyrider's Masterwork Stormhammer
			{ 27, 461669 }, -- Refined Arcanite Champion 
			--{ 107, }, --Hammer of the Wild Gods 227858
			--{ 108, }, -- Ebon Fist 227842
			--{ 109, }, -- Implacable Blackguard 227840
			--{ 110, }, -- Tempered Black Amnesty 227832
			--{ 111, }, -- Dark Iron Flame Reaver 227826
			--{ 112, }, -- Molten Dark Iron Destroyer 227825
			}
		},
			{
			name = AL["SoD Phase 1-3"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Phase 1"], nil },
				{ 2, 429348 }, --Shifting Silver Breastplate
				{ 3, 430397 }, --Blackfathom Sharpening Stone
				{ 4, 427063 }, --Mantle of the Second War
				{ 6, "INV_Box_01", nil, AL["Phase 2"], nil },
				{ 7, 435910 }, --Low-Background Truesilver Plates
				{ 8, 435906 }, --Reflective Truesilver Braincage
				{ 9, 435908 }, --Tempered Interference-Negating Helmet
				{ 11, "INV_Box_01", nil, AL["Phase 3"], nil },
				{ 12, 446179 }, --Shoulderplates of Dread
				{ 13, 446188 }, --Fearmonger's Shoulderguards
				{ 14, 446191 }, --Baleful Pauldrons
				{ 16, "INV_Box_01", nil, AL["Updated in SoD"], nil },
				{ 17, 439122 }, --Golden Scale Boots
				{ 18, 439126 }, --Golden Scale Coif
				{ 19, 439124 }, --Golden Scale Cuirass
				{ 20, 439120 }, --Golden Scale Gauntlets
				{ 21, 439132 }, --Golden Scale Leggings
				{ 22, 439130 }, --Golden Scale Shoulders
				{ 23, 439128 }, --Moonsteel Broadsword
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Daggers"],
			[NORMAL_DIFF] = {
				{ 1, 23638 }, --Black Amnesty / 66
				{ 2, 16995 }, --Heartseeker / 63
				{ 3, 10013 }, --Ebon Shiv / 51
				{ 4, 15973 }, --Searing Golden Blade / 39
				{ 5, 15972 }, --Glinting Steel Dagger / 36
				{ 6, 3295 }, --Deadly Bronze Poniard / 25
				{ 7, 6517 }, --Pearl-handled Dagger / 23
				{ 8, 3491 }, --Big Bronze Knife / 20
				{ 9, 8880 }, --Copper Dagger / 11
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
				{ 2, 20897 }, --Dark Iron Destroyer / 65
				{ 3, 16991 }, --Annihilator / 63
				{ 4, 16970 }, --Dawn / 55
				{ 5, 16969 }, --Ornate Thorium Handaxe / 55
				{ 6, 9995 }, --Blue Glittering Axe / 44
				{ 7, 9993 }, --Heavy Mithril Axe / 42
				{ 8, 21913 }, --Edge of Winter / 38
				{ 9, 2741 }, --Bronze Axe / 23
				{ 10, 3294 }, --Thick War Axe / 17
				{ 11, 2738 }, --Copper Axe / 9
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Axes"] },
				{ 17, 23653 }, --Nightfall / 70
				{ 18, 16994 }, --Arcanite Reaper / 63
				{ 19, 15294 }, --Dark Iron Sunderer / 57
				{ 20, 16971 }, --Huge Thorium Battleaxe / 56
				{ 21, 3500 }, --Shadow Crescent Axe / 40
				{ 22, 3498 }, --Massive Iron Axe / 37
				{ 23, 9987 }, --Bronze Battle Axe / 27
				{ 24, 3293 }, --Copper Battle Axe / 13
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
				{ 2, 23650 }, --Ebon Hand / 70
				{ 3, 16993 }, --Masterwork Stormhammer / 63
				{ 4, 27830 }, --Persuader / 63
				{ 5, 16984 }, --Volcanic Hammer / 58
				{ 6, 16983 }, --Serenity / 57
				{ 7, 10009 }, --Runed Mithril Hammer / 49
				{ 8, 10003 }, --The Shatterer / 47
				{ 9, 10001 }, --Big Black Mace / 46
				{ 10, 3297 }, --Mighty Iron Hammer / 30
				{ 11, 6518 }, --Iridescent Hammer / 28
				{ 12, 3296 }, --Heavy Bronze Mace / 25
				{ 13, 2740 }, --Bronze Mace / 22
				{ 14, 2737 }, --Copper Mace / 9
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Maces"] },
				{ 17, 21161 }, --Sulfuron Hammer / 67
				{ 18, 16988 }, --Hammer of the Titans / 63
				{ 19, 16973 }, --Enchanted Battlehammer / 56
				{ 20, 15292 }, --Dark Iron Pulverizer / 55
				{ 21, 3495 }, --Golden Iron Destroyer / 34
				{ 22, 3494 }, --Solid Iron Maul / 31
				{ 23, 9985 }, --Bronze Warhammer / 25
				{ 24, 7408 }, --Heavy Copper Maul / 16
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Swords"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Swords"] },
				{ 2, 23652 }, --Blackguard / 70
				{ 3, 20890 }, --Dark Iron Reaver / 65
				{ 4, 27832 }, --Sageblade / 64
				{ 5, 16992 }, --Frostguard / 63
				{ 6, 16978 }, --Blazing Rapier / 56
				{ 7, 10007 }, --Phantom Blade / 49
				{ 8, 10005 }, --Dazzling Mithril Rapier / 48
				{ 9, 9997 }, --Wicked Mithril Blade / 45
				{ 10, 3493 }, --Jade Serpentblade / 35
				{ 11, 3492 }, --Hardened Iron Shortsword / 32
				{ 12, 2742 }, --Bronze Shortsword / 24
				{ 13, 2739 }, --Copper Shortsword / 9
				{ 16, "INV_sword_06", nil, ALIL["Two-Handed Swords"] },
				{ 17, 16990 }, --Arcanite Champion / 63
				{ 18, 16985 }, --Corruption / 58
				{ 19, 10015 }, --Truesilver Champion / 52
				{ 20, 3497 }, --Frost Tiger Blade / 40
				{ 21, 3496 }, --Moonsteel Broadsword / 36
				{ 22, 9986 }, --Bronze Greatsword / 26
				{ 23, 3292 }, --Heavy Copper Broadsword / 19
				{ 24, 9983 }, --Copper Claymore / 11
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Polearms"],
			[NORMAL_DIFF] = {
				{ 1, 23639 }, --Blackfury / 66
				{ 2, 10011 }, --Blight / 50
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[MAIL_DIFF] = {
				{ 1, 16728 }, --Helm of the Great Chief / 61
				{ 2, 16659 }, --Radiant Circlet / 59
				{ 3, 9961 }, --Mithril Coif / 46
				{ 4, 3503 }, --Golden Scale Coif / 38
				{ 5, 9814 }, --Barbaric Iron Helm / 35
				{ 6, 3502 }, --Green Iron Helm / 34
			},
			[PLATE_DIFF] = {
				{ 1, 23636 }, --Dark Iron Helm / 66
				{ 2, 24913 }, --Darkrune Helm / 63
				{ 3, 16742 }, --Enchanted Thorium Helm / 62
				{ 4, 16729 }, --Lionheart Helm / 61
				{ 5, 16726 }, --Runic Plate Helm / 61
				{ 6, 16724 }, --Whitesoul Helm / 60
				{ 7, 16658 }, --Imperial Plate Helm / 59
				{ 8, 16653 }, --Thorium Helm / 56
				{ 9, 9980 }, --Ornate Mithril Helm / 49
				{ 10, 9970 }, --Heavy Mithril Helm / 47
				{ 11, 9935 }, --Steel Plate Helm / 43
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[MAIL_DIFF] = {
				{ 1, 24137 }, --Bloodsoul Shoulders / 65
				{ 2, 20873 }, --Fiery Chain Shoulders / 62
				{ 3, 9966 }, --Mithril Scale Shoulders / 47
				{ 4, 3505 }, --Golden Scale Shoulders / 35
				{ 5, 9811 }, --Barbaric Iron Shoulders / 32
				{ 6, 3504 }, --Green Iron Shoulders / 32
				{ 7, 3330 }, --Silvered Bronze Shoulders / 25
				{ 8, 3328 }, --Rough Bronze Shoulders / 22
			},
			[PLATE_DIFF] = {
				{ 1, 24141 }, --Darksoul Shoulders / 65
				{ 2, 16664 }, --Runic Plate Shoulders / 60
				{ 3, 15295 }, --Dark Iron Shoulders / 58
				{ 4, 16660 }, --Dawnbringer Shoulders / 58
				{ 5, 16646 }, --Imperial Plate Shoulders / 53
				{ 6, 9952 }, --Ornate Mithril Shoulder / 45
				{ 7, 9926 }, --Heavy Mithril Shoulder / 41
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[MAIL_DIFF] = {
				{ 1, 27590 }, --Obsidian Mail Tunic / 72
				{ 2, 24136 }, --Bloodsoul Breastplate / 65
				{ 3, 16746 }, --Invulnerable Mail / 63
				{ 4, 15293 }, --Dark Iron Mail / 56
				{ 5, 16650 }, --Wildthorn Mail / 54
				{ 6, 16648 }, --Radiant Breastplate / 54
				{ 7, 3511 }, --Golden Scale Cuirass / 40
				{ 8, 9916 }, --Steel Breastplate / 40
				{ 9, 3508 }, --Green Iron Hauberk / 36
				{ 10, 9813 }, --Barbaric Iron Breastplate / 32
				{ 11, 2675 }, --Shining Silver Breastplate / 29
				{ 12, 2673 }, --Silvered Bronze Breastplate / 26
				{ 13, 2670 }, --Rough Bronze Cuirass / 23
				{ 14, 8367 }, --Ironforge Breastplate / 20
				{ 15, 2667 }, --Runed Copper Breastplate / 18
				{ 16, 3321 }, --Copper Chain Vest / 10
				{ 17, 12260 }, --Rough Copper Vest / 7
			},
			[PLATE_DIFF] = {
				{ 1, 28242 }, --Icebane Breastplate / 80
				{ 2, 27587 }, --Thick Obsidian Breastplate / 72
				{ 3, 28461 }, --Ironvine Breastplate / 70
				{ 4, 24139 }, --Darksoul Breastplate / 65
				{ 5, 24914 }, --Darkrune Breastplate / 63
				{ 6, 16745 }, --Enchanted Thorium Breastplate / 63
				{ 7, 16731 }, --Runic Breastplate / 62
				{ 8, 16663 }, --Imperial Plate Chest / 60
				{ 9, 15296 }, --Dark Iron Plate / 59
				{ 10, 16667 }, --Demon Forged Breastplate / 57
				{ 11, 16642 }, --Thorium Armor / 50
				{ 12, 9974 }, --Truesilver Breastplate / 49
				{ 13, 9972 }, --Ornate Mithril Breastplate / 48
				{ 14, 9959 }, --Heavy Mithril Breastplate / 46
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[MAIL_DIFF] = {
				{ 1, 23629 }, --Heavy Timbermaw Boots / 64
				{ 2, 16656 }, --Radiant Boots / 58
				{ 3, 3515 }, --Golden Scale Boots / 40
				{ 4, 3513 }, --Polished Steel Boots / 37
				{ 5, 9818 }, --Barbaric Iron Boots / 36
				{ 6, 3334 }, --Green Iron Boots / 29
				{ 7, 3331 }, --Silvered Bronze Boots / 26
				{ 8, 7817 }, --Rough Bronze Boots / 18
				{ 9, 3319 }, --Copper Chain Boots / 9
			},
			[PLATE_DIFF] = {
				{ 1, 24399 }, --Dark Iron Boots / 70
				{ 2, 16657 }, --Imperial Plate Boots / 59
				{ 3, 16652 }, --Thorium Boots / 56
				{ 4, 9979 }, --Ornate Mithril Boots / 49
				{ 5, 9968 }, --Heavy Mithril Boots / 47
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[MAIL_DIFF] = {
				{ 1, 27589 }, --Black Grasp of the Destroyer / 70
				{ 2, 24138 }, --Bloodsoul Gauntlets / 65
				{ 3, 16661 }, --Storm Gauntlets / 59
				{ 4, 16654 }, --Radiant Gloves / 57
				{ 5, 11643 }, --Golden Scale Gauntlets / 41
				{ 6, 9820 }, --Barbaric Iron Gloves / 37
				{ 7, 3336 }, --Green Iron Gauntlets / 30
				{ 8, 3333 }, --Silvered Bronze Gauntlets / 27
				{ 9, 3325 }, --Gemmed Copper Gauntlets / 15
				{ 10, 3323 }, --Runed Copper Gauntlets / 12
			},
			[PLATE_DIFF] = {
				{ 1, 28243 }, --Icebane Gauntlets / 80
				{ 2, 23637 }, --Dark Iron Gauntlets / 70
				{ 3, 28462 }, --Ironvine Gloves / 70
				{ 4, 23633 }, --Gloves of the Dawn / 64
				{ 5, 24912 }, --Darkrune Gauntlets / 63
				{ 6, 16741 }, --Stronghold Gauntlets / 62
				{ 7, 16655 }, --Fiery Plate Gauntlets / 58
				{ 8, 9954 }, --Truesilver Gauntlets / 45
				{ 9, 9950 }, --Ornate Mithril Gloves / 44
				{ 10, 9928 }, --Heavy Mithril Gauntlet / 41
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[MAIL_DIFF] = {
				{ 1, 16725 }, --Radiant Leggings / 61
				{ 2, 9931 }, --Mithril Scale Pants / 42
				{ 3, 9957 }, --Orcish War Leggings / 42
				{ 4, 3507 }, --Golden Scale Leggings / 34
				{ 5, 3506 }, --Green Iron Leggings / 31
				{ 6, 12259 }, --Silvered Bronze Leggings / 31
				{ 7, 2668 }, --Rough Bronze Leggings / 21
				{ 8, 3324 }, --Runed Copper Pants / 13
				{ 9, 2662 }, --Copper Chain Pants / 9
			},
			[PLATE_DIFF] = {
				{ 1, 24140 }, --Darksoul Leggings / 65
				{ 2, 16744 }, --Enchanted Thorium Leggings / 63
				{ 3, 16732 }, --Runic Plate Leggings / 62
				{ 4, 16730 }, --Imperial Plate Leggings / 61
				{ 5, 16662 }, --Thorium Leggings / 60
				{ 6, 20876 }, --Dark Iron Leggings / 60
				{ 7, 27829 }, --Titanic Leggings / 60
				{ 8, 9945 }, --Ornate Mithril Pants / 44
				{ 9, 9933 }, --Heavy Mithril Pants / 42
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[MAIL_DIFF] = {
				{ 1, 27588 }, --Light Obsidian Belt / 68
				{ 2, 20872 }, --Fiery Chain Girdle / 59
				{ 3, 23628 }, --Heavy Timbermaw Belt / 58
				{ 4, 16645 }, --Radiant Belt / 52
				{ 5, 2666 }, --Runed Copper Belt / 18
				{ 6, 2661 }, --Copper Chain Belt / 11
			},
			[PLATE_DIFF] = {
				{ 1, 28463 }, --Ironvine Belt / 70
				{ 2, 27585 }, --Heavy Obsidian Belt / 68
				{ 3, 23632 }, --Girdle of the Dawn / 58
				{ 4, 16647 }, --Imperial Plate Belt / 53
				{ 5, 16643 }, --Thorium Belt / 50
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[MAIL_DIFF] = {
				{ 1, 9937 }, --Mithril Scale Bracers / 43
				{ 2, 7223 }, --Golden Scale Bracers / 37
				{ 3, 3501 }, --Green Iron Bracers / 33
				{ 4, 2672 }, --Patterned Bronze Bracers / 25
				{ 5, 2664 }, --Runed Copper Bracers / 19
				{ 6, 2663 }, --Copper Bracers / 7
			},
			[PLATE_DIFF] = {
				{ 1, 28244 }, --Icebane Bracers / 80
				{ 2, 20874 }, --Dark Iron Bracers / 59
				{ 3, 16649 }, --Imperial Plate Bracers / 54
				{ 4, 16644 }, --Thorium Bracers / 51
			},
		},
		{
			name = ALIL["Shields"],
			[NORMAL_DIFF] = {
				{ 1, 27586 }, --Jagged Obsidian Shield / 70
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 9964 }, --Mithril Spurs / 43

				{ 3, 7224 }, --Steel Weapon Chain / 38
				{ 18, 7222 }, --Iron Counterweight / 33

				{ 5, 16651 }, --Thorium Shield Spike / 55
				{ 6, 9939 }, --Mithril Shield Spike / 43
				{ 20, 7221 }, --Iron Shield Spike / 30


				{ 8, 22757 }, --Elemental Sharpening Stone / 60
				{ 9, 16641 }, --Dense Sharpening Stone / 45
				{ 10, 9918 }, --Solid Sharpening Stone / 35
				{ 11, 2674 }, --Heavy Sharpening Stone / 25
				{ 12, 2665 }, --Coarse Sharpening Stone / 15
				{ 13, 2660 }, --Rough Sharpening Stone / 5

				{ 24, 16640 }, --Dense Weightstone / 45
				{ 25, 9921 }, --Solid Weightstone / 35
				{ 26, 3117 }, --Heavy Weightstone / 25
				{ 27, 3116 }, --Coarse Weightstone / 15
				{ 28, 3115 }, --Rough Weightstone / 5
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 20201 }, --Arcanite Rod / 55
				{ 2, 14380 }, --Truesilver Rod / 40
				{ 16, 14379 }, --Golden Rod / 30
				{ 17, 7818 }, --Silver Rod / 20
				{ 4, 19669 }, --Arcanite Skeleton Key / 55
				{ 5, 19668 }, --Truesilver Skeleton Key / 40
				{ 19, 19667 }, --Golden Skeleton Key / 30
				{ 20, 19666 }, --Silver Skeleton Key / 20
				{ 7, 11454 }, --Inlaid Mithril Cylinder / 42
				{ 22, 8768 }, --Iron Buckle / 30
				{ 9, 16639 }, --Dense Grinding Stone / 45
				{ 10, 9920 }, --Solid Grinding Stone / 35
				{ 11, 3337 }, --Heavy Grinding Stone / 25
				{ 24, 3326 }, --Coarse Grinding Stone / 20
				{ 25, 3320 }, --Rough Grinding Stone / 10
			},
		},
	}
}

data["Enchanting"] = {
	name = ALIL["Enchanting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENCHANTING_LINK,
	items = {
		{
			name = AL["SoD Phase 8"],
			[NORMAL_DIFF] = {
				{ 1, 1232172 }, -- Enchant 2H Weapon - Grand Inquisitor
				{ 2, 1231128 }, -- Enchant Weapon - Grand Crusader
				{ 3, 1231164 }, -- Enchant Weapon - Grand Sorcerer
				{ 4, 1231139 }, -- Enchant 2H Weapon - Grand Arcanist
			}
		},
		{
			name = AL["SoD Phase 7"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Karazhan Enchants"], nil },
				{ 2, 1219580 }, -- Enchant 2H Weapon - Spellblasting
				{ 3, 1220624 }, -- Enchant Bracer - Greater Spellpower
				{ 4, 1219587 }, -- Enchant Cloak - Agility
				{ 5, 1219586 }, -- Enchant Gloves - Superior Strength
				{ 6, 1220623 }, -- Enchant Shield - Critical Strike
				{ 7, 1219577 }, -- Enchant Off-Hand - Superior Intellect
				{ 8, 1219579 }, -- Enchant Off-Hand - Wisdom
				{ 9, 1219578 }, -- Enchant Off-Hand - Excellent Spirit
				{ 10, 1219581 }, -- Enchant Shield - Excellent Stamina
			}
		},
		{
			name = AL["SoD Phase 6"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Phase 6"], nil },
				{ 2, 1213593 }, -- Speedstone
				{ 3, 1213595 }, -- Tear of the Dreamer
				{ 4, 1213598 }, -- Lodestone of Retaliation
				{ 5, 1213600 }, -- Enchanted Stopwatch
				{ 6, 1213603 }, -- Ruby-Encrusted Broach
				{ 7, 1213628 }, -- Enchanted Prayer Tome
				{ 8, 1213633 }, -- Enchanted Totem
				{ 9, 1213635 }, -- Enchanted Mushroom
				{ 10, 1216005 }, -- Libram of Righteousness
				{ 11, 1216010 }, -- Libram of Sanctity
				{ 12, 1216007 }, -- Libram of the Exorcist
				{ 13, 1216018 }, -- Totem of Flowing Magma
				{ 14, 1216014 }, -- Totem of Pyroclastic Thunder
				{ 15, 1216016 }, -- Totem of Thunderous Strikes
				{ 16, 1216022 }, -- Idol of Feline Ferocity
				{ 17, 1216020 }, -- Idol of Sidereal Wrath
				{ 18, 1216024 }, -- Idol of Ursin Power
				{ 20, 1213610 }, -- Enchanted Repellent
				{ 21, 1213607 }, -- Scroll: Wrath of the Swarm
				{ 23, 1213616 }, -- Living Stats
				{ 24, 1213622 }, -- Enchant Gloves - Holy Power
				{ 25, 1213626 }, -- Enchant Gloves - Arcane Power
				{ 26, 1217189 }, -- Enchant Bracer - Spell Power
				{ 27, 1217203 }, -- Enchant Bracer - Agility
			}
		},
		{
			name = AL["SoD Phase 1-5"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Phase 1"], nil },
				{ 2, 430409 }, --Brilliant Mana Oil / 310
				{ 4, "INV_Box_01", nil, AL["Phase 2"], nil },
				{ 5, 435903 }, --Enchant Chest - Retricutioner
				{ 6, 435481 }, -- Enchant Weapon - Dismantle
				{ 7, 439156 }, -- Sigil of Innovation
				{ 9, "INV_Box_01", nil, AL["Phase 3"], nil },
				{ 10, 446243 }, -- Sigil of Living Dreams
				{ 11, 448624 }, -- Scroll of Spatial Mending
				{ 16, "INV_Box_01", nil, AL["Phase 4"], nil },
				{ 17, 463866 }, -- Sigil of Flowing Waters
				{ 18, 463869 }, -- Conductive Shield Coating
				{ 19, 463871 }, -- Law of Nature
				{ 21, "INV_Box_01", nil, AL["Updated in SoD"], nil },
				{ 22, 439134 }, -- Greater Mystic Wand
			}
		},
		{
			name = AL["Oil"],
			[NORMAL_DIFF] = {
				{ 1, 25130 }, --Brilliant Mana Oil / 310
				{ 2, 25129 }, --Brilliant Wizard Oil / 310
				{ 3, 25128 }, --Wizard Oil / 285
				{ 4, 25127 }, --Lesser Mana Oil / 260
				{ 5, 25126 }, --Lesser Wizard Oil / 210
				{ 6, 25125 }, --Minor Mana Oil / 160
				{ 7, 25124 }, --Minor Wizard Oil / 55
			}
		},
		{
			name = ALIL["Wands"],
			[NORMAL_DIFF] = {
				{ 1, 14810 }, --Greater Mystic Wand / 195
				{ 2, 14809 }, --Lesser Mystic Wand / 175
				{ 3, 14807 }, --Greater Magic Wand / 110
				{ 4, 14293 }, --Lesser Magic Wand / 75
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 20051 }, --Runed Arcanite Rod / 310
				{ 2, 13702 }, --Runed Truesilver Rod / 220
				{ 3, 13628 }, --Runed Golden Rod / 175
				{ 4, 7795 }, --Runed Silver Rod / 130
				{ 5, 7421 }, --Runed Copper Rod / 5
				{ 16, 15596 }, --Smoking Heart of the Mountain / 285
				{ 18, 17181 }, --Enchanted Leather / 250
				{ 20, 17180 }, --Enchanted Thorium / 250
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 23804 }, --Enchant Weapon - Mighty Intellect / 320
				{ 2, 20034 }, --Enchant Weapon - Crusader / 320
				{ 3, 20032 }, --Enchant Weapon - Lifestealing / 320
				{ 4, 22749 }, --Enchant Weapon - Spell Power / 320
				{ 5, 22750 }, --Enchant Weapon - Healing Power / 320
				{ 6, 23803 }, --Enchant Weapon - Mighty Spirit / 320
				{ 7, 20031 }, --Enchant Weapon - Superior Striking / 320
				{ 8, 20033 }, --Enchant Weapon - Unholy Weapon / 315
				{ 9, 23799 }, --Enchant Weapon - Strength / 310
				{ 10, 23800 }, --Enchant Weapon - Agility / 310
				{ 11, 20029 }, --Enchant Weapon - Icy Chill / 305
				{ 12, 13898 }, --Enchant Weapon - Fiery Weapon / 285
				{ 13, 13943 }, --Enchant Weapon - Greater Striking / 265
				{ 14, 13915 }, --Enchant Weapon - Demonslaying / 250
				{ 15, 13693 }, --Enchant Weapon - Striking / 215
				{ 16, 21931 }, --Enchant Weapon - Winter / 210
				{ 17, 13653 }, --Enchant Weapon - Lesser Beastslayer / 195
				{ 18, 13655 }, --Enchant Weapon - Lesser Elemental Slayer / 195
				{ 19, 13503 }, --Enchant Weapon - Lesser Striking / 165
				{ 20, 7788 }, --Enchant Weapon - Minor Striking / 120
				{ 21, 7786 }, --Enchant Weapon - Minor Beastslayer / 120
			}
		},
		{
			name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20035 }, --Enchant 2H Weapon - Major Spirit / 320
				{ 2, 20036 }, --Enchant 2H Weapon - Major Intellect / 320
				{ 3, 20030 }, --Enchant 2H Weapon - Superior Impact / 315
				{ 4, 27837 }, --Enchant 2H Weapon - Agility / 310
				{ 5, 13937 }, --Enchant 2H Weapon - Greater Impact / 260
				{ 6, 13695 }, --Enchant 2H Weapon - Impact / 220
				{ 7, 13529 }, --Enchant 2H Weapon - Lesser Impact / 170
				{ 8, 13380 }, --Enchant 2H Weapon - Lesser Spirit / 135
				{ 9, 7745 }, --Enchant 2H Weapon - Minor Impact / 130
				{ 10, 7793 }, --Enchant 2H Weapon - Lesser Intellect / 130
			}
		},
		{
			name = ALIL["Cloak"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 25086 }, --Enchant Cloak - Dodge / 320
				{ 2, 25081 }, --Enchant Cloak - Greater Fire Resistance / 320
				{ 3, 25082 }, --Enchant Cloak - Greater Nature Resistance / 320
				{ 4, 25084 }, --Enchant Cloak - Subtlety / 320
				{ 5, 25083 }, --Enchant Cloak - Stealth / 320
				{ 6, 20015 }, --Enchant Cloak - Superior Defense / 305
				{ 7, 20014 }, --Enchant Cloak - Greater Resistance / 285
				{ 8, 13882 }, --Enchant Cloak - Lesser Agility / 245
				{ 9, 13794 }, --Enchant Cloak - Resistance / 225
				{ 10, 13746 }, --Enchant Cloak - Greater Defense / 225
				{ 11, 13657 }, --Enchant Cloak - Fire Resistance / 195
				{ 12, 13635 }, --Enchant Cloak - Defense / 175
				{ 13, 13522 }, --Enchant Cloak - Lesser Shadow Resistance / 160
				{ 14, 7861 }, --Enchant Cloak - Lesser Fire Resistance / 150
				{ 15, 13421 }, --Enchant Cloak - Lesser Protection / 140
				{ 16, 13419 }, --Enchant Cloak - Minor Agility / 135
				{ 17, 7771 }, --Enchant Cloak - Minor Protection / 110
				{ 18, 7454 }, --Enchant Cloak - Minor Resistance / 95
			}
		},
		{
			name = ALIL["Chest"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20025 }, --Enchant Chest - Greater Stats / 320
				{ 2, 20028 }, --Enchant Chest - Major Mana / 310
				{ 3, 20026 }, --Enchant Chest - Major Health / 295
				{ 4, 13941 }, --Enchant Chest - Stats / 265
				{ 5, 13917 }, --Enchant Chest - Superior Mana / 250
				{ 6, 13858 }, --Enchant Chest - Superior Health / 240
				{ 7, 13700 }, --Enchant Chest - Lesser Stats / 220
				{ 8, 13663 }, --Enchant Chest - Greater Mana / 205
				{ 9, 13640 }, --Enchant Chest - Greater Health / 180
				{ 10, 13626 }, --Enchant Chest - Minor Stats / 175
				{ 11, 13607 }, --Enchant Chest - Mana / 170
				{ 12, 13538 }, --Enchant Chest - Lesser Absorption / 165
				{ 13, 7857 }, --Enchant Chest - Health / 145
				{ 14, 7776 }, --Enchant Chest - Lesser Mana / 115
				{ 15, 7748 }, --Enchant Chest - Lesser Health / 105
				{ 16, 7426 }, --Enchant Chest - Minor Absorption / 90
				{ 17, 7443 }, --Enchant Chest - Minor Mana / 80
				{ 18, 7420 }, --Enchant Chest - Minor Health / 70
			}
		},
		{
			name = ALIL["Feet"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20023 }, --Enchant Boots - Greater Agility / 315
				{ 2, 20024 }, --Enchant Boots - Spirit / 295
				{ 3, 20020 }, --Enchant Boots - Greater Stamina / 280
				{ 4, 13935 }, --Enchant Boots - Agility / 255
				{ 5, 13890 }, --Enchant Boots - Minor Speed / 245
				{ 6, 13836 }, --Enchant Boots - Stamina / 235
				{ 7, 13687 }, --Enchant Boots - Lesser Spirit / 210
				{ 8, 13644 }, --Enchant Boots - Lesser Stamina / 190
				{ 9, 13637 }, --Enchant Boots - Lesser Agility / 180
				{ 10, 7867 }, --Enchant Boots - Minor Agility / 150
				{ 11, 7863 }, --Enchant Boots - Minor Stamina / 150
			}
		},
		{
			name = ALIL["Hand"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 25080 }, --Enchant Gloves - Superior Agility / 320
				{ 2, 25073 }, --Enchant Gloves - Shadow Power / 320
				{ 3, 25074 }, --Enchant Gloves - Frost Power / 320
				{ 4, 25072 }, --Enchant Gloves - Threat / 320
				{ 5, 25079 }, --Enchant Gloves - Healing Power / 320
				{ 6, 25078 }, --Enchant Gloves - Fire Power / 320
				{ 7, 20013 }, --Enchant Gloves - Greater Strength / 315
				{ 8, 20012 }, --Enchant Gloves - Greater Agility / 290
				{ 9, 13948 }, --Enchant Gloves - Minor Haste / 270
				{ 10, 13947 }, --Enchant Gloves - Riding Skill / 270
				{ 11, 13868 }, --Enchant Gloves - Advanced Herbalism / 245
				{ 12, 13887 }, --Enchant Gloves - Strength / 245
				{ 13, 13841 }, --Enchant Gloves - Advanced Mining / 235
				{ 14, 13815 }, --Enchant Gloves - Agility / 230
				{ 15, 13698 }, --Enchant Gloves - Skinning / 220
				{ 16, 13617 }, --Enchant Gloves - Herbalism / 170
				{ 17, 13620 }, --Enchant Gloves - Fishing / 170
				{ 18, 13612 }, --Enchant Gloves - Mining / 170
			}
		},
		{
			name = ALIL["Shield"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20016 }, --Enchant Shield - Superior Spirit / 300
				{ 2, 20017 }, --Enchant Shield - Greater Stamina / 285
				{ 3, 13933 }, --Enchant Shield - Frost Resistance / 255
				{ 4, 13905 }, --Enchant Shield - Greater Spirit / 250
				{ 5, 13817 }, --Enchant Shield - Stamina / 230
				{ 6, 13689 }, --Enchant Shield - Lesser Block / 215
				{ 7, 13659 }, --Enchant Shield - Spirit / 200
				{ 8, 13631 }, --Enchant Shield - Lesser Stamina / 175
				{ 9, 13485 }, --Enchant Shield - Lesser Spirit / 155
				{ 10, 13464 }, --Enchant Shield - Lesser Protection / 140
				{ 11, 13378 }, --Enchant Shield - Minor Stamina / 130
			}
		},
		{
			name = ALIL["Wrist"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 23802 }, --Enchant Bracer - Healing Power / 320
				{ 2, 20011 }, --Enchant Bracer - Superior Stamina / 320
				{ 3, 20010 }, --Enchant Bracer - Superior Strength / 315
				{ 4, 23801 }, --Enchant Bracer - Mana Regeneration / 310
				{ 5, 20009 }, --Enchant Bracer - Superior Spirit / 290
				{ 6, 20008 }, --Enchant Bracer - Greater Intellect / 275
				{ 7, 13945 }, --Enchant Bracer - Greater Stamina / 265
				{ 8, 13939 }, --Enchant Bracer - Greater Strength / 260
				{ 9, 13931 }, --Enchant Bracer - Deflection / 255
				{ 10, 13846 }, --Enchant Bracer - Greater Spirit / 240
				{ 11, 13822 }, --Enchant Bracer - Intellect / 230
				{ 12, 13661 }, --Enchant Bracer - Strength / 200
				{ 13, 13648 }, --Enchant Bracer - Stamina / 190
				{ 14, 13646 }, --Enchant Bracer - Lesser Deflection / 190
				{ 15, 13642 }, --Enchant Bracer - Spirit / 185
				{ 16, 13622 }, --Enchant Bracer - Lesser Intellect / 175
				{ 17, 13536 }, --Enchant Bracer - Lesser Strength / 165
				{ 18, 13501 }, --Enchant Bracer - Lesser Stamina / 155
				{ 19, 7859 }, --Enchant Bracer - Lesser Spirit / 145
				{ 20, 7779 }, --Enchant Bracer - Minor Agility / 115
				{ 21, 7782 }, --Enchant Bracer - Minor Strength / 115
				{ 22, 7766 }, --Enchant Bracer - Minor Spirit / 105
				{ 23, 7457 }, --Enchant Bracer - Minor Stamina / 100
				{ 24, 7428 }, --Enchant Bracer - Minor Deflect / 80
				{ 25, 7418 }, --Enchant Bracer - Minor Health / 70
			}
		},
	}
}

data["Engineering"] = {
	name = ALIL["Engineering"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENGINEERING_LINK,
	items = {
			{
			name = AL["SoD Phase 8"],
			[NORMAL_DIFF] = {
				{ 1, 1226206 }, -- Tinkerbox
				{ 2, 1226207 }, -- Tinkerbox: Teleport
				{ 3, 1226208 }, -- Tinkerbox: Nitro Boosts
				{ 4, 1226209 }, -- Tinkerbox: Magnetic Displacement
				{ 6, 1228088 }, -- Pup-Up Shrub
				{ 7, 1226213 }, -- Semisafe Transporter: New Avalon
				{ 17, 1226210 }, -- Tinker: Teleport
				{ 18, 1226211 }, -- Tinker: Nitro Boosts
				{ 19, 1226212 }, -- Tinker: Magnetic Displacement
			}
		},
			{
			name = AL["SoD Phase 1-7"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Phase 1"], nil },
				{ 2, 424641 }, --Shredder Autosalvage Unit
				{ 4, "INV_Box_01", nil, AL["Phase 2"], nil },
				{ 5, 435956 }, --Polished Truesilver Gears
				{ 6, 431362 }, -- Soul Vessel
				{ 7, 435966 }, -- Ez-Thro Radiation Bomb 
				{ 8, 435964 }, -- High-Yield Radiation Bomb
				{ 9, 435960 }, -- Hyperconductive Goldwrap
				{ 10, 435958 }, -- Whirling Truesilver Gearwall
				{ 12, "INV_Box_01", nil, AL["Phase 3"], nil },
				{ 13, 446236 }, -- Void-Powered Invoker's Vambraces
				{ 14, 446238 }, -- Void-Powered Protector's Vambraces
				{ 15, 446237 }, -- Void-Powered Slayer's Vambraces
				{ 16, "INV_Box_01", nil, AL["Phase 4"], nil },
				{ 17, 461710 }, -- Fiery Core Sharpshooter Rifle
				{ 19, "INV_Box_01", nil, AL["Phase 6"], nil },
				{ 20, 1213573 }, -- Arcane Megabomb
				{ 21, 1213576 }, -- The Fumigator
				{ 22, 1213578 }, -- Obsidian Bomb
				{ 23, 1213646 }, -- Obsidian Blasting Powder
				{ 24, 1214145 }, -- Obsidian Shotgun
				{ 25, 1213588 }, -- Tuned Force Reactive Disk
				{ 26, 1217207 }, -- Obsidian Scope
				{ 27, 1213586 }, -- G00 DV-1B3 Generator
				{ 29, "INV_Box_01", nil, AL["Phase 7"], nil },
				{ 30, 1221012 }, -- Creepy Censor Sensors
			}
		},
		{
			name = AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 22797 }, --Force Reactive Disk / 65
				{ 3, 12903 }, --Gnomish Harm Prevention Belt / 43
				{ 5, 8895 }, --Goblin Rocket Boots / 45
				{ 16, 19819 }, --Voice Amplification Modulator / 58
				{ 18, 12616 }, --Parachute Cloak / 45
				{ 20, 12905 }, --Gnomish Rocket Boots / 45
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 24357 }, --Bloodvine Lens / 65
				{ 2, 24356 }, --Bloodvine Goggles / 65
				{ 3, 19825 }, --Master Engineer / 58
				{ 4, 19794 }, --Spellpower Goggles Xtreme Plus / 54
				{ 5, 12622 }, --Green Lens / 49
				{ 6, 12758 }, --Goblin Rocket Helmet / 47
				{ 7, 12907 }, --Gnomish Mind Control Cap / 47
				{ 8, 12618 }, --Rose Colored Goggles / 46
				{ 9, 12617 }, --Deepdive Helmet / 46
				{ 10, 12607 }, --Catseye Ultra Goggles / 44
				{ 11, 12615 }, --Spellpower Goggles Xtreme / 43
				{ 12, 12897 }, --Gnomish Goggles / 42
				{ 13, 12594 }, --Fire Goggles / 41
				{ 14, 12717 }, --Goblin Mining Helmet / 41
				{ 15, 12718 }, --Goblin Construction Helmet / 41
				{ 16, 3966 }, --Craftsman / 37
				{ 17, 12587 }, --Bright-Eye Goggles / 35
				{ 18, 3956 }, --Green Tinted Goggles / 30
				{ 19, 3940 }, --Shadow Goggles / 24
				{ 20, 3934 }, --Flying Tiger Goggles / 20
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 19830 }, --Arcanite Dragonling / 60
				{ 2, 23082 }, --Ultra-Flash Shadow Reflector / 60
				{ 3, 23081 }, --Hyper-Radiant Flame Reflector / 58
				{ 4, 23486 }, --Dimensional Ripper - Everlook / 55
				{ 5, 23079 }, --Major Recombobulator / 55
				{ 6, 23078 }, --Goblin Jumper Cables XL / 53
				{ 7, 23077 }, --Gyrofreeze Ice Reflector / 52
				{ 8, 23489 }, --Ultrasafe Transporter: Gadgetzan / 52
				{ 9, 12624 }, --Mithril Mechanical Dragonling / 50
				{ 10, 12908 }, --Goblin Dragon Gun / 48
				{ 11, 12759 }, --Gnomish Death Ray / 48
				{ 12, 12906 }, --Gnomish Battle Chicken / 46
				{ 13, 12755 }, --Goblin Bomb Dispenser / 46
				{ 14, 12902 }, --Gnomish Net-o-Matic Projector / 42
				{ 15, 12899 }, --Gnomish Shrink Ray / 41
				{ 16, 3969 }, --Mechanical Dragonling / 40
				{ 17, 3971 }, --Gnomish Cloaking Device / 40
				{ 18, 9273 }, --Goblin Jumper Cables / 33
				{ 19, 3952 }, --Minor Recombobulator / 28
				{ 20, 9269 }, --Gnomish Universal Remote / 25
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 22793 }, --Biznicks 247x128 Accurascope / 60
				{ 2, 12620 }, --Sniper Scope / 48
				{ 3, 12597 }, --Deadly Scope / 42
				{ 4, 3979 }, --Accurate Scope / 36
				{ 5, 3978 }, --Standard Scope / 22
				{ 6, 3977 }, --Crude Scope / 12
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Guns"],
			[NORMAL_DIFF] = {
				{ 1, 22795 }, --Core Marksman Rifle / 65
				{ 2, 19833 }, --Flawless Arcanite Rifle / 61
				{ 3, 19796 }, --Dark Iron Rifle / 55
				{ 4, 19792 }, --Thorium Rifle / 52
				{ 5, 12614 }, --Mithril Heavy-bore Rifle / 44
				{ 6, 12595 }, --Mithril Blunderbuss / 41
				{ 7, 3954 }, --Moonsight Rifle / 29
				{ 8, 3949 }, --Silver-plated Shotgun / 26
				{ 9, 3939 }, --Lovingly Crafted Boomstick / 24
				{ 10, 3936 }, --Deadly Blunderbuss / 21
				{ 11, 3925 }, --Rough Boomstick / 10
			}
		},
		{
			name = ALIL["Projectile"].." - "..ALIL["Bullet"],
			[NORMAL_DIFF] = {
				{ 1, 19800 }, --Thorium Shells / 57
				{ 2, 12621 }, --Mithril Gyro-Shot / 49
				{ 3, 12596 }, --Hi-Impact Mithril Slugs / 42
				{ 4, 3947 }, --Crafted Solid Shot / 35
				{ 5, 3930 }, --Crafted Heavy Shot / 20
				{ 6, 3920 }, --Crafted Light Shot / 10
			}
		},
		{
			name = ALIL["Parts"],
			[NORMAL_DIFF] = {
				{ 1, 19815 }, --Delicate Arcanite Converter / 58
				{ 2, 19791 }, --Thorium Widget / 52
				{ 3, 19788 }, --Dense Blasting Powder / 50
				{ 4, 23071 }, --Truesilver Transformer / 50
				{ 5, 12599 }, --Mithril Casing / 43
				{ 6, 12591 }, --Unstable Trigger / 40
				{ 7, 19795 }, --Thorium Tube / 39
				{ 8, 12589 }, --Mithril Tube / 39
				{ 9, 12585 }, --Solid Blasting Powder / 35
				{ 10, 3961 }, --Gyrochronatom / 34
				{ 11, 3958 }, --Iron Strut / 32
				{ 12, 12584 }, --Gold Power Core / 30
				{ 13, 3953 }, --Bronze Framework / 29
				{ 14, 3945 }, --Heavy Blasting Powder / 25
				{ 15, 3942 }, --Whirring Bronze Gizmo / 25
				{ 16, 3938 }, --Bronze Tube / 21
				{ 17, 3973 }, --Silver Contact / 18
				{ 18, 3926 }, --Copper Modulator / 13
				{ 19, 3929 }, --Coarse Blasting Powder / 15
				{ 20, 3924 }, --Copper Tube / 10
				{ 21, 3922 }, --Handful of Copper Bolts / 8
				{ 22, 3918 }, --Rough Blasting Powder / 5
			}
		},
		{
			name = AL["Fireworks"],
			[NORMAL_DIFF] = {
				{ 16, 26443 }, --Cluster Launcher / 1
				{ 1, 26442 }, --Firework Launcher / 1
				{ 3, 26418 }, --Small Red Rocket / 1
				{ 4, 26417 }, --Small Green Rocket / 1
				{ 5, 26416 }, --Small Blue Rocket / 1
				{ 7, 26425 }, --Red Rocket Cluster / 1
				{ 8, 26424 }, --Green Rocket Cluster / 1
				{ 9, 26423 }, --Blue Rocket Cluster / 1
				{ 12, 23066 }, --Red Firework / 20
				{ 13, 23068 }, --Green Firework / 20
				{ 14, 23067 }, --Blue Firework / 20
				{ 18, 26422 }, --Large Red Rocket / 1
				{ 19, 26421 }, --Large Green Rocket / 1
				{ 20, 26420 }, --Large Blue Rocket / 1
				{ 22, 26428 }, --Large Red Rocket Cluster / 1
				{ 23, 26427 }, --Large Green Rocket Cluster / 1
				{ 24, 26426 }, --Large Blue Rocket Cluster / 1
				{ 27, 23507 }, --Snake Burst Firework / 50
			}
		},
		{
			name = ALIL["Explosives"],
			[NORMAL_DIFF] = {
				{ 1, 19831 }, --Arcane Bomb / 60
				{ 2, 19799 }, --Dark Iron Bomb / 57
				{ 3, 19790 }, --Thorium Grenade / 55
				{ 4, 23070 }, --Dense Dynamite / 45
				{ 5, 12619 }, --Hi-Explosive Bomb / 47
				{ 6, 12754 }, --The Big One / 45
				{ 7, 3968 }, --Goblin Land Mine / 39
				{ 8, 12603 }, --Mithril Frag Bomb / 43
				{ 9, 12760 }, --Goblin Sapper Charge / 41
				{ 10, 23069 }, --Ez-Thro Dynamite II / 40
				{ 11, 3967 }, --Big Iron Bomb / 43
				{ 12, 8243 }, --Flash Bomb / 37
				{ 13, 3962 }, --Iron Grenade / 35
				{ 14, 12586 }, --Solid Dynamite / 35
				{ 15, 3955 }, --Explosive Sheep / 30
				{ 16, 3950 }, --Big Bronze Bomb / 33
				{ 17, 3946 }, --Heavy Dynamite / 30
				{ 18, 3941 }, --Small Bronze Bomb / 29
				{ 19, 8339 }, --Ez-Thro Dynamite / 25
				{ 20, 3937 }, --Large Copper Bomb / 26
				{ 21, 3931 }, --Coarse Dynamite / 20
				{ 22, 3923 }, --Rough Copper Bomb / 14
				{ 23, 3919 }, --Rough Dynamite / 10
			}
		},
		{
			name = AL["Pets"],
			[NORMAL_DIFF] = {
				{ 1, 19793 }, --Lifelike Mechanical Toad / 53
				{ 2, 15633 }, --Lil / 41
				{ 3, 15628 }, --Pet Bombling / 41
				{ 4, 3928 }, --Mechanical Squirrel Box / 15
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 23080 }, --Powerful Seaforium Charge / 52
				{ 2, 3972 }, --Large Seaforium Charge / 40
				{ 3, 3933 }, --Small Seaforium Charge / 20
				{ 5, 22704 }, --Field Repair Bot 74A / 60
				{ 6, 15255 }, --Mechanical Repair Kit / 40
				{ 8, 19814 }, --Masterwork Target Dummy / 55
				{ 9, 3965 }, --Advanced Target Dummy / 37
				{ 10, 3932 }, --Target Dummy / 17
				{ 12, 28327 }, --Steam Tonk Controller / 55
				{ 13, 9271 }, --Aquadynamic Fish Attractor / 30
				{ 15, 12715 }, --Recipe: Goblin Rocket Fuel / 42
				{ 16, 3957 }, --Ice Deflector / 31
				{ 17, 3944 }, --Flame Deflector / 25
				{ 19, 23129 }, --World Enlarger / 50
				{ 20, 12590 }, --Gyromatic Micro-Adjustor / 35
				{ 21, 3959 }, --Discombobulator Ray / 32
				{ 22, 26011 }, --Tranquil Mechanical Yeti / 60
				{ 23, 23096 }, --Gnomish Alarm-O-Bot / 53
				{ 24, 19567 }, --Salt Shaker / 50
				{ 25, 21940 }, --SnowMaster 9000 / 38
				{ 26, 3963 }, --Compact Harvest Reaper Kit / 35
				{ 27, 3960 }, --Portable Bronze Mortar / 33
				{ 28, 6458 }, --Ornate Spyglass / 27
				{ 29, 8334 }, --Practice Lock / 20
				{ 30, 12895 }, --Plans: Inlaid Mithril Cylinder / 40
			}
		},
	}
}

data["Tailoring"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.TAILORING_LINK,
	items = {
		{
			name = AL["SoD Phase 8"],
			[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Phase 8"], nil },
			{ 2, 1224607 }, -- Scarlet Augur's Hood
			{ 3, 1224608 }, -- Scarlet Augur's Mantle
			{ 4, 1224609 }, -- Scarlet Augur's Vestaments
			{ 5, 1224610 }, -- Scarlet Augur's Cuffs
			{ 6, 1224611 }, -- Scarlet Augur's Mitts
			{ 7, 1224612 }, -- Scarlet Augur's Strap
			{ 8, 1224613 }, -- Scarlet Augur's Leggings
			{ 9, 1224614 }, -- Scarlet Augur's Soles
			{ 11, 1227724 }, -- Crimson Dawnwoven Bag
			{ 12, 1227723 }, -- Crusader's Knapsack
			}
		},
			{
			name = AL["SoD Phase 4-6"],
			[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Phase 4"], nil },
			{ 2, 461747 }, -- Incandescent Mooncloth Vest
			{ 3, 461708 }, -- Incandescent Mooncloth Robe
			--{ 4, 461708 }, -- Incandescent Mooncloth Boots
			{ 4, 461750 }, -- Incandescent Mooncloth Circlet
			{ 5, 461752 }, -- Incandescent Mooncloth Leggings
			{ 6, 462282 }, -- Embroidered Belt of the Archmage
			--{ 8, }, -- Fine Flarecore Leggings
			--{ 9, }, -- Fine Flarecore Robe
			--{ 10, }, -- Fine Flarecore Mantle
			--{ 11, }, -- Fine Flarecore Gloves
			--{ 12, }, -- Argent Elite Boots
			--{ 13, }, -- Rugged Mantle of the Timbermaw
			{ 16, "INV_Box_01", nil, AL["Phase 6"], nil },
			{ 17, 1214173 }, -- Bolt of Qiraji Silk
			{ 18, 1213740 }, -- Sylvan Shoulders
			{ 19, 1213742 }, -- Sylvan Crown
			{ 20, 1213744 }, -- Sylvan Vest
			{ 21, 1213527 }, -- Vampiric Cowl
			{ 22, 1213530 }, -- Vampiric Shawl
			{ 23, 1213532 }, -- Vampiric Robe
			{ 24, 1214307 }, -- Dreamscale Mitts
			{ 25, 1214306 }, -- Dreamscale Bracers
			{ 26, 1213536 }, -- Qiraji Silk Cape
			{ 27, 1213538 }, -- Qiraji Silk Cloak
			{ 28, 1213540 }, -- Qiraji Silk Drape
			{ 29, 1213534 }, -- Qiraji Silk Scarf
			}
		},
		{
			name = AL["SoD Phase 1-3"],
			[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Phase 1"], nil },
			{ 2, 429351 }, --Extraplanar Spidersilk Boots
			{ 3, 428424 }, --Phoenix Bindings
			{ 4, 435841 }, --Invoker's Cord
			{ 5, 435848 }, --Invoker's Mantle
			{ 7, "INV_Box_01", nil, AL["Phase 2"], nil },
			{ 8, 435827 }, -- Hyperconductive Arcano-Filament
			{ 9, 435610 }, -- Gneuro-Linked Arcano-Filament Monocle
			{ 11, "INV_Box_01", nil, AL["Phase 3"], nil },
			{ 12, 446194 }, --Invoker's Cord
			{ 13, 446195 }, --Invoker's Cord
			{ 14, 446193 }, --Invoker's Cord
			{ 16, "INV_Box_01", nil, AL["Updated in SoD"], nil },
			{ 17, 439105 }, -- Big Voodoo Mask
			{ 18, 439108 }, -- Big Voodoo Robe
			{ 19, 439088 }, -- Black Mageweave Leggings
			{ 20, 439086 }, -- Black Mageweave Vest
			{ 21, 439097 }, -- Boots of the Enchanter
			{ 22, 439098 }, -- Crimson Silk Belt
			{ 23, 439085 }, -- Crimson Silk Robe
			{ 24, 439093 }, -- Crimson Silk Shoulders
			{ 25, 439091 }, -- Earthen Silk Belt
			{ 26, 439100 }, -- Earthen Vest
			{ 27, 439102 }, -- Enchanter's Cowl
			{ 28, 439094 }, -- Long Silken Cloak
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 28208 }, --Glacial Cloak / 80
				{ 2, 28210 }, --Gaea's Embrace / 70
				{ 3, 22870 }, --Cloak of Warding / 62
				{ 4, 18418 }, --Cindercloth Cloak / 55
				{ 5, 18420 }, --Brightcloth Cloak / 55
				{ 6, 18422 }, --Cloak of Fire / 55
				{ 7, 18409 }, --Runecloth Cloak / 53
				{ 8, 3862 }, --Icy Cloak / 40
				{ 9, 3861 }, --Long Silken Cloak / 37
				{ 10, 8789 }, --Crimson Silk Cloak / 36
				{ 11, 8786 }, --Azure Silk Cloak / 35
				{ 12, 3844 }, --Heavy Woolen Cloak / 21
				{ 13, 6521 }, --Pearl-clasped Cloak / 19
				{ 14, 2402 }, --Woolen Cape / 16
				{ 15, 2397 }, --Reinforced Linen Cape / 12
				{ 16, 2387 }, --Linen Cloak / 6
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 28481 }, --Sylvan Crown / 70
				{ 2, 18452 }, --Mooncloth Circlet / 62
				{ 3, 18450 }, --Wizardweave Turban / 61
				{ 4, 18444 }, --Runecloth Headband / 59
				{ 5, 18442 }, --Felcloth Hood / 58
				{ 6, 12092 }, --Dreamweave Circlet / 50
				{ 7, 12086 }, --Shadoweave Mask / 49
				{ 8, 12084 }, --Red Mageweave Headband / 48
				{ 9, 12081 }, --Admiral's Hat / 48
				{ 10, 12072 }, --Black Mageweave Headband / 46
				{ 11, 12059 }, --White Bandit Mask / 43
				{ 12, 3858 }, --Shadow Hood / 34
				{ 13, 3857 }, --Enchanter's Cowl / 33
				{ 14, 8762 }, --Silk Headband / 32
				{ 15, 8760 }, --Azure Silk Hood / 29
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[NORMAL_DIFF] = {
				{ 1, 28482 }, --Sylvan Shoulders / 70 / 315
				{ 2, 23663 }, --Mantle of the Timbermaw / 64 / 315
				{ 3, 23665 }, --Argent Shoulders / 64 / 315
				{ 4, 18453 }, --Felcloth Shoulders / 62 / 315
				{ 5, 20848 }, --Flarecore Mantle / 61 / 315
				{ 6, 18449 }, --Runecloth Shoulders / 61 / 315
				{ 7, 18448 }, --Mooncloth Shoulders / 61 / 315
				{ 8, 12078 }, --Red Mageweave Shoulders / 47 / 250
				{ 9, 12076 }, --Shadoweave Shoulders / 47 / 250
				{ 10, 12074 }, --Black Mageweave Shoulders / 46 / 245
				{ 11, 8793 }, --Crimson Silk Shoulders / 38 / 210
				{ 12, 8795 }, --Azure Shoulders / 38 / 210
				{ 13, 8774 }, --Green Silken Shoulders / 36 / 200
				{ 14, 3849 }, --Reinforced Woolen Shoulders / 24 / 145
				{ 15, 3848 }, --Double-stitched Woolen Shoulders / 22 / 135
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[NORMAL_DIFF] = {
				{ 1, 28207 }, --Glacial Vest / 80
				{ 2, 28480 }, --Sylvan Vest / 70
				{ 3, 23666 }, --Flarecore Robe / 66
				{ 4, 24091 }, --Bloodvine Vest / 65
				{ 5, 18457 }, --Robe of the Archmage / 62
				{ 6, 18456 }, --Truefaith Vestments / 62
				{ 7, 18458 }, --Robe of the Void / 62
				{ 8, 22902 }, --Mooncloth Robe / 61
				{ 9, 18451 }, --Felcloth Robe / 61
				{ 10, 18446 }, --Wizardweave Robe / 60
				{ 11, 18447 }, --Mooncloth Vest / 60
				{ 12, 18436 }, --Robe of Winter Night / 57
				{ 13, 18416 }, --Ghostweave Vest / 55
				{ 14, 18414 }, --Brightcloth Robe / 54
				{ 15, 18408 }, --Cindercloth Vest / 52
				{ 16, 18407 }, --Runecloth Tunic / 52
				{ 17, 18406 }, --Runecloth Robe / 52
				{ 18, 18404 }, --Frostweave Robe / 51
				{ 19, 18403 }, --Frostweave Tunic / 51
				{ 20, 12077 }, --Simple Black Dress / 47
				{ 21, 12070 }, --Dreamweave Vest / 45
				{ 22, 12069 }, --Cindercloth Robe / 45
				{ 23, 12056 }, --Red Mageweave Vest / 43
				{ 24, 12055 }, --Shadoweave Robe / 43
				{ 25, 12050 }, --Black Mageweave Robe / 42
				{ 26, 12048 }, --Black Mageweave Vest / 41
				{ 27, 8802 }, --Crimson Silk Robe / 41
				{ 28, 8770 }, --Robe of Power / 38
				{ 29, 8791 }, --Crimson Silk Vest / 37
				{ 30, 12091 }, --White Wedding Dress / 35
				{ 101, 12093 }, --Tuxedo Jacket / 35
				{ 102, 8764 }, --Earthen Vest / 34
				{ 103, 8784 }, --Green Silk Armor / 33
				{ 104, 6692 }, --Robes of Arcana / 30
				{ 105, 3859 }, --Azure Silk Vest / 30
				{ 106, 6690 }, --Lesser Wizard's Robe / 27
				{ 107, 7643 }, --Greater Adept's Robe / 23
				{ 108, 8467 }, --White Woolen Dress / 22
				{ 109, 2403 }, --Gray Woolen Robe / 21
				{ 110, 7639 }, --Blue Overalls / 20
				{ 111, 2399 }, --Green Woolen Vest / 17
				{ 112, 2395 }, --Barbaric Linen Vest / 14
				{ 113, 7633 }, --Blue Linen Robe / 14
				{ 114, 7629 }, --Red Linen Vest / 12
				{ 115, 7630 }, --Blue Linen Vest / 12
				{ 116, 8465 }, --Simple Dress / 10
				{ 117, 7624 }, --White Linen Robe / 10
				{ 118, 2389 }, --Red Linen Robe / 10
				{ 119, 7623 }, --Brown Linen Robe / 10
				{ 120, 2385 }, --Brown Linen Vest / 8
				{ 121, 26407 }, --Festival Suit / 1
				{ 122, 26403 }, --Festival Dress / 1
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[NORMAL_DIFF] = {
				{ 1, 24093 }, --Bloodvine Boots / 65
				{ 2, 24903 }, --Runed Stygian Boots / 63
				{ 3, 23664 }, --Argent Boots / 58
				{ 4, 18437 }, --Felcloth Boots / 57
				{ 5, 19435 }, --Mooncloth Boots / 56
				{ 6, 18423 }, --Runecloth Boots / 56
				{ 7, 12088 }, --Cindercloth Boots / 49
				{ 8, 12082 }, --Shadoweave Boots / 48
				{ 9, 12073 }, --Black Mageweave Boots / 46
				{ 10, 3860 }, --Boots of the Enchanter / 35
				{ 11, 3856 }, --Spider Silk Slippers / 28
				{ 12, 3855 }, --Spidersilk Boots / 25
				{ 13, 3847 }, --Red Woolen Boots / 20
				{ 14, 2401 }, --Woolen Boots / 19
				{ 15, 3845 }, --Soft-soled Linen Boots / 16
				{ 16, 2386 }, --Linen Boots / 13
				{ 17, 12045 }, --Simple Linen Boots / 9
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[NORMAL_DIFF] = {
				{ 1, 28205 }, --Glacial Gloves / 80
				{ 2, 22869 }, --Mooncloth Gloves / 62
				{ 3, 22867 }, --Felcloth Gloves / 62
				{ 4, 20849 }, --Flarecore Gloves / 62
				{ 5, 22868 }, --Inferno Gloves / 62
				{ 6, 18454 }, --Gloves of Spell Mastery / 62
				{ 7, 18417 }, --Runecloth Gloves / 55
				{ 8, 18415 }, --Brightcloth Gloves / 54
				{ 9, 18413 }, --Ghostweave Gloves / 54
				{ 10, 18412 }, --Cindercloth Gloves / 54
				{ 11, 18411 }, --Frostweave Gloves / 53
				{ 12, 12071 }, --Shadoweave Gloves / 45
				{ 13, 12066 }, --Red Mageweave Gloves / 45
				{ 14, 12067 }, --Dreamweave Gloves / 45
				{ 15, 12053 }, --Black Mageweave Gloves / 43
				{ 16, 8804 }, --Crimson Silk Gloves / 42
				{ 17, 8782 }, --Truefaith Gloves / 30
				{ 18, 8780 }, --Hands of Darkness / 29
				{ 19, 3854 }, --Azure Silk Gloves / 29
				{ 20, 3852 }, --Gloves of Meditation / 26
				{ 21, 3868 }, --Phoenix Gloves / 25
				{ 22, 3843 }, --Heavy Woolen Gloves / 17
				{ 23, 3840 }, --Heavy Linen Gloves / 10
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[NORMAL_DIFF] = {
				{ 1, 23667 }, --Flarecore Leggings / 70
				{ 2, 24092 }, --Bloodvine Leggings / 65
				{ 3, 24901 }, --Runed Stygian Leggings / 63
				{ 4, 18440 }, --Mooncloth Leggings / 58
				{ 5, 18439 }, --Brightcloth Pants / 58
				{ 6, 18441 }, --Ghostweave Pants / 58
				{ 7, 18438 }, --Runecloth Pants / 57
				{ 8, 18424 }, --Frostweave Pants / 56
				{ 9, 18434 }, --Cindercloth Pants / 56
				{ 10, 18419 }, --Felcloth Pants / 55
				{ 11, 18421 }, --Wizardweave Leggings / 55
				{ 12, 12060 }, --Red Mageweave Pants / 43
				{ 13, 12052 }, --Shadoweave Pants / 42
				{ 14, 12049 }, --Black Mageweave Leggings / 41
				{ 15, 8799 }, --Crimson Silk Pantaloons / 39
				{ 16, 12089 }, --Tuxedo Pants / 35
				{ 17, 8758 }, --Azure Silk Pants / 28
				{ 18, 3851 }, --Phoenix Pants / 25
				{ 19, 12047 }, --Colorful Kilt / 24
				{ 20, 3850 }, --Heavy Woolen Pants / 22
				{ 21, 12046 }, --Simple Kilt / 15
				{ 22, 3842 }, --Handstitched Linen Britches / 14
				{ 23, 3914 }, --Brown Linen Pants / 10
				{ 24, 12044 }, --Simple Linen Pants / 7
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Body"],
			[NORMAL_DIFF] = {
				{ 1, 12085 }, --Tuxedo Shirt / 1 / 245
				{ 2, 12080 }, --Pink Mageweave Shirt / 47 / 240
				{ 3, 12075 }, --Lavender Mageweave Shirt / 46 / 235
				{ 4, 12064 }, --Orange Martial Shirt / 40 / 225
				{ 5, 12061 }, --Orange Mageweave Shirt / 43 / 220
				{ 6, 3873 }, --Black Swashbuckler's Shirt / 40 / 210
				{ 7, 21945 }, --Green Holiday Shirt / 40 / 200
				{ 8, 3872 }, --Rich Purple Silk Shirt / 37 / 195
				{ 9, 8489 }, --Red Swashbuckler's Shirt / 35 / 185
				{ 10, 3871 }, --Formal White Shirt / 34 / 180
				{ 11, 8483 }, --White Swashbuckler's Shirt / 32 / 170
				{ 12, 3870 }, --Dark Silk Shirt / 31 / 165
				{ 13, 7893 }, --Stylish Green Shirt / 25 / 145
				{ 14, 3869 }, --Bright Yellow Shirt / 27 / 145
				{ 15, 7892 }, --Stylish Blue Shirt / 25 / 145
				{ 16, 3866 }, --Stylish Red Shirt / 22 / 135
				{ 17, 2406 }, --Gray Woolen Shirt / 20 / 110
				{ 18, 2396 }, --Green Linen Shirt / 14 / 95
				{ 19, 2394 }, --Blue Linen Shirt / 10 / 65
				{ 20, 2392 }, --Red Linen Shirt / 10 / 65
				{ 21, 2393 }, --White Linen Shirt / 7 / 35
				{ 22, 3915 }, --Brown Linen Shirt / 7 / 35
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[NORMAL_DIFF] = {
				{ 1, 24902 }, --Runed Stygian Belt / 63 / 315
				{ 2, 22866 }, --Belt of the Archmage / 62 / 315
				{ 3, 23662 }, --Wisdom of the Timbermaw / 58 / 305
				{ 4, 18410 }, --Ghostweave Belt / 53 / 280
				{ 5, 18402 }, --Runecloth Belt / 51 / 270
				{ 6, 3864 }, --Star Belt / 40 / 220
				{ 7, 8797 }, --Earthen Silk Belt / 39 / 215
				{ 8, 3863 }, --Spider Belt / 36 / 200
				{ 9, 8772 }, --Crimson Silk Belt / 35 / 195
				{ 10, 8766 }, --Azure Silk Belt / 35 / 195
				{ 11, 8776 }, --Linen Belt / 9 / 50
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[NORMAL_DIFF] = {
				{ 1, 28209 }, --Glacial Wrists / 80 / 315
				{ 2, 22759 }, --Flarecore Wraps / 64 / 320
				{ 3, 3841 }, --Green Linen Bracers / 12 / 85
			}
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 18455 }, --Bottomless Bag / 62 / 315
				{ 2, 18445 }, --Mooncloth Bag / 60 / 315
				{ 3, 18405 }, --Runecloth Bag / 52 / 275
				{ 4, 12079 }, --Red Mageweave Bag / 35 / 250
				{ 5, 12065 }, --Mageweave Bag / 35 / 240
				{ 6, 6695 }, --Black Silk Pack / 25 / 205
				{ 7, 6693 }, --Green Silk Pack / 25 / 195
				{ 8, 3813 }, --Small Silk Pack / 25 / 170
				{ 9, 6688 }, --Red Woolen Bag / 15 / 140
				{ 10, 3758 }, --Green Woolen Bag / 15 / 120
				{ 11, 3757 }, --Woolen Bag / 15 / 105
				{ 12, 6686 }, --Red Linen Bag / 5 / 95
				{ 13, 3755 }, --Linen Bag / 5 / 70
				{ 16, 27725 }, --Satchel of Cenarius / 65 / 315
				{ 17, 27724 }, --Cenarion Herb Bag / 55 / 290
				{ 19, 27660 }, --Big Bag of Enchantment / 65 / 315
				{ 20, 27659 }, --Enchanted Runecloth Bag / 55 / 290
				{ 21, 27658 }, --Enchanted Mageweave Pouch / 45 / 240
				{ 23, 26087 }, --Core Felcloth Bag / 60 / 315
				{ 24, 26086 }, --Felcloth Bag / 57 / 300
				{ 25, 26085 }, --Soul Pouch / 52 / 275
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 18560 }, --Mooncloth / 55 / 290
				{ 3, 18401 }, --Bolt of Runecloth / 55 / 255
				{ 4, 3865 }, --Bolt of Mageweave / 45 / 180
				{ 5, 3839 }, --Bolt of Silk Cloth / 35 / 135
				{ 6, 2964 }, --Bolt of Woolen Cloth / 25 / 90
				{ 7, 2963 }, --Bolt of Linen Cloth / 10 / 25
			}
		},
	}
}

data["Leatherworking"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.LEATHERWORKING_LINK,
	items = {
		{
			name = AL["SoD Phase 8"],
			[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Leather"], nil },
			{ 2, 1224615 }, -- Scarlet Infiltrator's Bandana
			{ 3, 1224616 }, -- Scarlet Infiltrator's Shoulderpads
			{ 4, 1224617 }, -- Scarlet Infiltrator's Vest
			{ 5, 1224618 }, -- Scarlet Infiltrator's Bracers
			{ 6, 1224619 }, -- Scarlet Infiltrator's Gloves
			{ 7, 1224620 }, -- Scarlet Infiltrator's Belt
			{ 8, 1224621 }, -- Scarlet Infiltrator's Trousers
			{ 9, 1224622 }, -- Scarlet Infiltrator's Shoes
			{ 11, 1226689 }, -- Scarlet Quiver
			{ 16, "INV_Box_01", nil, AL["Mail"], nil },
			{ 17, 1224623 }, -- Scarlet Huntsman's Coif
			{ 18, 1224624 }, -- Scarlet Huntsman's Pauldrons
			{ 19, 1224625 }, -- Scarlet Huntsman's Chain
			{ 20, 1224626 }, -- Scarlet Huntsman's Wristguards
			{ 21, 1224627 }, -- Scarlet Huntsman's Handguards
			{ 22, 1224628 }, -- Scarlet Huntsman's Clasp
			{ 23, 1224629 }, -- Scarlet Huntsman's Legguards
			{ 24, 1224630 }, -- Scarlet Huntsman's Boots
			{ 26, 1226690 }, -- Scarlet Ammo Pouch
			}
		},
		{
			name = AL["SoD Phase 6"],
			[NORMAL_DIFF] = {
			{ 1, 1213717 }, -- Sandstalker Bracers
			{ 2, 1213728 }, -- Spitfire Gauntlets
			{ 3, 1213734 }, -- Bramblewood Belt
			{ 4, 1213720 }, -- Sandstalker Gauntlets
			{ 5, 1213723 }, -- Sandstalker Breastplate
			{ 6, 1213731 }, -- Spitfire Breastplate
			{ 7, 1213738 }, -- Bramblewood Helm
			{ 8, 1213736 }, -- Bramblewood Boots
			{ 9, 1213751 }, -- Dreamscale Breastplate
			{ 10, 1213523 }, -- Razorbramble Shoulderpads
			{ 11, 1213521 }, -- Razorbramble Cowl
			{ 12, 1213525 }, -- Razorbramble Leathers
			{ 13, 1214303 }, -- Dreamscale Kilt
			{ 16, 1213513 }, -- Pattern: Glowing Chitin Armor Kit
			{ 17, 1213519 }, -- Pattern: Sharpened Chitin Armor Kit
			}
		},	
			{
			name = AL["SoD Phase 4"],
			[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Phase 4"], nil },
			{ 2, "INV_Box_01", nil, AL["Armor"], nil },
			{ 3, 461754 }, -- Girdle of Arcane Insight
			{ 4, 461706 }, -- Swift Flight Vambraces
			{ 5, 461653 }, -- Brilliant Chromatic Cloak 227869
			{ 6, 461645 }, -- Honed Blue Dragonscale Shoulders 227873
			{ 7, 462227 }, -- Honed Blue Dragonscale Leggings
			{ 8, 461673 }, -- Honed Blue Dragonscale Breastplate
			{ 9, 461649 }, -- Living Green Dragonscale Leggings
			{ 10, 461677 }, -- Living Green Dragonscale Gauntlets
			{ 11, 461720 }, -- Living Green Dragonscale Breastplate
			{ 12, 461754 }, -- Girdle of Arcane Insight
			{ 13, 461706 }, -- Swift Flight Vambraces
			--{ 14, }, -- Knowledge of the Timbermaw
			{ 14, 461657 }, -- Hardened Black Dragonscale Leggings
			{ 16, 461690 }, -- Mastercrafted Shifting Cloak
			{ 17, 461722 }, -- Devilcore Gauntlets
			{ 18, 461724 }, -- Devilcore Leggings
			--{ 20, }, -- Shining Chromatic Gauntlets
			--{ 21, }, -- Glowing Mantle of the Dawn
			--{ 22, }, -- Fine Dawn Treaders
			--{ 23, }, -- Studded Timbermaw Brawlers
			--{ 24, }, -- Ferocity of the Timbermaw
			--{ 25, }, -- Dire Warbear Woolies
			--{ 26, }, -- Dire Warbear Harness
			{ 20, "INV_Box_01", nil, AL["Fire Resist"], nil },
			{ 21, 461663 }, -- Masterwork Volcanic Shoulders
			{ 22, 461665 }, -- Masterwork Volcanic Leggings
			{ 23, 461661 }, -- Masterwork Volcanic Breastplate
			{ 24, 461659 }, -- Hardened Black Dragonscale Shoulders
			{ 25, 461655 }, -- Hardened Black Dragonscale Breastplate
			--{ 107, }, -- Thick Corehound Belt
			--{ 108, }, -- Hardened Black Dragonscale Boots
			--{ 109, }, -- Lavawalker Belt
			--{ 110, }, -- Thick Corehound Boots
			--{ 111, }, -- Flamekissed Molten Helm
			}
		},
			{
			name = AL["SoD Phase 1-3"],
			[NORMAL_DIFF] = {
			{ 1, "INV_Box_01", nil, AL["Phase 1"], nil },
			{ 2, 429869 }, --Void-Touched Leather Gauntlets
			{ 3, 429354 }, --Void-Touched Leather Gloves
			{ 5, "INV_Box_01", nil, AL["Phase 2"], nil },
			{ 6, 435819 }, -- Faintly Glowing Leather
			{ 7, 435904 }, -- Glowing Gneuro-Linked Cowl
			{ 8, 435949 }, -- Glowing Hyperconductive Scale Coif
			{ 9, 435951 }, -- Gneuro-Conductive Channeler's Hood
			{ 10, 435953 }, -- Rad-Resistant Scale Hood
			{ 16, "INV_Box_01", nil, AL["Updated in SoD"], nil },
			{ 17, 439112 }, -- Guardian Belt
			{ 18, 439110 }, -- Guardian Leather Bracers
			{ 19, 439114 }, -- Guardian Pants
			{ 20, 439116 }, -- Turtle Scale Breastplate
			{ 21, 439118 }, -- Turtle Scale Gloves
			{ 23, "INV_Box_01", nil, AL["Phase 3"], nil },
			{ 24, 446183 }, --Paranoia Mantle
			{ 25, 446185 }, --Shrieking Spaulders
			{ 26, 446190 }, --Wailing Chain Mantle
			{ 27, 446189 }, --Shoulderpads of Obsession
			{ 28, 446192 }, --Membrane of Dark Neurosis
			{ 29, 446186 }, --Cacophonous Chain Shoulderguards
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 22927 }, --Hide of the Wild / 62 / 320
				{ 2, 22928 }, --Shifting Cloak / 62 / 320
				{ 3, 22926 }, --Chromatic Cloak / 62 / 320
				{ 4, 19093 }, --Onyxia Scale Cloak / 60 / 320
				{ 5, 10574 }, --Wild Leather Cloak / 50 / 270
				{ 6, 10562 }, --Big Voodoo Cloak / 48 / 260
				{ 7, 7153 }, --Guardian Cloak / 37 / 205
				{ 8, 9198 }, --Frost Leather Cloak / 36 / 200
				{ 9, 3760 }, --Hillman's Cloak / 30 / 170
				{ 10, 2168 }, --Dark Leather Cloak / 22 / 135
				{ 11, 9070 }, --Black Whelp Cloak / 20 / 125
				{ 12, 7953 }, --Deviate Scale Cloak / 18 / 120
				{ 13, 2159 }, --Fine Leather Cloak / 15 / 105
				{ 14, 2162 }, --Embossed Leather Cloak / 13 / 90
				{ 15, 9058 }, --Handstitched Leather Cloak / 9 / 40
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[LEATHER_DIFF] = {
				{ 1, 28219 }, --Polar Tunic / 80 / 320
				{ 2, 24121 }, --Primal Batskin Jerkin / 65 / 320
				{ 3, 24124 }, --Blood Tiger Breastplate / 65 / 320
				{ 4, 19102 }, --Runic Leather Armor / 62 / 320
				{ 5, 19104 }, --Frostsaber Tunic / 62 / 320
				{ 6, 19098 }, --Wicked Leather Armor / 61 / 320
				{ 7, 19095 }, --Living Breastplate / 60 / 320
				{ 8, 19086 }, --Ironfeather Breastplate / 58 / 310
				{ 9, 19081 }, --Chimeric Vest / 58 / 310
				{ 10, 19076 }, --Volcanic Breastplate / 57 / 305
				{ 11, 19079 }, --Stormshroud Armor / 57 / 305
				{ 12, 19068 }, --Warbear Harness / 55 / 295
				{ 13, 10647 }, --Feathered Breastplate / 50 / 270
				{ 14, 10544 }, --Wild Leather Vest / 45 / 245
				{ 15, 10520 }, --Big Voodoo Robe / 43 / 235
				{ 16, 10499 }, --Nightscape Tunic / 41 / 225
				{ 17, 6661 }, --Barbaric Harness / 38 / 210
				{ 18, 3773 }, --Guardian Armor / 35 / 195
				{ 19, 9197 }, --Green Whelp Armor / 35 / 195
				{ 20, 9196 }, --Dusky Leather Armor / 35 / 195
				{ 21, 6704 }, --Thick Murloc Armor / 34 / 190
				{ 22, 4096 }, --Raptor Hide Harness / 33 / 185
				{ 23, 3772 }, --Green Leather Armor / 31 / 175
				{ 24, 2166 }, --Toughened Leather Armor / 24 / 145
				{ 25, 24940 }, --Black Whelp Tunic / 20 / 125
				{ 26, 3762 }, --Hillman's Leather Vest / 20 / 125
				{ 27, 2169 }, --Dark Leather Tunic / 20 / 125
				{ 28, 6703 }, --Murloc Scale Breastplate / 19 / 125
				{ 29, 8322 }, --Moonglow Vest / 18 / 115
				{ 30, 3761 }, --Fine Leather Tunic / 17 / 115
				{ 101, 2163 }, --White Leather Jerkin / 13 / 90
				{ 102, 2160 }, --Embossed Leather Vest / 12 / 70
				{ 103, 7126 }, --Handstitched Leather Vest / 8 / 40
			},
			[MAIL_DIFF] = {
				{ 1, 28222 }, --Icy Scale Breastplate / 80 / 320
				{ 2, 24703 }, --Dreamscale Breastplate / 68 / 320
				{ 3, 24851 }, --Sandstalker Breastplate / 62 / 320
				{ 4, 24848 }, --Spitfire Breastplate / 62 / 320
				{ 5, 19054 }, --Red Dragonscale Breastplate / 61 / 320
				{ 6, 19085 }, --Black Dragonscale Breastplate / 58 / 310
				{ 7, 19077 }, --Blue Dragonscale Breastplate / 57 / 305
				{ 8, 19051 }, --Heavy Scorpid Vest / 53 / 285
				{ 9, 19050 }, --Green Dragonscale Breastplate / 52 / 280
				{ 10, 10650 }, --Dragonscale Breastplate / 51 / 275
				{ 11, 10525 }, --Tough Scorpid Breastplate / 44 / 240
				{ 12, 10511 }, --Turtle Scale Breastplate / 42 / 230
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[LEATHER_DIFF] = {
				{ 1, 28473 }, --Bramblewood Boots / 70 / 320
				{ 2, 22922 }, --Mongoose Boots / 62 / 320
				{ 3, 20853 }, --Corehound Boots / 59 / 315
				{ 4, 23705 }, --Dawn Treaders / 58 / 310
				{ 5, 19063 }, --Chimeric Boots / 55 / 295
				{ 6, 19066 }, --Frostsaber Boots / 55 / 295
				{ 7, 10566 }, --Wild Leather Boots / 49 / 265
				{ 8, 10558 }, --Nightscape Boots / 47 / 255
				{ 9, 9207 }, --Dusky Boots / 40 / 220
				{ 10, 9208 }, --Swift Boots / 40 / 220
				{ 11, 2167 }, --Dark Leather Boots / 20 / 125
				{ 12, 2158 }, --Fine Leather Boots / 18 / 120
				{ 13, 2161 }, --Embossed Leather Boots / 15 / 85
				{ 14, 2149 }, --Handstitched Leather Boots / 8 / 40
			},
			[MAIL_DIFF] = {
				{ 1, 20855 }, --Black Dragonscale Boots / 61 / 320
				{ 2, 10554 }, --Tough Scorpid Boots / 47 / 255
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[LEATHER_DIFF] = {
				{ 1, 28220 }, --Polar Gloves / 80 / 320
				{ 2, 24122 }, --Primal Batskin Gloves / 65 / 320
				{ 3, 23704 }, --Timbermaw Brawlers / 64 / 320
				{ 4, 26279 }, --Stormshroud Gloves / 62 / 320
				{ 5, 19087 }, --Frostsaber Gloves / 59 / 315
				{ 6, 19084 }, --Devilsaur Gauntlets / 58 / 310
				{ 7, 19055 }, --Runic Leather Gauntlets / 54 / 290
				{ 8, 19053 }, --Chimeric Gloves / 53 / 285
				{ 9, 19049 }, --Wicked Leather Gauntlets / 52 / 280
				{ 10, 10630 }, --Gauntlets of the Sea / 46 / 250
				{ 11, 22711 }, --Shadowskin Gloves / 40 / 210
				{ 12, 7156 }, --Guardian Gloves / 38 / 210
				{ 13, 21943 }, --Gloves of the Greatfather / 38 / 210
				{ 14, 3771 }, --Barbaric Gloves / 30 / 170
				{ 15, 9149 }, --Heavy Earthen Gloves / 29 / 170
				{ 16, 3764 }, --Hillman's Leather Gloves / 29 / 170
				{ 17, 9148 }, --Pilferer's Gloves / 28 / 165
				{ 18, 3770 }, --Toughened Leather Gloves / 27 / 160
				{ 19, 9146 }, --Herbalist's Gloves / 27 / 160
				{ 20, 3765 }, --Dark Leather Gloves / 26 / 155
				{ 21, 9145 }, --Fletcher's Gloves / 25 / 150
				{ 22, 9074 }, --Nimble Leather Gloves / 24 / 145
				{ 23, 9072 }, --Red Whelp Gloves / 24 / 145
				{ 24, 7954 }, --Deviate Scale Gloves / 21 / 130
				{ 25, 2164 }, --Fine Leather Gloves / 15 / 105
				{ 26, 3756 }, --Embossed Leather Gloves / 13 / 85
			},
			[MAIL_DIFF] = {
				{ 1, 28223 }, --Icy Scale Gauntlets / 80 / 320
				{ 2, 23708 }, --Chromatic Gauntlets / 70 / 320
				{ 3, 24847 }, --Spitfire Gauntlets / 62 / 320
				{ 4, 24850 }, --Sandstalker Gauntlets / 62 / 320
				{ 5, 24655 }, --Green Dragonscale Gauntlets / 56 / 300
				{ 6, 19064 }, --Heavy Scorpid Gauntlet / 55 / 295
				{ 7, 10542 }, --Tough Scorpid Gloves / 45 / 245
				{ 8, 10619 }, --Dragonscale Gauntlets / 45 / 245
				{ 9, 10509 }, --Turtle Scale Gloves / 41 / 225
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[LEATHER_DIFF] = {
				{ 1, 28472 }, --Bramblewood Helm / 70 / 320
				{ 2, 20854 }, --Molten Helm / 60 / 320
				{ 3, 19082 }, --Runic Leather Headband / 58 / 310
				{ 4, 19071 }, --Wicked Leather Headband / 56 / 300
				{ 5, 10632 }, --Helm of Fire / 50 / 270
				{ 6, 10621 }, --Wolfshead Helm / 45 / 245
				{ 7, 10546 }, --Wild Leather Helmet / 45 / 245
				{ 8, 10531 }, --Big Voodoo Mask / 44 / 240
				{ 9, 10507 }, --Nightscape Headband / 41 / 225
				{ 10, 10490 }, --Comfortable Leather Hat / 40 / 220
			},
			[MAIL_DIFF] = {
				{ 1, 19088 }, --Heavy Scorpid Helm / 59 / 315
				{ 2, 10570 }, --Tough Scorpid Helm / 50 / 270
				{ 3, 10552 }, --Turtle Scale Helm / 46 / 250
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[LEATHER_DIFF] = {
				{ 1, 19097 }, --Devilsaur Leggings / 60 / 320
				{ 2, 19091 }, --Runic Leather Pants / 60 / 320
				{ 3, 19083 }, --Wicked Leather Pants / 58 / 310
				{ 4, 19074 }, --Frostsaber Leggings / 57 / 305
				{ 5, 19080 }, --Warbear Woolies / 57 / 305
				{ 6, 19078 }, --Living Leggings / 57 / 305
				{ 7, 19073 }, --Chimeric Leggings / 56 / 300
				{ 8, 19067 }, --Stormshroud Pants / 55 / 295
				{ 9, 19059 }, --Volcanic Leggings / 54 / 290
				{ 10, 10572 }, --Wild Leather Leggings / 50 / 270
				{ 11, 10560 }, --Big Voodoo Pants / 47 / 260
				{ 12, 10548 }, --Nightscape Pants / 46 / 250
				{ 13, 7149 }, --Barbaric Leggings / 34 / 190
				{ 14, 9195 }, --Dusky Leather Leggings / 33 / 185
				{ 15, 7147 }, --Guardian Pants / 32 / 180
				{ 16, 7135 }, --Dark Leather Pants / 23 / 140
				{ 17, 7133 }, --Fine Leather Pants / 21 / 130
				{ 18, 9068 }, --Light Leather Pants / 19 / 125
				{ 19, 3759 }, --Embossed Leather Pants / 15 / 105
				{ 20, 9064 }, --Rugged Leather Pants / 11 / 65
				{ 21, 2153 }, --Handstitched Leather Pants / 10 / 45
			},
			[MAIL_DIFF] = {
				{ 1, 19107 }, --Black Dragonscale Leggings / 62 / 320
				{ 2, 24654 }, --Blue Dragonscale Leggings / 60 / 320
				{ 3, 19075 }, --Heavy Scorpid Leggings / 57 / 305
				{ 4, 19060 }, --Green Dragonscale Leggings / 54 / 290
				{ 5, 10568 }, --Tough Scorpid Leggings / 49 / 265
				{ 6, 10556 }, --Turtle Scale Leggings / 47 / 255
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[LEATHER_DIFF] = {
				{ 1, 24125 }, --Blood Tiger Shoulders / 65 / 320
				{ 2, 23706 }, --Golden Mantle of the Dawn / 64 / 320
				{ 3, 19103 }, --Runic Leather Shoulders / 62 / 320
				{ 4, 19101 }, --Volcanic Shoulders / 61 / 320
				{ 5, 19090 }, --Stormshroud Shoulders / 59 / 315
				{ 6, 19061 }, --Living Shoulders / 54 / 290
				{ 7, 19062 }, --Ironfeather Shoulders / 54 / 290
				{ 8, 10529 }, --Wild Leather Shoulders / 44 / 240
				{ 9, 10516 }, --Nightscape Shoulders / 42 / 230
				{ 10, 7151 }, --Barbaric Shoulders / 35 / 195
				{ 11, 3769 }, --Dark Leather Shoulders / 28 / 165
				{ 12, 9147 }, --Earthen Leather Shoulders / 27 / 160
				{ 13, 3768 }, --Hillman's Shoulders / 26 / 155
			},
			[MAIL_DIFF] = {
				{ 1, 19100 }, --Heavy Scorpid Shoulders / 61 / 320
				{ 2, 19094 }, --Black Dragonscale Shoulders / 60 / 320
				{ 3, 19089 }, --Blue Dragonscale Shoulders / 59 / 315
				{ 4, 10564 }, --Tough Scorpid Shoulders / 48 / 260
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[LEATHER_DIFF] = {
				{ 1, 23709 }, --Corehound Belt / 70 / 320
				{ 2, 23710 }, --Molten Belt / 70 / 320
				{ 3, 28474 }, --Bramblewood Belt / 70 / 320
				{ 4, 23707 }, --Lava Belt / 66 / 320
				{ 5, 22921 }, --Girdle of Insight / 62 / 320
				{ 6, 19092 }, --Wicked Leather Belt / 60 / 320
				{ 7, 23703 }, --Might of the Timbermaw / 58 / 310
				{ 8, 19072 }, --Runic Leather Belt / 56 / 300
				{ 9, 3779 }, --Barbaric Belt / 40 / 220
				{ 10, 9206 }, --Dusky Belt / 39 / 215
				{ 11, 3778 }, --Gem-studded Leather Belt / 37 / 205
				{ 12, 3775 }, --Guardian Belt / 34 / 190
				{ 13, 4097 }, --Raptor Hide Belt / 33 / 185
				{ 14, 3774 }, --Green Leather Belt / 32 / 180
				{ 15, 3767 }, --Hillman's Belt / 25 / 145
				{ 16, 3766 }, --Dark Leather Belt / 25 / 150
				{ 17, 7955 }, --Deviate Scale Belt / 23 / 140
				{ 18, 6702 }, --Murloc Scale Belt / 18 / 120
				{ 19, 3763 }, --Fine Leather Belt / 16 / 110
				{ 20, 3753 }, --Handstitched Leather Belt / 10 / 55
			},
			[MAIL_DIFF] = {
				{ 1, 19070 }, --Heavy Scorpid Belt / 56 / 300
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[LEATHER_DIFF] = {
				{ 1, 28221 }, --Polar Bracers / 80 / 320
				{ 2, 24123 }, --Primal Batskin Bracers / 65 / 320
				{ 3, 19065 }, --Runic Leather Bracers / 55 / 295
				{ 4, 19052 }, --Wicked Leather Bracers / 53 / 285
				{ 5, 3777 }, --Guardian Leather Bracers / 39 / 215
				{ 6, 9202 }, --Green Whelp Bracers / 38 / 210
				{ 7, 6705 }, --Murloc Scale Bracers / 38 / 210
				{ 8, 9201 }, --Dusky Bracers / 37 / 205
				{ 9, 3776 }, --Green Leather Bracers / 36 / 200
				{ 10, 23399 }, --Barbaric Bracers / 32 / 175
				{ 11, 9065 }, --Light Leather Bracers / 14 / 100
				{ 12, 9059 }, --Handstitched Leather Bracers / 9 / 40
			},
			[MAIL_DIFF] = {
				{ 1, 28224 }, --Icy Scale Bracers / 80 / 320
				{ 2, 24849 }, --Sandstalker Bracers / 62 / 320
				{ 3, 22923 }, --Swift Flight Bracers / 62 / 320
				{ 4, 24846 }, --Spitfire Bracers / 62 / 320
				{ 5, 19048 }, --Heavy Scorpid Bracers / 51 / 275
				{ 6, 10533 }, --Tough Scorpid Bracers / 44 / 240
				{ 7, 10518 }, --Turtle Scale Bracers / 42 / 230
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 14932 }, --Thick Leather Ammo Pouch / 45 / 245
				{ 2, 9194 }, --Heavy Leather Ammo Pouch / 35 / 170
				{ 3, 9062 }, --Small Leather Ammo Pouch / 5 / 60
				{ 5, 14930 }, --Quickdraw Quiver / 45 / 245
				{ 6, 9193 }, --Heavy Quiver / 35 / 170
				{ 7, 9060 }, --Light Leather Quiver / 5 / 60
				{ 16, 5244 }, --Kodo Hide Bag / 5 / 70
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 22331 }, --Rugged Leather / 50 / 250
				{ 2, 20650 }, --Thick Leather / 40 / 200
				{ 3, 20649 }, --Heavy Leather / 30 / 150
				{ 4, 20648 }, --Medium Leather / 20 / 100
				{ 5, 2881 }, --Light Leather / 10 / 20
				{ 7, 22727 }, --Core Armor Kit / 60 / 320
				{ 8, 19058 }, --Rugged Armor Kit / 50 / 250
				{ 9, 10487 }, --Thick Armor Kit / 40 / 220
				{ 10, 3780 }, --Heavy Armor Kit / 30 / 170
				{ 11, 2165 }, --Medium Armor Kit / 15 / 115
				{ 12, 2152 }, --Light Armor Kit / 5 / 30
				{ 16, 19047 }, --Cured Rugged Hide / 50 / 250
				{ 17, 10482 }, --Cured Thick Hide / 40 / 200
				{ 18, 3818 }, --Cured Heavy Hide / 30 / 160
				{ 19, 3817 }, --Cured Medium Hide / 20 / 115
				{ 20, 3816 }, --Cured Light Hide / 10 / 55
				{ 22, 23190 }, --Heavy Leather Ball / 1 / 150
			},
		},
	}
}

data["Mining"] = {
	name = ALIL["Mining"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.MINING_LINK,
	items = {
		{
			name = AL["Smelting"],
			[NORMAL_DIFF] = {
				{ 1, 22967 }, --Smelt Elementium / 310
				{ 2, 16153 }, --Smelt Thorium / 250
				{ 3, 10098 }, --Smelt Truesilver / 230
				{ 4, 14891 }, --Smelt Dark Iron / 230
				{ 5, 10097 }, --Smelt Mithril / 175
				{ 6, 3308 }, --Smelt Gold / 170
				{ 7, 3569 }, --Smelt Steel / 165
				{ 8, 3307 }, --Smelt Iron / 130
				{ 9, 2658 }, --Smelt Silver / 100
				{ 10, 2659 }, --Smelt Bronze / 65
				{ 11, 3304 }, --Smelt Tin / 50
				{ 12, 2657 }, --Smelt Copper / 25
				{ 16, "INV_Box_01", nil, AL["SoD Phase 6"], nil },
				{ 17, 1213638 }, -- Obsidian-Infused Thorium Bar
			}
		},
	}
}

data["Herbalism"] = {
	name = ALIL["Herbalism"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.HERBALISM_LINK,
	items = {
		{
			name = AL["Artisan"],
			[NORMAL_DIFF] = {
				{ 1,  13467 }, -- Icecap
				{ 2,  13466 }, -- Plaguebloom
				{ 3,  13465 }, -- Mountain Silversage
				{ 4,  13463 }, -- Dreamfoil
				{ 5,  13464 }, -- Golden Sansam
				{ 6, 8846 }, -- Gromsblood
				{ 7, 8845 }, -- Ghost Mushroom
				{ 8, 8839 }, -- Blindweed
				{ 9, 8838 }, -- Sungrass
				{ 14, "INV_Box_01", nil, AL["SoD Phase 6"], nil },
				{ 15,  234012 }, -- Hive Thistle
				{ 16,  13468 }, -- Black Lotus
				{ 18,  19727 }, -- Blood Scythe
				{ 19,  19726 }, -- Bloodvine
			}
		},
		{
			name = AL["Expert"],
			[NORMAL_DIFF] = {
				{ 1, 8836 }, -- Arthas' Tears
				{ 2, 8831, 8153 }, -- Purple Lotus
				{ 3, 4625 }, -- Firebloom
				{ 4, 3819 }, -- Wintersbite
				{ 5, 3358 }, -- Khadgar's Whisker
				{ 6, 3821 }, -- Goldthorn
				{ 7, 3818 }, -- Fadeleaf
				--{ 17, 8153 }, -- Wildvine
			}
		},
		{
			name = AL["Journeyman"],
			[NORMAL_DIFF] = {
				{ 1, 3357 }, -- Liferoot
				{ 2, 3356 }, -- Kingsblood
				{ 3, 3369 }, -- Grave Moss
				{ 4, 3355 }, -- Wild Steelbloom
				{ 5, 2453 }, -- Bruiseweed
				{ 6, 3820 }, -- Stranglekelp
			}
		},
		{
			name = AL["Apprentice"],
			[NORMAL_DIFF] = {
				{ 1,  2450, 2452 }, -- Briarthorn
				{ 2,  785, 2452 }, -- Mageroyal
				{ 3,  2449 }, -- Earthroot
				{ 4,  765 }, -- Silverleaf
				{ 5,  2447 }, -- Peacebloom
				--{ 16,  2452 }, -- Swiftthistle
			}
		},
	}
}

data["Cooking"] = {
	name = ALIL["Cooking"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.COOKING_LINK,
	items = {
		{
			name = AL["SoD Phase 1-8"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Phase 6"], nil },
				{ 2, 470359 }, --Darkclaw Bisque
				{ 3, 470370 }, --Smoked Redgill
				{ 5, "INV_Box_01", nil, AL["Phase 8"], nil },
				{ 6, 1225762 }, -- Smoked Redgill
				{ 7, 1225763 }, -- Grand Lobster Banquet
			},
		},
		{
			name = ALIL["Stamina"],
			[NORMAL_DIFF] = {
				{ 1, 25659 }, --Dirge / 325
				{ 2, 18246 }, --Mightfish Steak / 315
				{ 3, 18239 }, --Cooked Glossy Mightfish / 265
			},
		},
		{
			name = ALIL["Intellect"],
			[NORMAL_DIFF] = {
				{ 1, 22761 }, --Runn Tum Tuber Surprise / 315
			},
		},
		{
			name = ALIL["Agility"],
			[NORMAL_DIFF] = {
				{ 1, 18240 }, --Grilled Squid / 280
			},
		},
		{
			name = ALIL["Strength"],
			[NORMAL_DIFF] = {
				{ 1, 24801 }, --Smoked Desert Dumplings / 325
			},
		},
		{
			name = ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 18242 }, --Hot Smoked Bass / 280
			},
		},
		{
			name = ALIL["Stamina"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 15933 }, --Monster Omelet / 265
				{ 2, 22480 }, --Tender Wolf Steak / 265
				{ 3, 15915 }, --Spiced Chili Crab / 265
				{ 4, 15910 }, --Heavy Kodo Stew / 240
				{ 5, 21175 }, --Spider Sausage / 240
				{ 6, 15855 }, --Roast Raptor / 215
				{ 7, 15863 }, --Carrion Surprise / 215
				{ 8, 4094 }, --Barbecued Buzzard Wing / 215
				{ 9, 7213 }, --Giant Clam Scorcho / 215
				{ 10, 15861 }, --Jungle Stew / 215
				{ 11, 15856 }, --Hot Wolf Ribs / 215
				{ 12, 3400 }, --Soothing Turtle Bisque / 215
				{ 13, 15865 }, --Mystery Stew / 215
				{ 14, 3399 }, --Tasty Lion Steak / 190
				{ 15, 3398 }, --Hot Lion Chops / 175
				{ 16, 3376 }, --Curiously Tasty Omelet / 170
				{ 17, 15853 }, --Lean Wolf Steak / 165
				{ 18, 6500 }, --Goblin Deviled Clams / 165
				{ 19, 24418 }, --Heavy Crocolisk Stew / 160
				{ 20, 3373 }, --Crocolisk Gumbo / 160
				{ 21, 3397 }, --Big Bear Steak / 150
				{ 22, 3377 }, --Gooey Spider Cake / 150
				{ 23, 6419 }, --Lean Venison / 150
				{ 24, 6418 }, --Crispy Lizard Tail / 140
				{ 25, 2549 }, --Seasoned Wolf Kabob / 140
				{ 26, 2547 }, --Redridge Goulash / 135
				{ 27, 3372 }, --Murloc Fin Soup / 130
				{ 28, 3370 }, --Crocolisk Steak / 120
				{ 29, 2546 }, --Dry Pork Ribs / 120
				{ 30, 2544 }, --Crab Cake / 115
				{ 101, 3371 }, --Blood Sausage / 100
				{ 102, 6416 }, --Strider Stew / 90
				{ 103, 2542 }, --Goretusk Liver Pie / 90
				{ 104, 2541 }, --Coyote Steak / 90
				{ 105, 6499 }, --Boiled Clams / 90
				{ 106, 6415 }, --Fillet of Frenzy / 90
				{ 107, 21144 }, --Egg Nog / 75
				{ 108, 6414 }, --Roasted Kodo Meat / 75
				{ 109, 2795 }, --Beer Basted Boar Ribs / 60
				{ 110, 2539 }, --Spiced Wolf Meat / 50
				{ 111, 6412 }, --Kaldorei Spider Kabob / 50
				{ 112, 15935 }, --Crispy Bat Wing / 45
				{ 113, 8604 }, --Herb Baked Egg / 45
				{ 114, 21143 }, --Gingerbread Cookie / 45
			},
		},
		{
			name = ALIL["Mana Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 18243 }, --Nightfin Soup / 290
				{ 2, 25954 }, --Sagefish Delight / 215
				{ 3, 25704 }, --Smoked Sagefish / 120
			},
		},
		{
			name = ALIL["Health Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 18244 }, --Poached Sunscale Salmon / 290
			},
		},
		{
			name = ALIL["Food"],
			[NORMAL_DIFF] = {
				{ 1, 18245 }, --Lobster Stew / 315
				{ 2, 18238 }, --Spotted Yellowtail / 315
				{ 3, 18247 }, --Baked Salmon / 265
				{ 4, 6501 }, --Clam Chowder / 265
				{ 5, 18241 }, --Filet of Redgill / 265
				{ 6, 20916 }, --Mithril Headed Trout / 215
				{ 7, 7828 }, --Rockscale Cod / 190
				{ 8, 7755 }, --Bristle Whisker Catfish / 140
				{ 9, 20626 }, --Undermine Clam Chowder / 130
				{ 10, 2548 }, --Succulent Pork Ribs / 130
				{ 11, 6417 }, --Dig Rat Stew / 130
				{ 12, 2545 }, --Cooked Crab Claw / 125
				{ 13, 2543 }, --Westfall Stew / 115
				{ 14, 7827 }, --Rainbow Fin Albacore / 90
				{ 15, 7754 }, --Loch Frenzy Delight / 90
				{ 16, 7753 }, --Longjaw Mud Snapper / 90
				{ 17, 8607 }, --Smoked Bear Meat / 80
				{ 18, 6413 }, --Scorpid Surprise / 60
				{ 19, 7752 }, --Slitherskin Mackerel / 45
				{ 20, 2538 }, --Charred Wolf Meat / 45
				{ 21, 7751 }, --Brilliant Smallfish / 45
				{ 22, 2540 }, --Roasted Boar Meat / 45
			},
		},
		{
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 15906 }, --Dragonbreath Chili / 240
				{ 2, 8238 }, --Savory Deviate Delight / 125
				{ 3, 9513 }, --Thistle Tea / 100
				{ 16, 13028 }, --Goldthorn Tea / 215
			},
		},
	}
}

data["FirstAid"] = {
	name = ALIL["First Aid"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.FIRSTAID_LINK,
	items = {
		{
			name = ALIL["First Aid"],
			[NORMAL_DIFF] = {
				{ 1, 18630 }, --Heavy Runecloth Bandage / 290
				{ 2, 18629 }, --Runecloth Bandage / 260
				{ 3, 10841 }, --Heavy Mageweave Bandage / 240
				{ 4, 10840 }, --Mageweave Bandage / 210
				{ 5, 7929 }, --Heavy Silk Bandage / 180
				{ 6, 7928 }, --Silk Bandage / 150
				{ 7, 3278 }, --Heavy Wool Bandage / 115
				{ 8, 3277 }, --Wool Bandage / 80
				{ 9, 3276 }, --Heavy Linen Bandage / 50
				{ 10, 3275 }, --Linen Bandage / 30
				{ 14, "INV_Box_01", nil, AL["Phase 6"], nil },
				{ 15, 470349 }, --Dense Runecloth Bandage / 300
				{ 16, 23787 }, --Powerful Anti-Venom / 300
				{ 17, 7935 }, --Strong Anti-Venom / 130
				{ 18, 7934 }, --Anti-Venom / 80
			}
		},
	}
}

data["Fishing"] = {
	name = ALIL["Fishing"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.FISHING_LINK,
	items = {
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
				{ 1, 6533 }, --  Aquadynamic Fish Attractor
				{ 2, 6532 }, --  Bright Baubles
				{ 3, 7307 }, --  Flesh Eating Worm
				{ 4, 6811 }, --  Aquadynamic Fish Lens
				{ 5, 6530 }, --  Nightcrawlers
				{ 16, 19971 }, -- High Test Eternium Fishing Line
				{ 29, 16082 }, -- Artisan Fishing - The Way of the Lure
				{ 30, 16083 }, -- Expert Fishing - The Bass and You
			}
		},
		{
			name = ALIL["Fishing Pole"],
			[NORMAL_DIFF] = {
				{ 1, 19970 }, -- Arcanite Fishing Pole
				{ 2, 19022 }, -- Nat Pagle's Extreme Angler FC-5000
				{ 3, 6367 }, -- Big Iron Fishing Pole
				{ 4, 6366 }, -- Darkwood Fishing Pole
				{ 5, 6365 }, -- Strong Fishing Pole
				{ 6, 12225 }, -- Blump Family Fishing Pole
				{ 7, 6256 }, -- Fishing Pole
			}
		},
		{
			name = AL["Fishes"],
			[NORMAL_DIFF] = {
				{ 1, 13888 }, -- Darkclaw Lobster
				{ 2, 13890 }, -- Plated Armorfish
				{ 3, 13889 }, -- Raw Whitescale Salmon
				{ 4, 13754 }, -- Raw Glossy Mightfish
				{ 5, 13759 }, -- Raw Nightfin Snapper
				{ 6, 13758 }, -- Raw Redgill
				{ 7, 4603 }, -- Raw Spotted Yellowtail
				{ 8, 13756 }, -- Raw Summer Bass
				{ 9, 13760 }, -- Raw Sunscale Salmon
				{ 10, 7974 }, -- Zesty Clam Meat
				{ 11, 21153 }, -- Raw Greater Sagefish
				{ 12, 8365 }, -- Raw Mithril Head Trout
				{ 13, 6362 }, -- Raw Rockscale Cod
				{ 14, 6308 }, -- Raw Bristle Whisker Catfish
				{ 15, 21071 }, -- Raw Sagefish
				{ 16, 6317 }, -- Raw Loch Frenzy
				{ 17, 6289 }, -- Raw Longjaw Mud Snapper
				{ 18, 6361 }, -- Raw Rainbow Fin Albacore
				{ 19, 6291 }, -- Raw Brilliant Smallfish
				{ 20, 6303 }, -- Raw Slitherskin Mackerel
			}
		},
	}
}

data["RoguePoisons"] = {
	name = format("|c%s%s|r", RAID_CLASS_COLORS["ROGUE"].colorStr, ALIL["ROGUE"]),
	ContentType = PROF_CLASS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ROGUE_POISONS_LINK,
	items = {
		{
			name = ALIL["SoD"],
			[NORMAL_DIFF] = {
				{ 1, 439503 }, -- Atrophic Poison
				{ 2, 439505 }, -- Numbing Poison
				{ 3, 439500  }, -- Sebacious Poison
				{ 4, 458822 }, -- Occult Poison I
				{ 5, 1214168  }, -- Occult Poison II
			}
		},
		{
			name = ALIL["Poisons"],
			[NORMAL_DIFF] = {
				{ 1, 11343 }, -- Instant Poison VI
				{ 2, 11342 }, -- Instant Poison V
				{ 3, 11341 }, -- Instant Poison IV
				{ 4, 8691  }, -- Instant Poison III
				{ 5, 8687  }, -- Instant Poison II
				{ 6, 8681  }, -- Instant Poison
				{ 8, 13230 },  -- Wound Poison IV
				{ 9, 13229 },  -- Wound Poison III
				{ 10, 13228 }, -- Wound Poison II
				{ 11, 13220 }, -- Wound Poison
				{ 13, 3420  }, -- Crippling Poison
				{ 17, 25347 }, -- Deadly Poison V
				{ 18, 11358 }, -- Deadly Poison IV
				{ 19, 11357 }, -- Deadly Poison III
				{ 20, 2837  }, -- Deadly Poison II
				{ 21, 2835  }, -- Deadly Poison
				{ 24, 11400 }, -- Mind-numbing Poison III
				{ 25, 8694  }, -- Mind-numbing Poison II
				{ 26, 5763  }, -- Mind-numbing Poison
				{ 28, 6510  }, -- Blinding Powder
			}
		},
	}
}
