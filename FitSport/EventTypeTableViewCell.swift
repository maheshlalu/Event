//
//  EventTypeTableViewCell.swift
//  FitSport
//
//  Created by Rambabu Mannam on 22/11/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class EventTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBAction func minusBtnAction(_ sender: UIButton) {
    }
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var oneEventCostLabel: UILabel!
    
    @IBAction func plusBtnAction(_ sender: UIButton) {
    }
    
    @IBOutlet weak var eventCostLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
