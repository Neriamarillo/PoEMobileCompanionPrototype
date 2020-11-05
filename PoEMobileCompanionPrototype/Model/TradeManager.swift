//
//  TradeManager.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 8/3/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

protocol TradeManagerDelegate {
    func didFetchTradeSearch(tradeUrl: URL)
    func didFailWithError(error: Error)
}

class TradeManager {
    
    fileprivate let itemsNeedNameAndType = ["Watchstone", "UniqueJewels", "UniqueFlasks", "UniqueWeapons", "UniqueArmour", "UniqueAccesories"]
    fileprivate let itemsNeedNameOnly = ["Prophecy", "UniqueMap"]
    fileprivate let itemsNeedType = ["DeliriumOrb", "Oil", "Incubator", "Scarab", "Fossil", "Resonator", "Essence", "DivinationCard", "SkillGem", "BaseType", "Beast", "Vial"]
    fileprivate let exchange = ["Currency", "Fragment",  "Maps"]
    
    // Helmet Enchant need filter processing with the data api link
    
    let searchId = String()
    var delegate: TradeManagerDelegate?
    var searchType = String()
    var parameters = String()
    var league = String()
    
    func createUrl(wantItem: ItemModel, haveItem: String, status: String) {
        league = UserDefaults.standard.string(forKey: "CurrentLeague")!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("Want: \(wantItem.detailsId!), Have: \(haveItem), Status: \(status), Current League: \(self.league)")
        
        if ItemListModel.itemsInExchange.contains(wantItem.itemCategory) {
            parameters = """
            {"exchange":{"status":{"option":"\(status)"},"have":["\(haveItem)"],"want":["\(wantItem.detailsId!)"]}}
            """
            searchType = "exchange"
        } else if wantItem.itemCategory == "Map" {
            parameters = """
            {"exchange":{"status":{"option":"\(status)"},"have":["\(haveItem)"],"want":["\(wantItem.name.lowercased().replacingOccurrences(of: " ", with: "-"))"]}}
            """
            searchType = "exchange"
        } else if ItemListModel.itemsWithNameOnly.contains(wantItem.itemCategory) {
            parameters = """
            {"query":{"status":{"option":"\(status)"},"name":"\(wantItem.name)","stats":[{"type":"and","filters":[],"disabled":false}]},"sort":{"price":"asc"}}
            """
            searchType = "search"
        } else if ItemListModel.itemsWithNameAndType.contains(wantItem.itemCategory){
            parameters = """
            {"query":{"status":{"option":"\(status)"},"name":"\(wantItem.name)","type":"\(wantItem.baseType!)","stats":[{"type":"and","filters":[],"disabled":false}]},"sort":{"price":"asc"}}
            """
            searchType = "search"
        } else if ItemListModel.itemsWithTypeOnly.contains(wantItem.itemCategory) {
            parameters = """
            {"query":{"status":{"option":"\(status)"},"type":"\(wantItem.name)","stats":[{"type":"and","filters":[],"disabled":false}]},"sort":{"price":"asc"}}
            """
            searchType = "search"
        }
        
        let postData = parameters.data(using: .utf8)
        print(self.league)
        
        var request = URLRequest(url: URL(string: "\(K.Trade.tradeUrl)/\(self.searchType)/\(self.league)")!, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        performPostRequest(with: request)
    }
    
    func performPostRequest(with requestUrl: URLRequest) {
        
        let task = URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard let safeData = data else {
                print("Error at request: \(error!)")
                return
            }
            if let tradeId = self.parsePostResponse(safeData) {
                let tradeUrl = self.prepareUrl(searchId: tradeId)
                print("Trade url at safeData: \(tradeUrl)")
                self.delegate?.didFetchTradeSearch(tradeUrl: tradeUrl)
            }
        }
        task.resume()
    }
    
    func parsePostResponse(_ data: Data) -> String? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TradeData.self, from: data)
            print(decodedData.id)
            return decodedData.id
        } catch {
            print("Error at parsing GET: \(error)")
            return nil
        }
    }
    
    func prepareUrl(searchId: String) -> URL {
        return URL(string: "https://www.pathofexile.com/trade/\(self.searchType)/\(self.league)/\(searchId)")!
    }
}
