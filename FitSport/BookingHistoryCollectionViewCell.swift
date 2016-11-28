//
//  BookingHistoryCollectionViewCell.swift
//  FitSport
//
//  Created by Manishi on 11/28/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class BookingHistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var orderHistoryImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.headerView.layer.cornerRadius = 5
        
        self.orderHistoryImageView.layer.cornerRadius = 25
        orderHistoryImageView!.layer.masksToBounds = true
        orderHistoryImageView!.clipsToBounds = true
    }

}
