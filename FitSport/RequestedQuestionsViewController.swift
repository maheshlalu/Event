//
//  RequestedQuestionsViewController.swift
//  FitSport
//
//  Created by Manishi on 11/30/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit
struct userQuestions {
    
    let id:String
    let question:String
    let answer:String
    let fromDict:NSDictionary
    let toDict:NSDictionary
    
}

class RequestedQuestionsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var faqCollectionView: UICollectionView!
    var userQuestionsArr = [userQuestions]()
    var requestedQuestionsArr = [userQuestions]()
    var isRequestedQuestions:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.faqCollectionView.reloadData()
        let nib = UINib(nibName: "QuestionChatCollectionViewCell", bundle: nil)
        self.faqCollectionView.register(nib, forCellWithReuseIdentifier: "QuestionChatCollectionViewCell")
        self.faqCollectionView.backgroundColor = UIColor.clear
        self.faqCollectionView.contentSize = CGSize(width: 320, height: 138)
        // Do any additional setup after loading the view.v
        
        if isRequestedQuestions{
            getRequestedQuestions()
        }else{
            getPostedQuestions()
        }
        
    }
    // CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if isRequestedQuestions {
            return requestedQuestionsArr.count
        }else{
            return userQuestionsArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionChatCollectionViewCell", for: indexPath)as? QuestionChatCollectionViewCell
        cell?.questionTxtView.adjustsFontForContentSizeCategory = true
        cell?.answerTxtView.adjustsFontForContentSizeCategory = true
        cell?.layer.cornerRadius = 4
        
        if isRequestedQuestions{
            cell?.notYetAnswered.isHidden = true
            
            let answers: userQuestions =  (self.requestedQuestionsArr[indexPath.item] as? userQuestions)!
            cell?.questionTxtView.text = answers.question
            
            let answerStr = answers.answer
            if answerStr == ""{
                cell?.answerPic.isHidden = true
                cell?.clickToAnswerBtn.isHidden = false
                cell?.clickToAnswerBtn.tag = indexPath.item+1
                cell?.clickToAnswerBtn.addTarget(self, action: #selector(clickToAnswerBtnAction(_:)), for: UIControlEvents.touchUpInside)
                cell?.answerTxtView.isHidden = true
            }else{
                cell?.clickToAnswerBtn.isHidden = true
                cell?.answerTxtView.text = answers.answer
                if (answers.toDict.value(forKey: "userImagePath") as! String != ""){
                    let url = NSURL(string: answers.toDict.value(forKey: "userImagePath") as! String)
                    cell?.answerPic.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
                }
            }
            
            if (answers.fromDict.value(forKey: "userImagePath") as! String != ""){
                let url = NSURL(string: answers.fromDict.value(forKey: "userImagePath") as! String)
                cell?.QuestionPic.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
            }
            
            
            
        }else{
            let questions: userQuestions =  (self.userQuestionsArr[indexPath.item] as? userQuestions)!
            
            cell?.questionTxtView.text = questions.question
            let answerStr = questions.answer
            if answerStr == ""{
                cell?.notYetAnswered.isHidden = false
                cell?.answerPic.isHidden = true
            }else{
                cell?.notYetAnswered.isHidden = true
                cell?.answerTxtView.text = questions.answer
                if (questions.toDict.value(forKey: "userImagePath") as! String != ""){
                    let url = NSURL(string: questions.toDict.value(forKey: "userImagePath") as! String)
                    cell?.answerPic.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
                }
            }
            
            if (questions.fromDict.value(forKey: "userImagePath") as! String != ""){
                let url = NSURL(string: questions.fromDict.value(forKey: "userImagePath") as! String)
                cell?.QuestionPic.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
            }
            
        }
        
        
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 138)
        
    }
    
    func clickToAnswerBtnAction(_ sender:UIButton){
        print("Happy")

        let answers: userQuestions =  (self.requestedQuestionsArr[sender.tag - 1] as? userQuestions)!
        let dict:NSDictionary = ["id":answers.id,"toEmail":answers.toDict.value(forKey: "emailId"),"fromEmail":answers.fromDict.value(forKey: "emailId")]
        
        let popup = PopupController
            .create(self)
            .customize(
                [
                    .animation(.slideUp),
                    .scrollable(false),
                    .layout(.top),
                    .backgroundStyle(.blackFilter(alpha: 0.7)),
                    .dismissWhenTaps(false)
                ]
            )
            .didShowHandler { popup in
            }
            .didCloseHandler { _ in
        }
        let container = DemoPopupViewController2.instance()
        container.fromFAQ = true
        container.faqDict = dict
    
        container.closeHandler = { _ in
            popup.dismiss()
            print("pop up closed")
        }
        popup.show(container)
        
    }
    
    
    func getPostedQuestions(){
        
        let appdata:NSArray = UserProfile.mr_findAll() as NSArray
        
        if appdata.count != 0{
            let userProfileData:UserProfile = appdata.lastObject as! UserProfile
            print(userProfileData.emailId)
            print(userProfileData.phoneNumber)
        }
        
        CXDataService.sharedInstance.getPosterQuestions(ownerId:CXAppConfig.sharedInstance.getAppMallID(), email: "yernagulamahesh@gmail.com") { (responseDict) in
            
            let arr = responseDict["questions"] as! [[String:AnyObject]]
            for gallaeryData in arr {
                let picDic : NSDictionary =  gallaeryData as NSDictionary
                let locationStruct : userQuestions = userQuestions(id: CXAppConfig.resultString(input: picDic.value(forKey:"id")! as AnyObject), question: picDic.value(forKey: "question") as! String, answer: picDic.value(forKey: "answer") as! String, fromDict: picDic.value(forKey: "from") as! NSDictionary, toDict: picDic.value(forKey: "to") as! NSDictionary)
                
                self.userQuestionsArr.append(locationStruct)
                self.faqCollectionView.reloadData()
            }
        }
    }
    
    func getRequestedQuestions(){
        
        let appdata:NSArray = UserProfile.mr_findAll() as NSArray
        
        if appdata.count != 0{
            let userProfileData:UserProfile = appdata.lastObject as! UserProfile
            print(userProfileData.emailId)
            print(userProfileData.phoneNumber)
        }
        
        CXDataService.sharedInstance.getPostedAnswers(ownerId: CXAppConfig.sharedInstance.getAppMallID(), email: "yernagulamahesh@gmail.com") { (responseDict) in
            
            let arr = responseDict["questions"] as! [[String:AnyObject]]
            for gallaeryData in arr {
                let picDic : NSDictionary =  gallaeryData as NSDictionary
                let locationStruct : userQuestions = userQuestions(id: CXAppConfig.resultString(input: picDic.value(forKey:"id")! as AnyObject), question: picDic.value(forKey: "question") as! String, answer: picDic.value(forKey: "answer") as! String, fromDict: picDic.value(forKey: "from") as! NSDictionary, toDict: picDic.value(forKey: "to") as! NSDictionary)
                
                self.requestedQuestionsArr.append(locationStruct)
                self.faqCollectionView.reloadData()
            }
            
        }
        
        
    }
    
}

