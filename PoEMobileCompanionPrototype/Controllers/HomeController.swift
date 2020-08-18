//
//  HomeController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/7/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    var leagueManager = LeagueManager()
    var leagueNames = [String]()
    var selectedLeague: String!
    var defaultLeague = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        leagueManager.delegate = self
        setLeague()
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.isToolbarHidden = true
        if selectedLeague == nil {
            self.selectedLeague = defaultLeague
        }
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "League: \(self.selectedLeague!)", style: .plain, target: self, action: #selector(presentPopover))
        let backgroundImage = UIImage(named: "harvest-bg-crop")
        let imageView = UIImageView(image: backgroundImage)
        //        imageView.alpha = 0.8
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        loadLeagues()
    }
    
    //MARK: - TableView Datasource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemListModel.itemTypeStrings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.07800000161, green: 0.07800000161, blue: 0.07800000161, alpha: 0.8).withAlphaComponent(0.8)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.0390000008, green: 0.0390000008, blue: 0.0390000008, alpha: 0.8).withAlphaComponent(0.8)
        }
        
        cell.itemLabel?.text = ItemListModel.itemTypeStrings[indexPath.row]
        cell.itemLabel?.textColor = #colorLiteral(red: 0.6389999986, green: 0.5529999733, blue: 0.4269999862, alpha: 1)
        cell.itemImageView?.image = UIImage(named: ItemListModel.itemIcons[indexPath.row])
        
        return cell
    }
    
    //MARK: - League Selection
    func setLeague() {
        if let league = UserDefaults.standard.string(forKey: "CurrentLeague") {
            defaultLeague = league
        } else {
            defaultLeague = "Standard"
            UserDefaults.standard.set(defaultLeague, forKey: "CurrentLeague")
        }
    }
    
    func loadLeagues() {
        leagueManager.fetchLeagues()
    }
    
    @objc func presentPopover() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for league in self.leagueNames {
            if !league.contains("SSF") {
                alertController.addAction(UIAlertAction(title: league, style: .default, handler: { (action: UIAlertAction!) in
                    self.selectedLeague = league
                    self.navigationItem.rightBarButtonItem?.title = "League: \(self.selectedLeague!)"
                    UserDefaults.standard.set(league, forKey: "CurrentLeague")
                }))
            }
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = self.navigationItem.rightBarButtonItem
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = .up
        }
        self.present(alertController, animated: true, completion: {
            alertController.view.superview?.isUserInteractionEnabled = true
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissTap(sender:))))
        })
    }
    
    @objc func dismissTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemSublistViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedItem = ItemListModel.itemTypes[indexPath.row]
            destinationVC.selectedItemString = ItemListModel.itemTypeStrings[indexPath.row]
            destinationVC.selectedLeague = self.selectedLeague
            print("Selected Item: \(ItemListModel.itemTypes[indexPath.row]), Selected League: \(self.selectedLeague!)")
        }
    }
}

//MARK: - League Manager Delegate
extension HomeController : LeagueManagerDelegate {
    func didFetchLeagues(_ leagueManager: LeagueManager, leagues: [String]) {
        leagueNames = leagues
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error)")
    }
}
