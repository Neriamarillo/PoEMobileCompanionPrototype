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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedItem : String?
    var selectedItemString : String?
    var itemType: String?
    var itemManager = ItemManager()
    var itemArray = [ItemModel]()
    private var filteredItems: [ItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemManager.delegate = self
        searchBar.delegate = self
        
        navigationItem.title = selectedItemString
        let backgroundImage = UIImage(named: "harvest-bg" )
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        searchBar.searchTextField.textColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        searchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)])
        navigationItem.hidesSearchBarWhenScrolling = false
        
        loadItems()
        filteredItems = itemArray
    }
    
    //MARK: - TableView Datasource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSublistTableViewCell", for: indexPath) as! ItemSublistTableViewCell
        let item = filteredItems[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.1764497757, green: 0.1764855981, blue: 0.1764421761, alpha: 1).withAlphaComponent(0.8)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.06291490793, green: 0.06269240379, blue: 0.06683042645, alpha: 1).withAlphaComponent(0.8)
        }
        cell.itemLabel?.text = item.name
        if item.totalChange > 0 {
            cell.priceChangeLabel?.textColor = UIColor.green
        } else if item.totalChange < 0 {
            cell.priceChangeLabel?.textColor = UIColor.red
        } else {
            cell.priceChangeLabel?.textColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        }
        cell.priceChangeLabel?.text = "\(item.totalChange)%"
        cell.currentPriceLabel?.text = "\(item.priceInChaos)x"
        
        if let iconUrl = item.icon {
            let url = URL(string: iconUrl)
            cell.itemImageView.load(url: url!)
        }
        cell.currentPriceIcon.image = UIImage(named: "CurrencyIcon")
        if selectedItem == "SkillGem" {
            cell.gemLevelLabel?.text = "Level: \(item.gemLevel!)"
            cell.gemQualityLabel?.text = "Quality: \(item.gemQuality!)"
        } else {
            cell.gemLevelLabel?.isHidden = true
            cell.gemQualityLabel?.isHidden = true
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemDetailsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedItem = filteredItems[indexPath.row]
        }
    }
    
    //MARK: - Model Manipulation Methods
    func loadItems() {
        itemManager.fetchItems(itemType: selectedItem!)
    }
}

//MARK: - ItemManagerDelegate
extension ItemSublistViewController: ItemManagerDelegate {
    
    func didFetchItems(_ itemManager: ItemManager, items: [ItemModel]) {
        itemArray = items
        filteredItems = itemArray
        OperationQueue.main.addOperation({
            self.tableView.reloadData()
        })
    }
    
    func didFetchCurrency(_ currencyManager: ItemManager, currencies: [ItemModel]) {
        itemArray = currencies
        filteredItems = itemArray
        OperationQueue.main.addOperation({
            self.tableView.reloadData()
        })
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Search Bar Methods
extension ItemSublistViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredItems = itemArray.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        self.filteredItems = filteredItems.isEmpty ? itemArray : filteredItems
        print("Filtering: \(itemArray.count) items!")
        tableView.reloadData()
    }
    
}
