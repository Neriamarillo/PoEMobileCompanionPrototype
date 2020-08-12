//
//  ItemListModel.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/9/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct ItemListModel {
    static let itemTypes: [String] = ["Currency", "Fragment", "DeliriumOrb", "Watchstone", "Oil", "Incubator", "Scarab", "Fossil", "Resonator", "Essence", "DivinationCard", "Prophecy", "SkillGem", "BaseType", "HelmetEnchant", "UniqueMap", "Map", "UniqueJewel", "UniqueFlask", "UniqueWeapon", "UniqueArmour", "UniqueAccessory", "Beast", "Vial"]
    
    static let itemIcons: [String] = ["CurrencyIcon", "FragmentIcon", "DeliriumOrbIcon", "WatchstoneIcon", "OilIcon", "IncubatorIcon", "ScarabIcon", "FossilIcon", "ResonatorIcon", "EssenceIcon", "DivCardIcon", "ProphecyIcon", "SkillGemIcon", "BaseTypeIcon", "EnchantIcon", "UniqueMapIcon", "MapIcon", "UniqueJewelIcon", "UniqueFlaskIcon", "UniqueWeaponIcon", "UniqueArmourIcon", "UniqueAccessoryIcon", "BeastIcon", "VialIcon"]
    
    static let itemTypeStrings: [String] = ["Currency", "Fragments", "Delirium Orbs", "Watchstones", "Oils", "Incubators", "Scarabs", "Fossils", "Resonators", "Essences", "Divination Cards", "Prophecies", "Skill Gems", "Base Types", "Helmet Enchants", "Unique Maps", "Maps", "Unique Jewels", "Unique Flasks", "Unique Weapons", "Unique Armours", "Unique Accessories", "Beasts", "Vials"]
    
    static let itemsWithNameAndType: [String] = ["Watchstone", "UniqueJewel", "UniqueFlask", "UniqueWeapon", "UniqueArmour", "UniqueAccessory"]
    
    static let itemsWithNameOnly: [String] = ["Prophecy", "UniqueMap"]
    
    static let itemsWithTypeOnly: [String] = ["DeliriumOrb", "Oil", "Incubator", "Scarab", "Fossil", "Resonator", "Essence", "DivinationCard", "SkillGem", "BaseType", "Beast", "Vial"]
    
    static let itemsInExchange: [String] = ["Currency", "Fragment"]
    
    static func getItemString(itemType: String) -> String! {
        let itemLocation = ItemListModel.itemTypes.firstIndex(of: itemType)!
        return ItemListModel.itemTypeStrings[itemLocation]
    }
    
    static func getItemTypeOverview(itemCategory: String) -> String {
        if itemsInExchange.contains(itemCategory) {
            return "currencyoverview"
        }
        return "itemoverview"
    }
    
    static func getItemType(itemCategory: String) -> String {
        if itemsInExchange.contains(itemCategory) {
            return "currency"
        }
        return "item"
    }
    
}
