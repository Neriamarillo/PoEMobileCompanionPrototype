//
//  CurrencyData.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/8/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct CurrencyData: Codable {
    let info: [Currency]?
    let details: [CurrencyDetails]
    
    enum CodingKeys: String, CodingKey {
        case info = "lines"
        case details = "currencyDetails"
    }
}

struct Currency: Codable {
    let name: String
    let pay: Buy?
    let receive: Buy?
    let chaosValue: Double
    let sparkLine: CurrencySparkLine
    
    enum CodingKeys: String, CodingKey {
        case name = "currencyTypeName"
        case pay
        case receive
        case chaosValue = "chaosEquivalent"
        case sparkLine = "receiveSparkLine"
    }
}

struct Buy: Codable {
    let payId: Int?
    let buyId: Int?
    let leagueId: Int
    
    enum CodingKeys: String, CodingKey {
        case payId = "pay_currency_id"
        case buyId = "get_currency_id"
        case leagueId = "league_id"
    }
}

struct CurrencySparkLine: Codable {
    let data: [Float?]
    let totalChange: Double
}

struct CurrencyDetails: Codable {
    let id: Float
    let icon: String
    let name: String
}
