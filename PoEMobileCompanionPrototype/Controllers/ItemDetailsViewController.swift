//
//  ItemDetailsViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var flavourTextLabel: UILabel!
    
    var selectedItem: ItemModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
        let backgroundImage = UIImage(named: "harvest-bg")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = backgroundImage
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        loadViews()
    }
    
    func setupNavBar() {
        navigationItem.title = selectedItem.name
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: .none, action: .none)]
    }
    
    func loadViews() {
        if let iconUrl = selectedItem.icon {
            let url = URL(string: iconUrl)
            itemImage.load(url: url!)
        }
        if let flavourText = selectedItem.flavourText, flavourText != "" {
            flavourTextLabel.text = "\(flavourText)"
            flavourTextLabel.sizeToFit()
        } else {
            flavourTextLabel.isHidden = true
        }
    }
}
