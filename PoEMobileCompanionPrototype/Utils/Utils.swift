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

//MARK: - Dynamically Adjust Large Title
extension UIViewController {
    func adjustLargeTitleSize() {
        guard let title = self.navigationItem.title, #available(iOS 11.0, *) else { return }
        
        let maxWidth = UIScreen.main.bounds.size.width - 60
        var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        
        while width > maxWidth {
            fontSize -= 1
            width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        }
        
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        ]
    }
}

