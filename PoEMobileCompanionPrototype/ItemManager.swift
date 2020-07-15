//
//  ItemManager.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/8/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

protocol ItemManagerDelegate {
    
    func didFetchCurrency(_ currencyManager: ItemManager, currency: CurrencyModel)
    func didFetchItems(_ itemManager: ItemManager, items: [Item])
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
                            if let currency = self.parseCurrencyJSON(safeData) {
                                self.delegate?.didFetchCurrency(self, currency: currency)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
     func parseItemJSON(_ itemData: Data) -> [Item]? {
        var itemArray = [Item]()
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(ItemData.self, from: itemData)
            itemArray = decodedData.lines
//            let item = decodedData.lines[0]
//            let id = item.id
//            let name = item.name
//            let icon = item.icon
//            let chaosPrice = item.chaosValue
//            let exaltPrice = item.exaltedValue
//            let parsedItem = ItemModel(id: id, name: name, icon: icon, priceInChaos: chaosPrice, priceInExalt: exaltPrice)
//            return parsedItem
            return itemArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseCurrencyJSON(_ currencyData: Data) -> CurrencyModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            let item = decodedData.lines[0]
            let itemDetails = decodedData.currencyDetails[0]
            let currencyName = item.currencyTypeName
            let id = item.receive.getCurrencyId - 1
            let value = item.chaosEquivalent
            let change = item.receiveSparkLine.totalChange
            let icon = itemDetails.icon
            
            let currency = CurrencyModel(currencyName: currencyName, currencyId: id, value: value, totalChage: change, icon: icon)
            return currency
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
