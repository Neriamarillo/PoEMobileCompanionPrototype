//
//  ItemModel.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct ItemModel {
    let id: Int
    let name: String
    let icon: String?
    let priceInChaos: Double
    let priceInExalt: Double?
    let totalChange: Double
    let gemLevel: Int?
    let gemQuality: Int?
    let flavourText: String?
    let itemCategory: String
    let itemLevel: Int?
    let influence: String?
    let tradeId: String?
    let itemBaseType: String?
    let itemType: String?
    
    var valueString: String {
        return String(format: ".1f", priceInChaos)
    }
    
    var totalChangeString: String {
        return String(totalChange).replacingOccurrences(of: "+", with: "")
    }
    
    var flavourTextString: String? {
        return (flavourText?.replacingOccurrences(of: "\n", with: " "))
    }
}
