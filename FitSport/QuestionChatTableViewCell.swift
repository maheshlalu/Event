//
//  QuestionChatTableViewCell.swift
//  FitSport
//
//  Created by Manishi on 11/30/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class QuestionChatTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var questioneerImg: UIImageView!
    @IBOutlet weak var answeredImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        questioneerImg.layer.cornerRadius = 15
        questioneerImg.layer.borderWidth = 2
        
        answeredImg.layer.cornerRadius = 15
        answeredImg.layer.borderWidth = 2
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
