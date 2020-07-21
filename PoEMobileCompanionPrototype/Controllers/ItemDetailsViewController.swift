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
    
    var selectedItem: ItemModel!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = selectedItem?.name
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: .none, action: .none),    UIBarButtonItem(barButtonSystemItem: .bookmarks, target: .none, action: .none)]
        
        let backgroundImage = UIImage(named: "harvest-bg")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = backgroundImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        loadViews()
        
    }
    
    func loadViews() {
        if let iconUrl = selectedItem.icon {
            let url = URL(string: iconUrl)
            itemImage.load(url: url!)
        }
    }
    
}
