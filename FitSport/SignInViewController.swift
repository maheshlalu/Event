//
//  TutorialViewController.swift
//  UIPageViewController Post
//
//  Created by Jeffrey Burt on 2/3/16.
//  Copyright © 2016 Seven Even. All rights reserved.
//

//https://github.com/ninjaprox/NVActivityIndicatorView for ActivityIndicator

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Google
import GoogleSignIn
import GGLCore

class SignInViewController: UIViewController,GIDSignInUIDelegate{
    
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    var googleResponseDict: NSDictionary! = nil
    @IBOutlet weak var googleBtn:GIDSignInButton!
    var window: UIWindow?
    
    var tutorialPageViewController: SignInPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skipBtn.layer.cornerRadius = 3
        
        pageControl.addTarget(self, action: #selector(SignInViewController.didChangePageControlValue), for: .valueChanged)
        self.navigationController?.isNavigationBarHidden = true
        
//        fbBtn.delegate = self
//        fbBtn.readPermissions = ["public_profile", "email", "user_friends","user_about_me"];
//        fbBtn.tooltipBehavior = .disable
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        NotificationCenter.default.addObserver(self, selector:#selector(SignInViewController.googleSignUp(notification:)), name: NSNotification.Name(rawValue: "GoogleSignUp"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? SignInPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        tutorialPageViewController?.scrollToNextViewController()
    }
    
    @IBAction func skipAction(_ sender: AnyObject) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.setUpSidePanl()
    }
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    // FB Login Button Action
    
    @IBAction func loginButtonAction(_ sender: AnyObject) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends","user_about_me"], from: self) { (result, error) in
                  if error == nil {
             print("Logged in through facebook" )
              self.getFBUserData()
             }
             else {
             print("Facebook Login Error----\n",error)
             }
        }
    }
    
    func getFBUserData(){
        
        if((FBSDKAccessToken.current()) != nil){
            
            FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name,email,last_name,gender,picture.type(large),id"]).start { (connection, result, error) -> Void in
                let fbResultDict:NSDictionary = result as! NSDictionary
                print(fbResultDict)
                CX_SocialIntegration.sharedInstance.applicationRegisterWithFaceBook(userDataDic: fbResultDict, completion: { (isRegistred) in
                    //IsRegistred is true no need send the otp otherwise send the otp
                    self.screenNavigationAfterSignIng(boolValue: isRegistred)
                })
            }
        }
    }
    
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
//        loginManager.logOut()
//    }
    
    /*
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //print("Response \(result)")
        
        if (error == nil){
            let fbloginresult : FBSDKLoginManagerLoginResult = result
            if result.isCancelled {
                return
            }
            if(fbloginresult.grantedPermissions.contains("email"))
            {
            }
        }
        
        if result != nil{
            FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name,email,last_name,gender,picture.type(large),id"]).start { (connection, result, error) -> Void in
                let fbResultDict:NSDictionary = result as! NSDictionary
                print(fbResultDict)
                CX_SocialIntegration.sharedInstance.applicationRegisterWithFaceBook(userDataDic: fbResultDict, completion: { (isRegistred) in
                    //IsRegistred is true no need send the otp otherwise send the otp
                   //self.screenNavigationAfterSignIng(boolValue: isRegistred)
                    
                    let storyBoard = UIStoryboard(name: "PagerMain", bundle: Bundle.main)
                    let trainer = storyBoard.instantiateViewController(withIdentifier: "UserDataViewController") as! UserDataViewController
                    self.navigationController?.pushViewController(trainer, animated: true)
                    
                })
            }
        }
    }
    */
    
    func screenNavigationAfterSignIng(boolValue : Bool){
        if !boolValue {
            let storyBoard = UIStoryboard(name: "PagerMain", bundle: Bundle.main)
            let trainer = storyBoard.instantiateViewController(withIdentifier: "UserDataViewController") as! UserDataViewController
            self.navigationController?.pushViewController(trainer, animated: true)

        }else{
            //Navigate To Home Screen
            CXAppConfig.sharedInstance.loggedUser(userID: CXAppConfig.sharedInstance.getUserID())
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.setUpSidePanl()
        }
    }
    
    // Google+ Integration
    
    @IBAction func googleBtnAction(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().clientID = "910235619017-len85sj7um29bm957da9vofebc8ee8gf.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().signIn()
        //910235619017-len85sj7um29bm957da9vofebc8ee8gf.apps.googleusercontent.com
    }

    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //  myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func googleSignUp(notification: NSNotification){
        
        let dic = notification.object as! [String:AnyObject]
         self.googleResponseDict = dic as NSDictionary!
        print(self.googleResponseDict)
        CX_SocialIntegration.sharedInstance.applicationRegisterWithGooglePlus(userDataDic: self.googleResponseDict, completion: { (isRegistred) in
            //IsRegistred is true no need send the otp otherwise send the otp
            self.screenNavigationAfterSignIng(boolValue: isRegistred)
            
        })
        
//        let orgID:String! = CXAppConfig.sharedInstance.getAppMallID()
//        let firstName = dic["given_name"] as! String
//        let lastName = dic["family_name"] as! String
//        let  profilePic = dic["picture"] as! String
//        let  email = dic["email"] as! String
        
        
    }


    func showAlertView(message:String, status:Int) {
        
            let alert = UIAlertController(title: "FitSport", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                UIAlertAction in
                if status == 1 {
                    //self.navigationController?.popViewController(animated: true)
                }
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
    }

}

extension SignInViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: SignInPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: SignInPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
