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
    var itemLists: ItemListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        adjustLargeTitleSize()
        setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadViews()
    }
    
    func setupNavBar() {
        if selectedItem.itemCategory == "HelmetEnchant" {
            flavourTextLabel.text = selectedItem.name
            navigationItem.title = "Helmet Enchants"
        } else {
            navigationItem.title = selectedItem.name
        }
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: .none, action: .none)]
    }
    
    func setupBackground() {
        let backgroundImage = UIImage(named: "harvest-bg")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = backgroundImage
        imageView.contentMode = .scaleAspectFill
        self.view.layer.allowsGroupOpacity = true
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func loadViews() {
        if let iconUrl = selectedItem.icon {
            if let url = URL(string: iconUrl) {
                itemImage.load(url: url)
            }            
        }
        if let flavourText = selectedItem.flavourTextString, flavourText != "" {
            flavourTextLabel.text = "\(flavourText)"
            flavourTextLabel.sizeToFit()
        }
        priceInChaosLabel.text = "\(selectedItem.priceInChaos)x"
        chaosPriceImage.image = UIImage(named: "CurrencyIcon")
        //        if let exaltPrice = selectedItem.priceInExalt {
        //           priceInExalt.text = String(exaltPrice)
        //        }
    }
    
    //MARK: - Segues
    @IBAction func wikiButtonPressed(_ sender: UIButton) {
        print(selectedItem!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "goToWiki":
                let wikiDestination = segue.destination as! WikiViewController
                wikiDestination.searchItem = selectedItem.name
                wikiDestination.searchItemType = selectedItem.itemCategory
            case "goToTradeFromDetails":
                let tradeDestination = segue.destination as! TradeViewController
                tradeDestination.wantItem = self.selectedItem
                tradeDestination.haveItem = "chaos"
            /* TODO: Implement selection between chaos or exalt for paying price */
            default:
                return
        }
    }
    
}
