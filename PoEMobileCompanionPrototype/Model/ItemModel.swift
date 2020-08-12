//
//  ItemModel.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

//MARK: - Old code
struct ItemModel {
    let id: Int
    let name: String
    let icon: String?
    let priceInChaos: Double
    let priceInExalt: Double
    let totalChange: Double
    let tradeId: String?
    let gemLevel: Int?
    let gemQuality: Int?
    let flavourText: String?
    let itemCategory: String
    let itemLevel: Int?
    let influence: String?
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

////MARK: - Test
//protocol ItemProtocol: Codable {
//    static var type: String { get }
//    var id: Int { get }
//    var name: String { get }
//    var icon: String? { get }
//    var priceInChaos: Double { get }
//    var totalChange: Double { get }
//    var valueString: String { get }
//    var totalChangeString: String { get }
//    var itemCategory: String { get }
//}
//
//struct CurrencyModel: ItemProtocol {
//    public static var type: String { return "currency" }
//    let id: Int
//    var name: String
//    var icon: String?
//    var priceInChaos: Double
//    var totalChange: Double
//    var tradeId: String?
//    var itemCategory: String
//
//    var valueString: String  {
//        return String(format: ".1f", priceInChaos)
//    }
//
//    var totalChangeString: String {
//        return String(totalChange).replacingOccurrences(of: "+", with: "")
//    }
//}
//
//struct ItemModel: ItemProtocol {
//    public static var type: String { return "item" }
//    let id: Int
//    var name: String
//    var icon: String?
//    var priceInChaos: Double
//    var priceInExalt: Double?
//    var totalChange: Double
//    var gemLevel: Int?
//    var gemQuality: Int?
//    var flavourText: String?
//    var itemLevel: Int?
//    var influence: String?
//    var itemBase: String?
//    var itemCategory: String
//
//    var valueString: String  {
//        return String(format: ".1f", priceInChaos)
//    }
//
//    var totalChangeString: String {
//        return String(totalChange).replacingOccurrences(of: "+", with: "")
//    }
//
//    var flavourTextString: String? {
//        return (flavourText?.replacingOccurrences(of: "\n", with: " "))
//    }
//}
