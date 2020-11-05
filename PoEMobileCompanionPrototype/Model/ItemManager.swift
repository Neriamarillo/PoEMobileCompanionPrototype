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
    var itemCategory: String!
    var itemTypeOverview = String()
    var delegate: ItemManagerDelegate?
    
    mutating func fetchItems(itemCategory: String, leagueName: String)  {
        self.itemCategory = itemCategory
        print("Item Category @ ItemManager: \(itemCategory)")
        //MARK: - TEST
        self.itemTypeOverview = ItemListModel.getItemTypeOverview(itemCategory: itemCategory)
        
        let originalUrl = "\(K.API.apiURL)\(self.itemTypeOverview)?league=\(leagueName)&type=\(itemCategory)"
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
    
    //MARK: - Parse Code
    
    func parseJSON(_ itemData: Data) -> [ItemModel]? {
        let decoder = JSONDecoder()
        var itemCollection: [ItemModel] = []
        do {
            let decodedItems = try decoder.decode(ItemRoot.self, from: itemData)
            if !decodedItems.lines!.isEmpty {
                for item in decodedItems.lines! {
                    
                    let type = item.getItemBaseType(itemCategory: self.itemCategory)
                    itemCollection.append(ItemModel(id: item.id, name: item.name, icon: item.icon, mapTier: item.mapTier, levelRequired: item.levelRequired, baseType: type, stackSize: item.stackSize, variant: item.variant, prophecyText: item.prophecyText, links: item.links, itemClass: item.itemClass, flavourText: item.flavourText, corrupted: item.corrupted, gemLevel: item.gemLevel, gemQuality: item.gemQuality, itemType: item.itemType, priceInChaos: item.chaosValue, exaltedValue: item.exaltedValue, totalChange: item.sparkline.totalChange, count: item.count, detailsId: item.getDetailsId(itemCategory: self.itemCategory), mapRegion: item.mapRegion, itemCategory: self.itemCategory))
                }
            }
        } catch {
            do {
                let decodedItems = try decoder.decode(CurrencyRoot.self, from: itemData)
                if !decodedItems.lines!.isEmpty {
                    for item in decodedItems.lines! {
                        let id  = item.pay?.payCurrencyID ?? item.receive?.getCurrencyID
                        let itemDetails = decodedItems.currencyDetails![id! - 1]
                        itemCollection.append(ItemModel(id: item.getItemId(), name: item.currencyTypeName, icon: itemDetails.icon, mapTier: nil, levelRequired: nil, baseType: nil, stackSize: nil, variant: nil, prophecyText: nil, links: nil, itemClass: nil, flavourText: nil, corrupted: false, gemLevel: nil, gemQuality: nil, itemType: nil, priceInChaos: item.chaosEquivalent, exaltedValue: nil, totalChange: item.receiveSparkLine.totalChange, count: nil, detailsId: itemDetails.tradeId, mapRegion: nil, itemCategory: self.itemCategory))
                    }
                }
            } catch {
                delegate?.didFailWithError(error: error)
                print("Error at parse")
                return nil
            }
        }
        return itemCollection
    }
}
