//
//  ItemData.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/13/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct ItemData: Codable {
    let info: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case info = "lines"
    }
}

struct Item: Codable {
    let id: Int
    let name: String
    let icon: String?
    let mapTier: Int?
    let sparkline: ItemSparkLine
    let chaosValue: Double
    let exaltedValue: Double
    let gemLevel: Int
    let gemQuality: Int
    let flavourText: String?
    let levelRequired: Int?
    let variant: String?
    let baseType: String?
    let itemType: String?
}

struct ItemSparkLine: Codable {
    let data: [Float?]
    let totalChange: Double
}
