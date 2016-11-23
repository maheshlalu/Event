//
//  EventTypeNewTableViewCell.swift
//  FitSport
//
//  Created by Rambabu Mannam on 22/11/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class EventTypeNewTableViewCell: UITableViewCell {
    @IBOutlet weak var eventTypeLabel: UILabel!

    @IBOutlet weak var eventCostLabel: UILabel!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var ticketPriceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.eventTypeLabel.textColor = CXAppConfig.sharedInstance.getAppTheamColor()
        self.ticketPriceLbl.textColor = CXAppConfig.sharedInstance.getAppTheamColor()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
