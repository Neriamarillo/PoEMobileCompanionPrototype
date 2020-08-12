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
    var itemTypeOverview = String()
    var delegate: ItemManagerDelegate?
    
    mutating func fetchItems(itemCategory: String, leagueName: String)  {
        self.itemCategory = itemCategory
        //MARK: - TEST
        self.itemTypeOverview = ItemListModel.getItemTypeOverview(itemCategory: itemCategory)
        
        let originalUrl = "\(apiURL)\(self.itemTypeOverview)?league=\(leagueName)&type=\(itemCategory)"
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
                    if let itemData = self.parseJSON(safeData) {
                        self.delegate?.didFetchItems(items: itemData)
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: - TEST CODE
    
    func parseJSON(_ itemData: Data) -> [ItemModel]? {
        let decoder = JSONDecoder()
        var itemCollection: [ItemModel] = []
        
        do {
            let decodedItems = try decoder.decode(ItemData.self, from: itemData)
            if !decodedItems.lines!.isEmpty {
                for item in decodedItems.lines! {
                    let type = item.getItemBaseType(itemCategory: self.itemCategory)
                    itemCollection.append(ItemModel(id: item.id, name: item.name, icon: item.icon ?? "", priceInChaos: item.chaosValue, priceInExalt: item.exaltedValue ?? 0, totalChange: item.sparkline.totalChange, tradeId: item.detailsId, gemLevel: item.gemLevel ?? 0, gemQuality: item.gemQuality ?? 0, flavourText: item.flavourText, itemCategory: self.itemCategory, itemLevel: item.levelRequired ?? 0, influence: item.variant ?? "", itemBaseType: type, itemType: item.itemType ?? ""))
                }
            }
        } catch {
            do {
                let decodedItems = try decoder.decode(CurrencyData.self, from: itemData)
                if !decodedItems.lines!.isEmpty {
                    for item in decodedItems.lines! {
                        let id = item.pay?.payCurrencyID ?? item.receive?.getCurrencyID
                        let itemDetails = decodedItems.currencyDetails![id! - 1]
                        itemCollection.append(ItemModel(id: id ?? 0, name: item.currencyTypeName, icon: itemDetails.icon, priceInChaos: item.chaosEquivalent, priceInExalt: 0, totalChange: item.receiveSparkLine.totalChange, tradeId: itemDetails.tradeID, gemLevel: nil, gemQuality: nil, flavourText: nil, itemCategory: self.itemCategory, itemLevel: nil, influence: nil, itemBaseType: nil, itemType: nil))
                    }
                }
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
        return itemCollection
    }
}
