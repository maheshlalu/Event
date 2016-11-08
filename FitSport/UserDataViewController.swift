//
//  UserDataViewController.swift
//  FitSport
//
//  Created by Manishi on 11/5/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var limitLength = 10
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        let navigation:UINavigationItem = navigationItem
        let image = UIImage(named: "logo_white")
        navigation.titleView = UIImageView(image: image)
        
        self.mobileNumberTextField.delegate = self

        self.userImageView.layer.cornerRadius = 60
        self.userImageView.layer.borderWidth = 1

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
//    
//    func textViewDidChange(_ textView: UITextView) {
//        placeholderLabel.isHidden = !textView.text.isEmpty
//    }

    // TextField Delegate Methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = mobileNumberTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
    
    // TextView Delegate Methods
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count + (text.characters.count - range.length) <= 150
    }

}

//
//extension UITextField {
//    
//    func useUnderline() {
//        
//        let border = CALayer()
//        let borderWidth = CGFloat(1.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = borderWidth
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//}
//
//extension UITextView {
//    
//    func useUnderline() {
//        
//        let border = CALayer()
//        let borderWidth = CGFloat(1.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = borderWidth
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//    
//}

//extension UITextField {
//    
//    func useUnderline() {
//        
//        let border = CALayer()
//        let borderWidth = CGFloat(1.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = borderWidth
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//}
//
//extension UITextView {
//    
//    func useUnderline() {
//        
//        let border = CALayer()
//        let borderWidth = CGFloat(1.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = borderWidth
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//}


