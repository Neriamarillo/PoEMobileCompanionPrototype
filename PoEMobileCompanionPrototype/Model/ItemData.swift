//
//  ItemData.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/13/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

//MARK: - ItemData
struct ItemData: Decodable {
    var lines: [Item]?
}

//MARK: - Item Line
struct Item: Decodable {
    var id: Int
    var name: String
    var icon: String?
    var mapTier: Int?
    var levelRequired: Int?
    var baseType: String?
    var stackSize: Int?
    var variant: String?
    var prophecyText: String?
    var artFilename: String?
    var links: Int?
    var itemClass: Int?
    var sparkline: Sparkline
    var implicitModifiers: [Mods?]
    var explicitModifiers: [Mods?]
    var flavourText: String?
    var corrupted: Bool
    var gemLevel: Int?
    var gemQuality: Int?
    var itemType: String?
    var chaosValue: Double
    var exaltedValue: Double?
    var count: Int?
    var detailsId: String?
    var tradeInfo: TradeInfo?
    var mapRegion: String?
    
    func getItemBaseType(itemCategory: String) -> String {
        switch itemCategory {
            case "Watchstone":
                return "Ivory Watchstone"
            default:
                return baseType ?? ""
        }
    }
}

//MARK: - Sparkline
struct Sparkline: Decodable {
    var data: [Float?]
    var totalChange: Double
}

//MARK: - Mods
struct Mods: Decodable {
    var text: String?
    var optional: Bool
}

//MARK: - TradeInfo
struct TradeInfo: Decodable {
    var mod: String
    var min: Int
    var max: Int
}
