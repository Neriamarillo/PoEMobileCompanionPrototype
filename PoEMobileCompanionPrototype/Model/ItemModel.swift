//
//  ItemModel.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

//MARK: - Unified Model
struct ItemModel {
    var id: Int
    var name: String
    var icon: String?
    var mapTier: Int?
    var levelRequired: Int?
    var baseType: String?
    var stackSize: Int?
    var variant: String?
    var prophecyText: String?
    var links: Int?
    var itemClass: Int?
    var flavourText: String?
    var corrupted: Bool
    var gemLevel: Int?
    var gemQuality: Int?
    var itemType: String?
    var priceInChaos: Double
    var exaltedValue: Double?
    var totalChange: Double
    var count: Int?
    var detailsId: String?
    var mapRegion: String?
    var itemCategory: String
    
    var valueString: String  {
        return String(format: ".1f", priceInChaos)
    }
    var totalChangeString: String {
        return String(totalChange).replacingOccurrences(of: "+", with: "")
    }
    var flavourTextString: String? {
        return (flavourText?.replacingOccurrences(of: "\n", with: " "))
    }
}

