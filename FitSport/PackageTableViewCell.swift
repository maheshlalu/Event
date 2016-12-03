//
//  PackageTableViewCell.swift
//  FitSportProject
//
//  Created by Rama kuppa on 10/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var rateView: FloatRatingView!
    @IBOutlet weak var sessionTypeLbl: UILabel!
    @IBOutlet weak var sessionPriceLbl: UILabel!
    @IBOutlet weak var sessionDurationLbl: UILabel!
    @IBOutlet weak var sessionPlaceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookBtn.layer.cornerRadius = 4
        // Initialization cod0e
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
