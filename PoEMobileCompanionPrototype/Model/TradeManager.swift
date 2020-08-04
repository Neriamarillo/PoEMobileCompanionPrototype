//
//  TradeManager.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 8/3/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

protocol TradeManagerDelegate {
    func didFetchTradeSearch(_ tradeManager: TradeManager, tradeUrl: URL)
    func didFailWithError(error: Error)
}

class TradeManager {
    
    let searchId = String()
    var delegate: TradeManagerDelegate?
    var searchType = String()
    var league = "Standard"
    
    func createUrl(wantItem: String, haveItem: String, status: String) {
        league = UserDefaults.standard.string(forKey: "CurrentLeague")!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("Want: \(wantItem), Have: \(haveItem), Status: \(status), Current League: \(self.league)")
        var parameters = String()
        if (haveItem != "") {
            parameters = """
            {"exchange":{"status":{"option":"\(status)"},"have":["\(haveItem)"],"want":["\(wantItem)"]}}
            """
            searchType = "exchange"
        } else {
            parameters = """
            {"query":{"status":{"option":"\(status)"},"type":"\(wantItem)","stats":[{"type":"and","filters":[],"disabled":false}]},"sort":{"price":"asc"}}
            """
            searchType = "search"
        }
        
        let postData = parameters.data(using: .utf8)
        print(league)
        
        var request = URLRequest(url: URL(string: "https://www.pathofexile.com/api/trade/\(searchType)/\(league)")!, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        performRequest(with: request)
    }
    func performRequest(with requestUrl: URLRequest) {
        
        let task = URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard let safeData = data else {
                print("Error at request: \(error!)")
                return
            }
            if let tradeId = self.parseGetResponse(safeData) {
                let tradeUrl = self.prepareUrl(searchId: tradeId)
                print("Trade url at safeData: \(tradeUrl)")
                self.delegate?.didFetchTradeSearch(self, tradeUrl: tradeUrl)
            }
        }
        task.resume()
    }
    
    func parseGetResponse(_ data: Data) -> String? {
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
