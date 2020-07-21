//
//  ItemManager.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/8/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

protocol ItemManagerDelegate {
    
    func didFetchCurrency(_ currencyManager: ItemManager, currencies: [ItemModel])
    func didFetchItems(_ itemManager: ItemManager, items: [ItemModel])
    func didFailWithError(error: Error)
}


struct ItemManager {
    let apiURL = "https://poe.ninja/api/data/"
    let leagueName = "Harvest"
    
    
    var delegate: ItemManagerDelegate?
    
    
    mutating func fetchItems(itemType: String)  {
        var itemTypeOverview: String
        if (itemType == "Currency" || itemType == "Fragment") {
            itemTypeOverview = "currencyoverview"
        } else {
            itemTypeOverview = "itemoverview"
        }
        print("ItemOverview: \(itemTypeOverview)) and ItemType: \(itemType)")
        
        let urlString = "\(apiURL)\(itemTypeOverview)?league=\(leagueName)&type=\(itemType)" // gets the list of currencies
        //        let urlString = "\(apiURL)currencyhistory?league=\(leagueName)&type=\(itemType)&currencyId=2" // gets graph data for currency
        performRequest(with: urlString, itemTypeOverview: itemTypeOverview)
    }
    
    func performRequest(with urlString: String, itemTypeOverview: String ) {
        if let url = URL(string: urlString) {
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
                                self.delegate?.didFetchItems(self, items: items)
                        }
                        default:
                            if let currencies = self.parseCurrencyJSON(safeData) {
                                self.delegate?.didFetchCurrency(self, currencies: currencies)
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
            for item in decodedData.info {
                let id = item.id
                let name = item.name
                let value = item.chaosValue
                let totalChange = item.sparkline.totalChange
                let icon = item.icon
                let exaltValue = item.exaltedValue
                let gemLevel = item.gemLevel
                let gemQuality = item.gemQuality
                let parsedItem = ItemModel(id: id, name: name, icon: icon, priceInChaos: value, priceInExalt: exaltValue, totalChange: totalChange, gemLevel: gemLevel, gemQuality: gemQuality)
//                let parsedItem = ItemModel(id: id, name: name, icon: icon, priceInChaos: value, totalChange: totalChange)
                itemArray.append(parsedItem)
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
            for item in decodedData.info {
                let id = item.receive.id
                let name = item.name
                let value = item.chaosValue
                let totalChange = item.sparkLine.totalChange
                let icon = decodedData.details[id - 1].icon
                let exaltValue = 0.0
                let gemLevel = 0
                let gemQuality = 0
                let currencyItem = ItemModel(id: id, name: name, icon: icon, priceInChaos: value, priceInExalt: exaltValue, totalChange: totalChange, gemLevel: gemLevel, gemQuality: gemQuality)
//                let currencyItem = ItemModel(id: id, name: name, icon: icon, priceInChaos: value, totalChange: totalChange)
                currencyArray.append(currencyItem)
            }
            return currencyArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
