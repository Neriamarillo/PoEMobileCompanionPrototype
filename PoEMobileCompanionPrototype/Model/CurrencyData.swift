//
//  CurrencyData.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/8/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

// MARK: - CurrencyData
struct CurrencyData: Decodable {
    let lines: [Currency]?
    let currencyDetails: [CurrencyDetail]?
}

// MARK: - Line
struct Currency: Decodable {
    let currencyTypeName: String
    let pay, receive: Pay?
    let receiveSparkLine: SparkLine
    let chaosEquivalent: Double
    let detailsID: String

    enum CodingKeys: String, CodingKey {
        case currencyTypeName, pay, receive, receiveSparkLine, chaosEquivalent
        case detailsID = "detailsId"
    }
}

// MARK: - SparkLine
struct SparkLine: Decodable {
    let data: [Double?]
    let totalChange: Double
}

// MARK: - Pay
struct Pay: Decodable {
    let id, payCurrencyID, getCurrencyID: Int?
    let value: Double

    enum CodingKeys: String, CodingKey {
        case id
        case payCurrencyID = "pay_currency_id"
        case getCurrencyID = "get_currency_id"
        case value
    }
}

// MARK: - CurrencyDetail
struct CurrencyDetail: Decodable {
    let id: Int
    let icon: String
    let name: String
    let poeTradeID: Int
    let tradeID: String?

    enum CodingKeys: String, CodingKey {
        case id, icon, name
        case poeTradeID = "poeTradeId"
        case tradeID = "tradeId"
    }
}
