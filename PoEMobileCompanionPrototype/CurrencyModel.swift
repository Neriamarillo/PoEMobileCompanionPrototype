//
//  CurrencyModel.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import Foundation

struct CurrencyModel {
    let currencyName: String
    let currencyId: Int
    let value: Double
    let totalChage: Double
    let icon: String
    
    var valueString: String {
        return String(format: ".1f", value)
    }
    
    var totalChangeString: String {
        return String(format: ".2f", totalChage)
    }
}
