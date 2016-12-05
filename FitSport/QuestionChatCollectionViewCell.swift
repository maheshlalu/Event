//
//  QuestionChatCollectionViewCell.swift
//  FitSport
//
//  Created by Manishi on 12/1/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class QuestionChatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var QuestionPic: UIImageView!
    @IBOutlet weak var answerPic: UIImageView!
    @IBOutlet weak var questionTxtView: UITextView!
    @IBOutlet weak var answerTxtView: UITextView!
    @IBOutlet weak var notYetAnswered: UILabel!
    @IBOutlet weak var clickToAnswerBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.questionTxtView.translatesAutoresizingMaskIntoConstraints = false
        self.answerTxtView.translatesAutoresizingMaskIntoConstraints = false
        self.notYetAnswered.translatesAutoresizingMaskIntoConstraints = false
        self.clickToAnswerBtn.translatesAutoresizingMaskIntoConstraints = false
        
        QuestionPic.layer.cornerRadius = 15
        answerPic.layer.cornerRadius = 15

    }

    
}
