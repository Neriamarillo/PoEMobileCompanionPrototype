//
//  ItemListModel.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/9/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct ItemListModel {
    static var itemTypes: [String] = ["Currency", "Fragment", "DeliriumOrb", "Watchstone", "Oil",
                                      "Incubator", "Scarab", "Fossil", "Resonator", "Essence", "DivinationCard",
                                      "Prophecy", "SkillGem", "BaseType", "HelmetEnchant", "UniqueMap", "Map", "UniqueJewel",
                                      "UniqueFlask", "UniqueWeapon", "UniqueArmour", "UniqueAccessory", "Beast", "Vial"]
    
    static var itemIcons: [String] = ["CurrencyIcon", "FragmentIcon", "DeliriumOrbIcon", "WatchstoneIcon", "OilIcon",
                                      "IncubatorIcon", "ScarabIcon", "FossilIcon", "ResonatorIcon", "EssenceIcon", "DivCardIcon",
                                      "ProphecyIcon", "SkillGemIcon", "BaseTypeIcon", "EnchantIcon", "UniqueMapIcon", "MapIcon",
                                      "UniqueJewelIcon", "UniqueFlaskIcon", "UniqueWeaponIcon", "UniqueArmourIcon",
                                      "UniqueAccessoryIcon", "BeastIcon", "VialIcon"]
    
    static var itemTypeStrings: [String] = ["Currency", "Fragments", "Delirium Orbs", "Watchstones", "Oils",
                                            "Incubators", "Scarabs", "Fossils", "Resonators", "Essences", "Divination Cards",
                                            "Prophecies", "Skill Gems", "Base Types", "Helmet Enchants", "Unique Maps", "Maps", "Unique Jewels",
                                            "Unique Flasks", "Unique Weapons", "Unique Armours", "Unique Accessories", "Beasts", "Vials"]
}
