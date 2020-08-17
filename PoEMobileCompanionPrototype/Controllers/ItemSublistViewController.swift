//
//  ItemSublistViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit

class ItemSublistViewController : UITableViewController {
    
    @IBOutlet var itemSublistTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedItem: String?
    var selectedItemString: String?
    var itemType: String?
    var selectedLeague: String!
    var itemManager = ItemManager()
    fileprivate var itemArray: [ItemModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    fileprivate var filteredItems: [ItemModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var searchActive = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemManager.delegate = self
        searchBar.delegate = self
        setupNavBar()
        setupSearchBar()
        setupBackground()
        print("Sublist league: \(selectedLeague!)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
    }
    
    func setupNavBar() {
        navigationItem.title = selectedItemString
    }
    
    func setupSearchBar() {
        searchBar.searchTextField.textColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        searchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        searchBar.tintColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        searchBar.backgroundColor = #colorLiteral(red: 0.05881328136, green: 0.05883090943, blue: 0.05880954117, alpha: 1)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search items", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)])
        self.tableView.tableHeaderView = self.searchBar
    }
    
    func setupBackground() {
        let backgroundImage = UIImage(named: "harvest-bg" )
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
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
            if let url = URL(string: iconUrl) {
                cell.itemImageView.load(url: url)
            }
        }
        
        cell.currentPriceIcon.image = UIImage(named: "CurrencyIcon")
        if selectedItem == "SkillGem" {
            cell.gemLevelLabel?.text = "Level: \(item.gemLevel!)"
            cell.gemQualityLabel?.text = "Quality: \(item.gemQuality!)"
        } else if let itemHasItemLevel = item.levelRequired, itemHasItemLevel != 0 {
            cell.gemLevelLabel.text = "Item Level: \(itemHasItemLevel)"
            cell.gemQualityLabel.isHidden = true
        } else {
            cell.gemLevelLabel?.isHidden = true
            cell.gemQualityLabel?.isHidden = true
        }
        if let itemHasInfluence = item.variant, itemHasInfluence != "" {
            cell.influenceImageView.image = UIImage(named: "\(itemHasInfluence)Symbol")
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
        itemManager.fetchItems(itemCategory: selectedItem!, leagueName: self.selectedLeague)
        self.selectedItemString = ItemListModel.getItemString(itemType: self.selectedItem!)
    }
}

//MARK: - ItemManagerDelegate
extension ItemSublistViewController: ItemManagerDelegate {
    func didFetchItems(items: [ItemModel]) {
        itemArray = items
        if searchActive == false {
            filteredItems = itemArray
        }
    }
    
    func didFetchCurrency(currencies: [ItemModel]) {
        itemArray = currencies
        if searchActive == false {
            filteredItems = itemArray
        }
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
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
        searchActive = false
        self.searchBar(self.searchBar, textDidChange: "")
        self.searchBar.resignFirstResponder()
    }
    
}
