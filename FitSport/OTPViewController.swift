//
//  OTPViewController.swift
//  FitSport
//
//  Created by Manishi on 11/7/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var otpEnterBtn: UIButton!
    @IBOutlet weak var otpTxtField: UITextField!
    var consumerEmailID: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        //self.navigationItem.setHidesBackButton(true, animated:true);
        let navigation:UINavigationItem = navigationItem
        let image = UIImage(named: "logo_white")
        navigation.titleView = UIImageView(image: image)
        
        
        NotificationCenter.default.addObserver(self, selector:#selector(OTPViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(OTPViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(OTPViewController.handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
        
    }

    @IBAction func otpEnterBtnAction(_ sender: AnyObject) {
        if otpTxtField.text?.characters.count == nil{
            showAlertView(message: "OTP Field Can't be Empty!!!", status: 0)
        }else{
            self.comparingFieldWithOTP()
        }
    }
    
    
    func comparingFieldWithOTP(){
        
        CX_SocialIntegration.sharedInstance.validatingRecievedOTP(consumerEmailId: self.consumerEmailID, enteredOTP: self.otpTxtField.text!) { (responseDict) in
            print(responseDict)
            let status: Int = Int(responseDict.value(forKey: "status") as! String)!
            let message = responseDict.value(forKey: "message") as! String
            
            if status == 1{
               // updating the userdict with otp key
                //self.updatingUserDict(otp:self.otpTxtField.text!)
                 // Leading to SelectSport View
                self.showAlertView(message: message, status: 100)
                
                
            }else{
                // Error
                self.showAlertView(message: message, status: 0)
            }
        }
    }
    
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y = -(keyboardSize.height-60)
            }
            else {
                
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if ((sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
            else {
                
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.resignFirstResponder()
    }
    
    // adding OTP object UserDictionary
    func updatingUserDict(otp:String){
        
        let jsonDic : NSMutableDictionary = NSMutableDictionary(dictionary: CXAppConfig.sharedInstance.getUserUpdateDict())
        jsonDic.setObject(otp, forKey: "User_OTP" as NSCopying)
        CXAppConfig.sharedInstance.setUserUpdateDict(dictionary: jsonDic)
        
        
         let userDict = CXAppConfig.sharedInstance.getUserUpdateDict()
         let jsonUpdateDic : NSMutableDictionary = NSMutableDictionary(dictionary: CXAppConfig.sharedInstance.getUserUpdateDict())
         jsonUpdateDic.setObject(userDict.value(forKey: "mobileNo")!, forKey: "mobileNo" as NSCopying)
         CX_SocialIntegration.sharedInstance.activeTheUser(parameterDic: jsonUpdateDic, jobId: CXAppConfig.sharedInstance.getMacJobID()) {
            
        }
  
        
    }
    
    
    
    
    func showAlertView(message:String, status:Int) {
        let alert = UIAlertController(title:message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            if status == 100 {
                let storyBoard = UIStoryboard(name: "PagerMain", bundle: Bundle.main)
                let selectSport = storyBoard.instantiateViewController(withIdentifier: "SelectTableViewController") as! SelectTableViewController
                self.navigationController?.pushViewController(selectSport, animated: true)
            }else{
                
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
