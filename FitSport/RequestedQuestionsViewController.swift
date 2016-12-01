//
//  RequestedQuestionsViewController.swift
//  FitSport
//
//  Created by Manishi on 11/30/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class RequestedQuestionsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var faqCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "QuestionChatCollectionViewCell", bundle: nil)
        self.faqCollectionView.register(nib, forCellWithReuseIdentifier: "QuestionChatCollectionViewCell")
        self.faqCollectionView.backgroundColor = UIColor.clear
        self.faqCollectionView.contentSize = CGSize(width: 320, height: 138)
        // Do any additional setup after loading the view.v

    }
    
    // CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionChatCollectionViewCell", for: indexPath)as? QuestionChatCollectionViewCell
        cell?.questionTxtView.adjustsFontForContentSizeCategory = true
        cell?.answerTxtView.adjustsFontForContentSizeCategory = true
        
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 138)
        
    }
    
}
