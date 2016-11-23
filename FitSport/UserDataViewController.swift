//
//  UserDataViewController.swift
//  FitSport
//
//  Created by Manishi on 11/5/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var container: UIView!
    var limitLength = 10
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var aboutYourSelf: UITextField!
    var userEmail:String!
    var userPic:String!
    var editImage:Bool = false
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let appdata:NSArray = UserProfile.mr_findAll() as NSArray
    
        if appdata.count != 0{
            
            let userProfileData:UserProfile = appdata.lastObject as! UserProfile
            userPic = userProfileData.userPic!
            let url = NSURL(string: userProfileData.userPic!)
            userImageView.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
            userNameLabel.text = "Hi, \(userProfileData.firstName!)"
            userEmail = userProfileData.emailId!
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
        userImageView!.layer.masksToBounds = true
        userImageView!.clipsToBounds = true


    }
    
    @IBAction func doneBtnAction(_ sender: AnyObject) {
        
        if mobileNumberTextField.text?.characters.count == 10 && (mobileNumberTextField != nil){
            self.savingDetailsToUserDict()
            emailCheckingForOTP()
            
        } else {
            self.showAlertView(message: "Please Enter Valid Mobile Number", status: 0)
        }
        
    }
    
    // OTP Methods
    func emailCheckingForOTP(){
        
        CX_SocialIntegration.sharedInstance.varifyingEmailForOTP(comsumerEmailId: self.userEmail) { (responseDict) in
            print(responseDict)
            let status: Int = Int(responseDict.value(forKey: "status") as! String)!
            let message = responseDict.value(forKey: "message") as! String
            if status == 1{
                // If Status is 1 then the user email id is already regesterd with email.Can't able to send OTP. Which means give another email.
                 self.showAlertView(message: message, status: 200)
                return
            }else{
                //Sending the OTP to given mobile number (status is -1 or 0). Eligible to send OTP.
                self.sendingOTPForGivenNumber()
            }
        }
    }
    
    func savingDetailsToUserDict(){
        
        let jsonDic:NSMutableDictionary = NSMutableDictionary()
        
        if editImage == true{
            self.imageUpload()
            jsonDic.setObject(UserDefaults.standard.value(forKey: "EDIT_IMG_URL"), forKey: "Image" as NSCopying)
        }else{
            jsonDic.setObject(self.userPic, forKey: "Image" as NSCopying)
        }
        jsonDic.setObject(mobileNumberTextField.text!,forKey: "mobileNo" as NSCopying)
        
        if (descriptionTxtView.text.characters.count != 0){
            jsonDic.setObject(descriptionTxtView.text!, forKey: "Description" as NSCopying)
        }else{
            jsonDic.setObject("No Description Available", forKey: "Description" as NSCopying)
        }
        
        print(jsonDic)
        CXAppConfig.sharedInstance.setUserUpdateDict(dictionary:jsonDic)
        
    }
    
    func sendingOTPForGivenNumber(){
        
        CX_SocialIntegration.sharedInstance.sendingOTPToGivenNumber(consumerEmailId: self.userEmail, mobile: self.mobileNumberTextField.text!) { (responseDict) in
            print(responseDict)
            let status: Int = Int(responseDict.value(forKey: "status") as! String)!
            if status == 1{
                // OTP SENT
                //After sending the OTP to given number, pushing to OTPViewController
                self.showAlertView(message: "OTP sent Successfully!!!", status: 100)
                
            }else{
                // OTP NOT SENT
                self.showAlertView(message: "Something Went Wrong!! Pleace check Email!!!", status: 0)
            }
        }
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
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
    
    
    func imageUpload(){
        CXDataService.sharedInstance.imageUpload(imageData: UserDefaults.standard.object(forKey: "IMG_DATA") as! NSData, completion: { (response) in
            DispatchQueue.main.async {
                print(response)
                let status: Int = Int(response.value(forKey: "status") as! String)!
                
                if status == 1{
                    let imgStr = response.value(forKey: "filePath") as! String
                    let url = NSURL(string: imgStr)
                    self.userImageView.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
                    self.editImage = true
                    UserDefaults.standard.set(imgStr, forKey: "EDIT_IMG_URL")
                }
            }
            
        })
    }
    
    func showAlertView(message:String, status:Int) {
        let alert = UIAlertController(title:message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            if status == 100 {
                let storyBoard = UIStoryboard(name: "PagerMain", bundle: Bundle.main)
                let selectSport = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                selectSport.consumerEmailID = self.userEmail
                self.navigationController?.pushViewController(selectSport, animated: true)
            }else if status == 200{
                let appDel = UIApplication.shared.delegate as! AppDelegate
                appDel.setUpSidePanl()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}


