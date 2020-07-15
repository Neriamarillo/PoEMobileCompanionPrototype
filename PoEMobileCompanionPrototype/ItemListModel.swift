//
//  ItemListModel.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/9/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct ItemListModel {
    var itemTypes: [String] = ["Currency", "Fragment", "DeliriumOrb", "Watchstone", "Oil",
                               "Incubator", "Scarab", "Fossil", "Resonator", "Essence", "DivinationCard",
                               "Prophecy", "SkillGem", "BaseType", "HelmetEnchant", "UniqueMap", "Map", "UniqueJewel",
                               "UniqueFlask", "UniqueWeapon", "UniqueArmour", "UniqueAccessory", "Beast", "Vial"]
    
    var itemIcons: [String] = ["CurrencyIcon", "FragmentIcon", "DeliriumOrbIcon", "WatchstoneIcon", "OilIcon",
                               "IncubatorIcon", "ScarabIcon", "FossilIcon", "ResonatorIcon", "EssenceIcon", "DivCardIcon",
                               "ProphecyIcon", "SkillGemIcon", "BaseTypeIcon", "EnchantIcon", "UniqueMapIcon", "MapIcon",
                               "UniqueJewelIcon", "UniqueFlaskIcon", "UniqueWeaponIcon", "UniqueArmourIcon",
                               "UniqueAccessoryIcon", "BeastIcon", "VialIcon"]
    
    //    var isCurrencyOrItem: [String] = ["currencyoverview", "itemoverview"]
    
    var itemTypeStrings: [String] = ["Currency", "Fragments", "Delirium Orbs", "Watchstones", "Oils",
                                     "Incubators", "Scarabs", "Fossils", "Resonators", "Essences", "Divination Cards",
                                     "Prophecies", "Skill Gems", "Base Types", "Helmet Enchants", "Unique Maps", "Maps", "Unique Jewels",
                                     "Unique Flasks", "Unique Weapons", "Unique Armours", "Unique Accessories", "Beasts", "Vials"]
    
}
// Figure out how to call each item from the tableView and pick the correct itemType and identify wether it isCurrencyOrItem to add to the url.
