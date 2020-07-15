//
//  CurrencyData.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/8/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct CurrencyData: Codable {
    let lines: [CurrencyItem]
    let currencyDetails: [CurrencyDetails]
}

struct CurrencyItem: Codable {
    let currencyTypeName: String
    let receive: Buy
    let chaosEquivalent: Double
    let receiveSparkLine: CurrencySparkLine
    let detailsId: String
}

struct Buy: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case leagueId = "league_id"
        case payCurrencyId = "pay_currency_id"
        case getCurrencyId = "get_currency_id"
        case value
    }
    let id: Int
    let leagueId: Int
    let payCurrencyId: Int
    let getCurrencyId: Int
    let value: Float
}

struct CurrencySparkLine: Codable {
    let data: [Float]
    let totalChange: Double
}

struct CurrencyDetails: Codable {
    let id: Int
    let icon: String
    let name: String
    
}
