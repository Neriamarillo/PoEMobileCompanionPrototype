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
//        tabBarController?.tabBar.barStyle = .black
        let backgroundImage = UIImage(named: "harvest-bg")
        let imageView = UIImageView(image: backgroundImage)
//        imageView.alpha = 0.8
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
            cell.backgroundColor = #colorLiteral(red: 0.07800000161, green: 0.07800000161, blue: 0.07800000161, alpha: 0.8).withAlphaComponent(0.8)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.0390000008, green: 0.0390000008, blue: 0.0390000008, alpha: 0.8).withAlphaComponent(0.8)
        }
        
        cell.itemLabel?.text = itemListModel.itemTypeStrings[indexPath.row]
        cell.itemLabel?.textColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
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
