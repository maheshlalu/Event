//
//  EventCell.swift
//  FitSport
//
//  Created by Manishi on 11/4/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    @IBOutlet weak var feedsView: UIView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBAction func heartBtnAction(_ sender: UIButton) {
        let btn: UIButton = sender
        btn.isSelected = !btn.isSelected
        
        
    }
    @IBOutlet weak var joinBtn: UIButton!
    @IBAction func joinBtnAction(_ sender: UIButton) {
        
        let btn:UIButton = sender
        btn.isSelected = !btn.isSelected
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var feedsImageView: UIImageView!
    
    
    @IBOutlet weak var userTitleLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width/2.1
        self.userImageView.layer.borderWidth = 1
        self.userImageView.clipsToBounds = true
        
        self.feedsImageView.layer.borderColor = UIColor(red: 252/255, green: 186/255, blue: 158/255, alpha: 1).cgColor
        self.feedsImageView.layer.cornerRadius = 5
        self.feedsImageView.clipsToBounds = true
        self.feedsImageView.layer.borderWidth = 3
        
        self.joinBtn.layer.cornerRadius = 5
        self.joinBtn.clipsToBounds = true
        self.joinBtn.layer.borderColor = UIColor.orange.cgColor
        self.joinBtn.layer.borderWidth = 1
        
        // Initialization code
    }
    
}
