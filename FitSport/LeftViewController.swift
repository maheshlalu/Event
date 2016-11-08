//
//  LeftViewController.swift
//  FitSport_Balu
//
//  Created by apple on 02/11/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var editProfileLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
     var previousSelectedIndex  : NSIndexPath = NSIndexPath()
    @IBOutlet weak var leftTableView: UITableView!
    var nameArray = ["INTEREST SPORTS","EVENTS","TRAINERS","INVITE/SHARE","HELP","SIGN OUT"]
    var imageArray = ["heart","events","trainer","invite","help","logout"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.layer.cornerRadius = 35
        self.imageView.layer.borderWidth = 1
        self.imageView.clipsToBounds = true
 
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.nameArray.count
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let name = "cellid"
        var cell = tableView.dequeueReusableCell(withIdentifier: name)
        
        if cell == nil
        {
             cell = UITableViewCell.init(style: .default, reuseIdentifier: name)
        }
    
        tableView.backgroundColor = UIColor.black
        cell? .backgroundColor = UIColor.clear
        cell?.textLabel?.text = nameArray[indexPath.row]
        cell?.textLabel?.textColor = UIColor.white
        cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
        tableView.allowsSelection = true
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealController : SWRevealViewController  = self.revealViewController()
        
        if indexPath == previousSelectedIndex as IndexPath {
            revealController.revealToggle(animated: true)
            return
        }
        previousSelectedIndex = indexPath as NSIndexPath
        //self.navController.drawerToggle()
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let itemName : String =  nameArray[indexPath.row]
        if itemName == "INTEREST SPORTS"{
//            let homeView = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            let navCntl = UINavigationController(rootViewController: homeView)
//            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "EVENTS"{
//            let aboutUs = storyBoard.instantiateViewControllerWithIdentifier("PROFILE_MEMBERSHIP") as! ProfileMembershipViewController
//            let navCntl = UINavigationController(rootViewController: aboutUs)
//            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "TRAINERS"{
            let trainer = storyBoard.instantiateViewController(withIdentifier: "TrainerViewController") as! TrainerViewController
            let navCntl = UINavigationController(rootViewController: trainer)
            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "INVITE/SHARE"{
//            let howToUse = storyBoard.instantiateViewControllerWithIdentifier("HOW_TO_USE") as! HowToUseViewController
//            let navCntl = UINavigationController(rootViewController: howToUse)
//            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "HELP" {
            //            let wishlist = storyBoard.instantiateViewControllerWithIdentifier("WISHLIST") as! NowfloatWishlistViewController
            //            self.navController.pushViewController(wishlist, animated: true)
            
        }else if itemName == "SIGN OUT"{
            
            showAlertView(message: "Are You Sure??", status: 1)
            
        }
        
    }
    
    func showAlertView(message:String, status:Int) {
        let alert = UIAlertController(title: "FitSport", message: message, preferredStyle: UIAlertControllerStyle.alert)
        //alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            UIAlertAction in
            if status == 1 {
//                Db Clear
                //self.clearDbFiles()

                //Delete userID from nsuserdeafults
               // UserDefaults.standardUserDefaults().removeObjectForKey("USERID")
                
                // for FB signout
                let appDelVar:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                // for Google signout
               // GIDSignIn.sharedInstance().signOut()
               // GIDSignIn.sharedInstance().disconnect()
                
//                appDelVar.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
//                self.navigationController?.popViewController(animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            UIAlertAction in
            if status == 1 {
                
            }
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
  

}
