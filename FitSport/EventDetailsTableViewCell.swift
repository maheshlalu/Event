//
//  EventTableViewCell.swift
//  Autolayouts_CoupoCon
//
//  Created by Rama kuppa on 21/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class EventDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
