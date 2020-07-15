////
////  CurrencyManager.swift
////  PoEMobileCompanionPrototype
////
////  Created by Jorge Nieves on 7/10/20.
////  Copyright © 2020 Jorge Nieves. All rights reserved.
////
//
//import UIKit
//
//protocol CurrencyManagerDelegate {
//    func didFetchCurrency(_ currencyManager: CurrencyManager, currency: CurrencyModel)
//    func didFailWithError(error: Error)
//}
//
//struct CurrencyManager {
//    
//    //    itemTypeOverview -> currencyoverview or itemoverview
//    let apiURL = "https://poe.ninja/api/data/"
//    let leagueName = "Harvest"
//    
//    var delegate: CurrencyManagerDelegate?
//    
//    func fetchItems(itemType: String) {
//        let urlString = "\(apiURL)currencyoverview?league=\(leagueName)&type=\(itemType)" // gets the list of currencies
//        //        let urlString = "\(apiURL)currencyhistory?league=\(leagueName)&type=\(itemType)&currencyId=2" // gets graph data for currency
//        performRequest(with: urlString)
//    }
//    
//    func performRequest(with urlString: String) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                    return
//                }
//                
//                if let safeData = data {
//                    if let currency = self.parseJSON(safeData) {
//                        self.delegate?.didFetchCurrency(self, currency: currency)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//    
//    
//    func parseJSON(_ currencyData: Data) -> CurrencyModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
//            let item = decodedData.lines[0]
//            let itemDetails = decodedData.currencyDetails[0]
//            let currencyName = item.currencyTypeName
//            let id = item.receive.getCurrencyId - 1
//            let value = item.chaosEquivalent
//            let change = item.receiveSparkLine.totalChange
//            let icon = itemDetails.icon
//            
//            let currency = CurrencyModel(currencyName: currencyName, currencyId: id, value: value, totalChage: change, icon: icon)
//            return currency
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//}
