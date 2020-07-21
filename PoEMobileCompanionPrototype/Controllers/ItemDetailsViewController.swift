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
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationItem.title = selectedItem?.name
//        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: .none, action: .none),    UIBarButtonItem(barButtonSystemItem: .bookmarks, target: .none, action: .none)]
//        setupNavBar()
        
        let backgroundImage = UIImage(named: "harvest-bg")
        let imageView = UIImageView(frame: view.frame)
        imageView.image = backgroundImage
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        loadViews()
        
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
    
    func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .always
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 34.0, weight: .semibold)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        label.text = selectedItem.name
        self.navigationItem.titleView = label
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: .none, action: .none),    UIBarButtonItem(barButtonSystemItem: .bookmarks, target: .none, action: .none)]
    }
    
}
