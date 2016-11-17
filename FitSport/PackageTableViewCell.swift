//
//  PackageTableViewCell.swift
//  FitSportProject
//
//  Created by Rama kuppa on 10/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

    @IBOutlet weak var packageSportsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.packageSportsImage.layer.cornerRadius = self.packageSportsImage.bounds.size.width/2
        self.packageSportsImage.layer.borderWidth = 1
        self.packageSportsImage.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
