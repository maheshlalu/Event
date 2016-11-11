//
//  UserDataViewController.swift
//  FitSport
//
//  Created by Manishi on 11/5/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var limitLength = 10
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var aboutYourSelf: UITextField!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let appdata:NSArray = UserProfile.mr_findAll() as NSArray
        if appdata.count != 0{
            
            let userProfileData:UserProfile = appdata.lastObject as! UserProfile
            userImageView.setImageWith(NSURL(string: userProfileData.userPic!) as! URL)
            userNameLabel.text = "Hi,\(userProfileData.firstName!)"
            
        }
        shadowView()
        
        //Navigation Bar Customization
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        let navigation:UINavigationItem = navigationItem
        let image = UIImage(named: "logo_white")
        navigation.titleView = UIImageView(image: image)
        
        self.mobileNumberTextField.delegate = self
        self.descriptionTxtView.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector:#selector(UserDataViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(UserDataViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UserDataViewController.handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
        
        
        //Image Tap Gesture
        
        let imgTap:UIGestureRecognizer = UITapGestureRecognizer.init()
        imgTap.addTarget(self, action: #selector(UserDataViewController.imagePickerAction(sender:)))
        self.userImageView.addGestureRecognizer(imgTap)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.resignFirstResponder()
    }
    
    func shadowView(){
        userImageView.layer.cornerRadius = 60
        userImageView.layer.borderWidth = 3
        userImageView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    @IBAction func doneBtnAction(_ sender: AnyObject) {
        
        
    }
    
    @IBAction func editimageAction(_ sender: AnyObject) {
        imagePickerAction(sender: sender)
    }
    
    func imagePickerAction(sender: AnyObject){
        
        print("choose from photos")
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        aboutYourSelf.placeholder = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        aboutYourSelf.placeholder = "About Youself"
    }
    
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
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        aboutYourSelf.placeholder = nil
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
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImageView.contentMode = .scaleToFill
            userImageView.image = pickedImage
            let image = pickedImage as UIImage
            let imageData = NSData(data: UIImagePNGRepresentation(image)!)
            UserDefaults.standard.set(imageData, forKey: "IMG_DATA")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }

}


