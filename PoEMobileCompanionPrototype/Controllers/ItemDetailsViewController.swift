//
//  ItemDetailsViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit
import SwiftUI

class ItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var flavourTextLabel: UILabel!
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var priceInChaosLabel: UILabel!
    @IBOutlet weak var chaosPriceImage: UIImageView!
    @IBOutlet weak var currencySelectionButton: UIButton!
    
    
    @IBOutlet weak var graphView: UIView!
    
    var selectedItem: ItemModel!
    var itemLists: ItemListModel!
    var tradeSearchHaveCurrency = "Chaos" {
        didSet {
            self.currencySelectionButton.setTitle("Have: \(self.tradeSearchHaveCurrency) Orb", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        adjustLargeTitleSize()
        setupBackground()
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
        let backgroundImage = UIImage(named: "heist-bg-crop")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = backgroundImage
        imageView.contentMode = .scaleToFill
        self.view.layer.allowsGroupOpacity = true
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func loadViews() {
        if let iconUrl = self.selectedItem.icon {
            if let url = URL(string: iconUrl) {
                itemImage.load(url: url)
            }            
        }
        if let flavourText = self.selectedItem.flavourTextString, flavourText != "" {
            flavourTextLabel.text = "\(flavourText)"
            flavourTextLabel.sizeToFit()
        }
        priceInChaosLabel.text = "\(self.selectedItem.priceInChaos)x"
        chaosPriceImage.image = UIImage(named: "CurrencyIcon")
        self.currencySelectionButton.setTitle("Have: \(self.tradeSearchHaveCurrency) Orb", for: .normal)
    }
    
    //MARK: - Segues
    @IBAction func wikiButtonPressed(_ sender: UIButton) {
        print(selectedItem!)
        
    }
    @IBAction func currencySelectionButtonPressed(_ sender: UIButton) {
        let chaosAction = UIAlertAction(title: "Chaos", style: .default) { (action) in
            self.tradeSearchHaveCurrency = "Chaos"
        }
        let exaltAction = UIAlertAction(title: "Exalted", style: .default) { (action) in
            self.tradeSearchHaveCurrency = "Exalted"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let alert = UIAlertController(title: "Search Official Trade Site", message: "Select currency you have", preferredStyle: .alert)
        alert.addAction(chaosAction)
        alert.addAction(exaltAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tradeSearchButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToTradeFromDetails", sender: sender)
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "goToWiki":
                let wikiDestination = segue.destination as! WikiViewController
                wikiDestination.searchItem = self.selectedItem.name
                wikiDestination.searchItemType = self.selectedItem.itemCategory
            case "goToTradeFromDetails":
                let tradeDestination = segue.destination as! TradeViewController
                tradeDestination.wantItem = self.selectedItem
                tradeDestination.haveItem = self.tradeSearchHaveCurrency.lowercased()
            default:
                return
        }
    }
    
    @IBSegueAction func addGraphView(_ coder: NSCoder) -> UIViewController? {
        let hostingController = UIHostingController(coder: coder, rootView: ItemChartViewSUI())
        
        hostingController?.view.backgroundColor = .clear
        
        return hostingController
    }
    
}
