//
//  ItemData.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/13/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct ItemData: Codable {
    let lines: [Item]
}

struct Item: Codable {
    let id: Float
    let name: String
    let icon: String?
    let mapTier: Int?
    let sparkline: ItemSparkLine
    let chaosValue: Double
    let exaltedValue: Double
}

struct ItemSparkLine: Codable {
    let data: [Float?]
    let totalChange: Double?
}
