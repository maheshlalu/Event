//
//  DemoPopupViewController2.swift
//  PopupController
//
//  Created by 佐藤 大輔 on 2/4/16.
//  Copyright © 2016 Daisuke Sato. All rights reserved.
//

import UIKit

class DemoPopupViewController2: UIViewController, PopupContentViewController {
    
    var closeHandler: (() -> Void)?
    @IBOutlet weak var questionTextView: UITextView!
    var toEmailStr:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.layer.borderColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
        questionTextView.layer.cornerRadius = 4
        questionTextView.layer.borderWidth = 2
        
        
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
        return CGSize(width: 300, height: 230)
    }
    
    @IBAction func submitAction(_ sender: AnyObject) {
        submitCall()
    }
    
    @IBAction func closeBtnAction(_ sender: AnyObject) {
        closeHandler!()
    }
    
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

            let finalQueryString = trimmedString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            print(finalQueryString)
  
            CXDataService.sharedInstance.postQuestionsAndAnswers(ownerId: CXAppConfig.sharedInstance.getAppMallID(), toEmail: toEmailStr, fromEmail:fromEmail as String , questionOrAnswer: finalQueryString!, questionID: "", isQuestion: true, completion: { (responseDict) in
                print(responseDict)
                self.closeHandler!()
  
          })
        }
    }
    
    func showAlertView(message:String, status:Int) {
        let alert = UIAlertController(title:message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            if status == 100 {

            }else if status == 200{

            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
