//
//  LeagueManager.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/30/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

protocol LeagueManagerDelegate {
    func didFetchLeagues(_ leagueManager: LeagueManager, leagues: [String])
    func didFailWithError(error: Error)
}

struct LeagueManager {
    
    var delegate: LeagueManagerDelegate?
    
    func fetchLeagues() {
        performRequest(with: K.League.leagueUrl)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let leagues = self.parseLeague(safeData) {
                        self.delegate?.didFetchLeagues(self, leagues: leagues)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseLeague(_ leagueData: Data) -> [String]? {
        var leagueNamesArray = [String]()
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Array<LeagueData>.self, from: leagueData)
            for league in decodedData {
                leagueNamesArray.append(league.name)
            }
            return leagueNamesArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
