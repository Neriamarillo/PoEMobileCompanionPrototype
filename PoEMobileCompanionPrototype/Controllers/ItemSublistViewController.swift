//
//  ItemSublistViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

//MARK: - TODO'S
// Set data to completely load from server on app start to minimize delays. Also check persistent storage options.

import UIKit

class ItemSublistViewController : UITableViewController {
    
    @IBOutlet var itemSublistTableView: UITableView!
    
    var selectedItem : String?
    var selectedItemString : String?
    var itemManager = ItemManager()
    var itemArray = [Item]()
    var currencyArray = [CurrencyModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        currencyManager.fetchItems(itemType: selectedItem!)
        itemManager.delegate = self
        
        
        //        itemSublistTableView.dataSource = self
        //        itemSublistTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = selectedItemString
        let backgroundImage = UIImage(named: "harvest-bg" )
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        loadItems()
    }
    
    //    //MARK: - TableView Datasource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return itemListModel.itemTypes.count
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSublistTableViewCell", for: indexPath) as! ItemSublistTableViewCell
        
        let item = itemArray[indexPath.row]
        print(item.name)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.1764497757, green: 0.1764855981, blue: 0.1764421761, alpha: 1).withAlphaComponent(0.8)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.06291490793, green: 0.06269240379, blue: 0.06683042645, alpha: 1).withAlphaComponent(0.8)
        }
        
        cell.itemLabel?.text = item.name
        cell.itemLabel?.textColor = UIColor.white
        
        if item.sparkline.totalChange ?? 0 > 0 {
            cell.priceChangeLabel?.textColor = UIColor.green
        } else if item.sparkline.totalChange ?? 0 < 0 {
            cell.priceChangeLabel?.textColor = UIColor.red
        } else {
            cell.priceChangeLabel?.textColor = UIColor.white
        }
        cell.priceChangeLabel?.text = "\(item.sparkline.totalChange ?? 0)%"
        cell.currentPriceLabel?.text = String(item.chaosValue)
        cell.currentPriceLabel?.textColor = #colorLiteral(red: 0.9137254902, green: 0.8117647059, blue: 0.6235294118, alpha: 1)
        if let iconUrl = item.icon {
            let url = URL(string: iconUrl)
            cell.itemImageView.load(url: url!)
        }
        
        cell.currentPriceIcon.image = UIImage(named: "CurrencyIcon")
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let destinationVC = segue.destination as! ItemDetailsViewController
    //
    //        if let indexPath = tableView.indexPathForSelectedRow {
    //            destinationVC.selectedItem = itemListModel.itemTypes[indexPath.row]
    //        }
    //    }
    
    //MARK: - Model Manipulation Methods
    func loadItems() {
        itemManager.fetchItems(itemType: selectedItem!)
    }
    
}



//MARK: - ItemManagerDelegate
extension ItemSublistViewController: ItemManagerDelegate {
    func didFetchItems(_ itemManager: ItemManager, items: [Item]) {
        itemArray = items
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func didFetchCurrency(_ currencyManager: ItemManager, currency: CurrencyModel) {
        print(currency)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

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
