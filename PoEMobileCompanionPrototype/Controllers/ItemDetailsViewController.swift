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
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var priceInChaosLabel: UILabel!
    @IBOutlet weak var chaosPriceImage: UIImageView!
    
    @IBOutlet weak var graphView: UIView!
    
    var selectedItem: ItemModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
        adjustLargeTitleSize()
        let backgroundImage = UIImage(named: "harvest-bg")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = backgroundImage
//        imageView.alpha = 0.5
        imageView.contentMode = .scaleAspectFill
        self.view.layer.allowsGroupOpacity = true
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
        if let flavourText = selectedItem.flavourTextString, flavourText != "" {
            flavourTextLabel.text = "\(flavourText)"
            flavourTextLabel.sizeToFit()
        } else {
            flavourTextLabel.isHidden = true
        }
        priceInChaosLabel.text = "\(selectedItem.priceInChaos)x"
        chaosPriceImage.image = UIImage(named: "CurrencyIcon")
//        if let exaltPrice = selectedItem.priceInExalt {
//           priceInExalt.text = String(exaltPrice)
//        }
        
    }
    
    //MARK: - Go to Item Wiki Page
    @IBAction func wikiButtonPressed(_ sender: UIButton) {
        print(selectedItem!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WikiViewController
        destinationVC.searchItem = selectedItem.name
        destinationVC.searchItemType = selectedItem.itemType
    }
    
}
