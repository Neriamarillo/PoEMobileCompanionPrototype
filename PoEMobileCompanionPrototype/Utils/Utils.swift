//
//  Utils.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/21/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit

//MARK: - Item Image Handler

// Fetches the item icon link to display on screen.
// Json data only provides an image link for each item.
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

