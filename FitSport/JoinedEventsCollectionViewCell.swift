//
//  JoinedEventsCollectionViewCell.swift
//  FitSportProject
//
//  Created by Rama kuppa on 03/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class JoinedEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var joinedEventDescriptionLabel: UILabel!
    @IBOutlet weak var eventTaskLbl: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var mapbutton: UIButton!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var eventDateLbl: UILabel!
    @IBAction func heartBtnAction(_ sender: UIButton) {
        
        let btn:UIButton = sender
        btn.isSelected = !btn.isSelected
    }
    @IBOutlet weak var joinedBtn: UIButton!
    
    @IBAction func joinedBtn(_ sender: UIButton) {
        let btn:UIButton = sender
        btn.isSelected = !btn.isSelected
        
        if btn.isSelected{
            sender.backgroundColor = CXAppConfig.sharedInstance.getAppTheamColor()
            sender.titleLabel?.textColor = UIColor.white
        }else{
            sender.backgroundColor = UIColor.white
            sender.titleLabel?.textColor = CXAppConfig.sharedInstance.getAppTheamColor()
        }
    }
    
    @IBOutlet weak var joinedEventImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.joinedEventImageView.layer.borderColor = UIColor(red: 235/255, green: 190/255, blue: 165/255, alpha: 1).cgColor
        self.joinedEventImageView.layer.cornerRadius = 5
        self.joinedEventImageView.layer.borderWidth = 3
        self.joinedEventImageView.clipsToBounds = true
        
      /*  self.joinedBtn.layer.cornerRadius = 5
        self.joinedBtn.titleLabel?.textColor = CXAppConfig.sharedInstance.getAppTheamColor()
        self.joinedBtn.clipsToBounds = true
        self.joinedBtn.layer.borderColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
        self.joinedBtn.layer.borderWidth = 1
        */
        // Initialization code
    }

}
