//
//  TrainerCollectionViewCell.swift
//  FitSportProject
//
//  Created by Rama kuppa on 01/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class TrainerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var trainerBtn: UIButton!
    @IBOutlet weak var trainerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
     //self.mainImageView.bounds.size.width / 2.0
        self.trainerImage.layer.cornerRadius = 40
        self.trainerImage.layer.borderWidth = 1
        self.trainerImage.clipsToBounds = true
        // Initialization code
    }

}
