//
//  LeftViewController.swift
//  FitSport_Balu
//
//  Created by apple on 02/11/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
class LeftViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var editProfileLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
     var previousSelectedIndex  : NSIndexPath = NSIndexPath()
    @IBOutlet weak var leftTableView: UITableView!
    var nameArray = ["HOME","INTEREST SPORTS","EVENTS","TRAINERS","BOOKING HISTORY","FAQ","SIGN OUT"]
    var imageArray = ["home","heart","events","trainer","history","help","logout"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appdata:NSArray = UserProfile.mr_findAll() as NSArray
        
        if appdata.count != 0{
            let userProfileData:UserProfile = appdata.lastObject as! UserProfile
            let url = NSURL(string: userProfileData.userPic!)
            imageView.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
            nameLabel.text = userProfileData.firstName!
        }else{
            nameArray[nameArray.endIndex-1] = "SIGN IN"
            imageView.image = UIImage(named: "placeholder")
            nameLabel.text = "Guest"
            editProfileLabel.isHidden = true
        }
        
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
        
        if itemName == "HOME"{
            
            let homeView = TestViewController(nibName: "TestViewController", bundle: nil)
            let navCntl = UINavigationController(rootViewController: homeView)
            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "INTEREST SPORTS"{
           // let notificationName = Notification.Name("TapOnTab")
           // NotificationCenter.default.post(name: notificationName, object: nil)
//            let homeView = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            let navCntl = UINavigationController(rootViewController: homeView)
//            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "EVENTS"{
            
            let homeView = TestViewController(nibName: "TestViewController", bundle: nil)
            homeView.fromSidePanelEvent = true
            let navCntl = UINavigationController(rootViewController: homeView)
            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "TRAINERS"{
            
            let homeView = TestViewController(nibName: "TestViewController", bundle: nil)
            let navCntl = UINavigationController(rootViewController: homeView)
            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "BOOKING HISTORY"{
            let howToUse = storyBoard.instantiateViewController(withIdentifier: "BookingHistoryViewController") as! BookingHistoryViewController
            let navCntl = UINavigationController(rootViewController: howToUse)
            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "FAQ" {
            
            let homeView = FAQViewController()
            let navCntl = UINavigationController(rootViewController: homeView)
            revealController.pushFrontViewController(navCntl, animated: true)
            
        }else if itemName == "SIGN OUT"{
            
            showAlertView(message: "Are You Sure??", status: 1)
            
        }else if itemName == "SIGN IN"{
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.applicationNavigationFlow()
        }
        
    }
    
    
    func showAlertView(message:String, status:Int) {
        let alert = UIAlertController(title: "FitSport", message: message, preferredStyle: UIAlertControllerStyle.alert)
        //alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            UIAlertAction in
            if status == 1 {
                //Db Clear
                self.clearDbFiles()
                
                //Delete userID from nsuserdeafults
                UserDefaults.standard.removeObject(forKey: "USERID")
                
                // for FB signout
                let appDelVar:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                // for Google signout
                GIDSignIn.sharedInstance().signOut()
                GIDSignIn.sharedInstance().disconnect()
            
                appDelVar.applicationNavigationFlow()
                //self.navigationController?.popViewControllerAnimated(true)
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
    
    func clearDbFiles(){
        
        let fileManager = FileManager.default
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: "\(documentsUrl)")
            for filePath in filePaths {
                try fileManager.removeItem(atPath: NSTemporaryDirectory() + filePath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }

        UserProfile.mr_truncateAll()
        
    }

}

