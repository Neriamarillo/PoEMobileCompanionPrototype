//
//  LeagueData.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/30/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct LeagueData: Codable {
    let name: String
    let endTime: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "id"
        case endTime = "endAt"
    }
}
