//
//  ItemSublistViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

//MARK: - TODO'S

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
    var searchActive = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemManager.delegate = self
        
        setupNavBar()
        setupSearchBar()
        let backgroundImage = UIImage(named: "harvest-bg" )
        let imageView = UIImageView(image: backgroundImage)
        //        imageView.alpha = 0.8
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        loadItems()
    }
    
    func setupNavBar() {
        navigationItem.title = selectedItemString
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.textColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        searchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        searchBar.tintColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        searchBar.backgroundColor = #colorLiteral(red: 0.05881328136, green: 0.05883090943, blue: 0.05880954117, alpha: 1)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search items", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)])
        self.tableView.tableHeaderView = self.searchBar
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
            cell.backgroundColor = #colorLiteral(red: 0.07800000161, green: 0.07800000161, blue: 0.07800000161, alpha: 0.8).withAlphaComponent(0.8)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.0390000008, green: 0.0390000008, blue: 0.0390000008, alpha: 0.8).withAlphaComponent(0.8)
        }
        cell.itemLabel?.text = item.name
        
        switch true {
            case 0 ~= item.totalChange:
                cell.priceChangeLabel?.textColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
                cell.priceChangeLabel?.text = "\(item.totalChangeString)%"
            case item.totalChange > 0:
                cell.priceChangeLabel?.text = "+\(item.totalChangeString)%"
                cell.priceChangeLabel?.textColor = UIColor.green
            case item.totalChange < 0:
                cell.priceChangeLabel?.text = "\(item.totalChangeString)%"
                cell.priceChangeLabel?.textColor = UIColor.red
            default:
                fatalError()
        }
        
        cell.currentPriceLabel?.text = "\(item.priceInChaos)x"
        
        if let iconUrl = item.icon {
            let url = URL(string: iconUrl)
            cell.itemImageView.load(url: url!)
        }
        cell.currentPriceIcon.image = UIImage(named: "CurrencyIcon")
        
        if selectedItem == "SkillGem" {
            cell.gemLevelLabel?.text = "Level: \(item.gemLevel!)"
            cell.gemQualityLabel?.text = "Quality: \(item.gemQuality!)"
        } else if let itemHasItemLevel = item.itemLevel, itemHasItemLevel != 0 {
            cell.gemLevelLabel.text = "Item Level: \(itemHasItemLevel)"
            cell.gemQualityLabel.isHidden = true
        } else {
            cell.gemLevelLabel?.isHidden = true
            cell.gemQualityLabel?.isHidden = true
        }
        
        if let itemHasInfluence = item.influence, itemHasInfluence != "" {
            cell.influenceImageView.image = UIImage(named: "\(itemHasInfluence)Symbol")
        }
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //                performSegue(withIdentifier: "goToItemDetail", sender: self)
        
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
        if searchActive == false {
            filteredItems = itemArray
        }
        OperationQueue.main.addOperation({
            self.tableView.reloadData()
        })
    }
    
    func didFetchCurrency(_ currencyManager: ItemManager, currencies: [ItemModel]) {
        itemArray = currencies
        if searchActive == false {
            filteredItems = itemArray
        }
        OperationQueue.main.addOperation({
            self.tableView.reloadData()
        })
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - Search Bar Methods
extension ItemSublistViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchActive {
            let filteredItem = itemArray.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
            filteredItems = searchText.isEmpty ? itemArray : filteredItem
        } else {
            self.searchBar.text = ""
            filteredItems = itemArray
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
        searchActive = false
        self.searchBar(self.searchBar, textDidChange: "")
        self.searchBar.resignFirstResponder()
    }
    
}
