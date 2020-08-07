//
//  ItemManager.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/8/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

protocol ItemManagerDelegate {
    func didFetchCurrency(currencies: [ItemModel])
    func didFetchItems(items: [ItemModel])
    func didFailWithError(error: Error)
}

struct ItemManager {
    let apiURL = "https://poe.ninja/api/data/"
    var itemCategory: String!
    var delegate: ItemManagerDelegate?
    
    mutating func fetchItems(itemCategory: String, leagueName: String)  {
        var itemTypeOverview: String
        self.itemCategory = itemCategory
        if (self.itemCategory == "Currency" || self.itemCategory == "Fragment") {
            itemTypeOverview = "currencyoverview"
        } else {
            itemTypeOverview = "itemoverview"
        }
        let originalUrl = "\(apiURL)\(itemTypeOverview)?league=\(leagueName)&type=\(itemCategory)"
        let urlString = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        performRequest(with: urlString!, itemTypeOverview: itemTypeOverview)
    }
    
    func performRequest(with urlString: String, itemTypeOverview: String ) {
        if let url = URL(string: urlString) {
            print("URL: \(url)")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    switch itemTypeOverview {
                        case "itemoverview":
                            if let items = self.parseItemJSON(safeData) {
                                self.delegate?.didFetchItems(items: items)
                        }
                        default:
                            if let currencies = self.parseCurrencyJSON(safeData) {
                                self.delegate?.didFetchCurrency(currencies: currencies)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseItemJSON(_ itemData: Data) -> [ItemModel]? {
        var itemArray = [ItemModel]()
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ItemData.self, from: itemData)
            if !decodedData.info!.isEmpty {
                for item in decodedData.info! {
                    let id = item.id
                    let name = item.name
                    let value = item.chaosValue
                    let totalChange = item.sparkline.totalChange
                    let icon = item.icon
                    let exaltValue = item.exaltedValue
                    let gemLevel = item.gemLevel
                    let gemQuality = item.gemQuality
                    let flavourText = item.flavourText
                    let itemLevel = item.levelRequired
                    let influence = item.variant
                    let tradeId = ""
                    var itemBaseType = ""
                    if let baseType = item.baseType {
                        itemBaseType = baseType
                    }
                    let itemType = item.itemType
                    
                    let parsedItem = ItemModel(id: id, name: name, icon: icon, priceInChaos: value, priceInExalt: exaltValue, totalChange: totalChange, gemLevel: gemLevel, gemQuality: gemQuality, flavourText: flavourText, itemCategory: self.itemCategory, itemLevel: itemLevel, influence: influence, tradeId: tradeId, itemBaseType: itemBaseType, itemType: itemType)
                    itemArray.append(parsedItem)
                }
            }
            return itemArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseCurrencyJSON(_ currencyData: Data) -> [ItemModel]? {
        var currencyArray = [ItemModel]()
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            if !(decodedData.info!.isEmpty) {
                for item in decodedData.info! {
                    var id: Int?
                    if let idCheck = item.pay?.payId {
                        id = idCheck
                    } else {
                        id = item.receive?.buyId
                    }
                    print("Item id: \(id!)")
                    let itemDetails = decodedData.details[id! - 1]
                    let name = item.name
                    let value = item.chaosValue
                    let totalChange = item.sparkLine.totalChange
                    let icon = itemDetails.icon
                    let exaltValue = 0.0
                    let gemLevel = 0
                    let gemQuality = 0
                    let flavourText = ""
                    let itemLevel = 0
                    let influence = ""
                    var tradeId: String!
                    if let tradeIdCheck = itemDetails.tradeId {
                        tradeId = tradeIdCheck
                    }
                    let itemBaseType = ""
                    let itemType = ""
                    let currencyItem = ItemModel(id: id!, name: name, icon: icon, priceInChaos: value, priceInExalt: exaltValue, totalChange: totalChange, gemLevel: gemLevel, gemQuality: gemQuality, flavourText: flavourText, itemCategory: self.itemCategory, itemLevel: itemLevel, influence: influence, tradeId: tradeId, itemBaseType: itemBaseType, itemType: itemType)
                    currencyArray.append(currencyItem)
                }
            }
            return currencyArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
