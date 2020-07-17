//
//  HomeController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/7/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    var itemListModel = ItemListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.barStyle = .black
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
        return itemListModel.itemTypeStrings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.1764497757, green: 0.1764855981, blue: 0.1764421761, alpha: 1).withAlphaComponent(0.8)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.06291490793, green: 0.06269240379, blue: 0.06683042645, alpha: 1).withAlphaComponent(0.8)
        }
        
        cell.itemLabel?.text = itemListModel.itemTypeStrings[indexPath.row]
        cell.itemLabel?.textColor = UIColor.white
        cell.itemImageView?.image = UIImage(named: itemListModel.itemIcons[indexPath.row])
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            performSegue(withIdentifier: "goToItemSubList", sender: self)
    
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemSublistViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedItem = itemListModel.itemTypes[indexPath.row]
            destinationVC.selectedItemString = itemListModel.itemTypeStrings[indexPath.row]
        }
    }
    
}
