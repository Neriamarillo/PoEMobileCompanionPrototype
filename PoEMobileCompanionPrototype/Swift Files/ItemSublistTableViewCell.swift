//
//  ItemSublistTableViewCell.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 7/14/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit

class ItemSublistTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var currentPriceIcon: UIImageView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var gemLevelLabel: UILabel!
    @IBOutlet weak var gemQualityLabel: UILabel!
    @IBOutlet weak var gemInfoView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
