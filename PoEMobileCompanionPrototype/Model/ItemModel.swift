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
    
    var valueString: String {
        return String(format: ".1f", priceInChaos)
    }
}
