//
//  ItemDetailsViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/10/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    var selectedItem : String?
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = selectedItem
        
        guard let navBar = navigationController?.navigationBar else {
        fatalError("Navigation controller does not exist.")}
        
        navBar.prefersLargeTitles = true
    }
    
    
}
