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

}
