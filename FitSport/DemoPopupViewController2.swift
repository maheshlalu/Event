//
//  DemoPopupViewController2.swift
//  PopupController
//
//  Created by 佐藤 大輔 on 2/4/16.
//  Copyright © 2016 Daisuke Sato. All rights reserved.
//

import UIKit

class DemoPopupViewController2: UIViewController, PopupContentViewController {
    
    @IBOutlet weak var topLbl: UILabel!
    var closeHandler: (() -> Void)?
    @IBOutlet weak var questionTextView: UITextView!
    var toEmailStr:String!
    
    var fromFAQ:Bool = false
    var faqDict:NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.layer.borderColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
        questionTextView.layer.cornerRadius = 4
        questionTextView.layer.borderWidth = 2
        
        if fromFAQ{
        print(faqDict)
        topLbl.text = "Write Answer Below"
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layer.cornerRadius = 4
    }
    
    class func instance() -> DemoPopupViewController2 {
        let storyboard = UIStoryboard(name: "DemoPopupViewController2", bundle: nil)
        return storyboard.instantiateInitialViewController() as! DemoPopupViewController2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSize(width: 300, height: 190)
    }
    
    @IBAction func submitAction(_ sender: AnyObject) {
        if fromFAQ{
            faqSubmitCall()
        }else{
            submitCall()
        }
        
    }
    
    @IBAction func closeBtnAction(_ sender: AnyObject) {
        closeHandler!()
    }
    
    // Submit call for Ask Question
    func submitCall(){
        
        let myString = questionTextView.text!
        let trimmedString = myString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        
        if trimmedString.characters.count == 0{
            showAlertView(message: "Field cann't be empty!!!", status: 0)
        }else{
            var fromEmail:String = String()
            let appdata:NSArray = UserProfile.mr_findAll() as NSArray
            if appdata.count != 0{
                let userProfileData:UserProfile = appdata.lastObject as! UserProfile
                print(userProfileData.emailId)
                fromEmail = userProfileData.emailId!
            }

            let finalQueryString = trimmedString
            print(finalQueryString)
  
            CXDataService.sharedInstance.postQuestionsAndAnswers(ownerId: CXAppConfig.sharedInstance.getAppMallID(), toEmail: toEmailStr, fromEmail:fromEmail as String , questionOrAnswer: finalQueryString, questionID: "", isQuestion: true, completion: { (responseDict) in
                print(responseDict)
                let status: Int = Int(responseDict.value(forKey: "status") as! String)!
                let message = responseDict.value(forKey: "message") as! String
                if status == 1{
                    self.showAlertView(message: message, status: 100)
                }
  
          })
        }
    }
    
    //Submit Call for Ask Answer
    func faqSubmitCall() {
        // Encode String
        /*   let finalQueryString = trimmedString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
         print(finalQueryString)*/
        let myString = questionTextView.text!
        let trimmedString = myString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
        if trimmedString.characters.count == 0{
            showAlertView(message: "Field cann't be empty!!!", status: 0)
        }else{
            
            CXDataService.sharedInstance.postQuestionsAndAnswers(ownerId:CXAppConfig.sharedInstance.getAppMallID(), toEmail: faqDict.value(forKey: "toEmail") as! String, fromEmail: faqDict.value(forKey: "fromEmail") as! String, questionOrAnswer: trimmedString, questionID: faqDict.value(forKey: "id") as! String, isQuestion:false ) { (response) in
                print(response)
                let status: Int = Int(response.value(forKey: "status") as! String)!
                let message = response.value(forKey: "message") as! String
                if status == 1{
                    self.showAlertView(message: message, status: 100)
                }
            }
        }
    }
    
    func showAlertView(message:String, status:Int) {
        let alert = UIAlertController(title:message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            if status == 100 {
                self.closeHandler!()

            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
