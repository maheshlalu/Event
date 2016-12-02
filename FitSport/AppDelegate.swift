//
//  AppDelegate.swift
//  FitSport
//
//  Created by Manishi on 11/3/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
import Google
import GoogleSignIn
import GGLCore
import MagicalRecord
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,SWRevealViewControllerDelegate,GIDSignInDelegate {
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.barTintColor = CXAppConfig.sharedInstance.getAppTheamColor()
        
        let myAttributeTxtColor = [NSForegroundColorAttributeName: UIColor.white]
        let myAttribute = [ NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 20.0)!]
        navigationBarAppearace.titleTextAttributes = myAttribute
        navigationBarAppearace.titleTextAttributes = myAttributeTxtColor

        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().delegate = self
        self.setUpMagicalDB()
        applicationNavigationFlow()
        self.fireBaseSetup()
       print(getDocumentsDirectory())
        
        //LoadingView
        return true
    }
    
    func fireBaseSetup(){
        FIRApp.configure()
    }
    
    func applicationNavigationFlow(){
        let userId = CXAppConfig.sharedInstance.getLoggedUserID()
        print(userId)
        if userId.isEmpty {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "PagerMain", bundle: nil)
            let exampleViewController: SignInViewController = mainStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            let navCntl : UINavigationController = UINavigationController(rootViewController: exampleViewController)
            self.window?.rootViewController = navCntl
            self.window?.makeKeyAndVisible()
            
        }else{
            
            self.setUpSidePanl()
            
        }
        
    }
    func setUpSidePanl(){
        
        let wFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.window = UIWindow.init(frame: wFrame)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeView = TestViewController(nibName: "TestViewController", bundle: nil)
        let menuVC = storyBoard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        
        let menuVCNav = UINavigationController(rootViewController: menuVC)
        menuVCNav.isNavigationBarHidden = true
        
        let navHome = UINavigationController(rootViewController: homeView)
        //navHome.isNavigationBarHidden = true
        
        let revealVC = SWRevealViewController(rearViewController: menuVCNav, frontViewController: navHome)
        revealVC?.delegate = self
        self.window?.rootViewController = revealVC
        self.window?.makeKeyAndVisible()
        

        
       
        
        //        let drawer : ICSDrawerController = ICSDrawerController(leftViewController: menuVC, centerViewController: homeView)
        //        self.window?.rootViewController = drawer
        //        self.window?.makeKeyAndVisible()
        
    }
    
    // MARK: - Core Data stack
    
    func setUpMagicalDB() {
        //MagicalRecord.setupCoreDataStackWithStoreNamed("Silly_Monks")
        MagicalRecord.setupCoreDataStack(withStoreNamed: "FitSportData")
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let callBack:Bool
        // print("***************************url Schemaaa:", url.scheme);
        
        if url.scheme == "fb261259334276980" {
            callBack = FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
        } else {
            callBack =  GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        }
        return callBack
    }
    
    
    //MARK: - Google Sign in
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations on signed in user here.
        if (error == nil) {
            var firstName = ""
            var lastName = ""
            // let userId = user.userID
            var profilePic = ""
            var email = ""
            
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let url = NSURL(string:  "https://www.googleapis.com/oauth2/v3/userinfo?access_token=\(user.authentication.accessToken!)")
            let session = URLSession.shared
            session.dataTask(with: url! as URL) {(data, response, error) -> Void in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                do {
                    let userData = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String:AnyObject]
                    print(userData)
                    
                    let orgID:String! = CXAppConfig.sharedInstance.getAppMallID()
                    firstName = userData!["given_name"] as! String
                    lastName = userData!["family_name"] as! String
                    profilePic = userData!["picture"] as! String
                    email = userData!["email"] as! String
                    
                    print("\(email)\(firstName)\(lastName)\(profilePic)\(orgID)")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GoogleSignUp"), object: userData)
                    
                } catch {
                    NSLog("Account Information could not be loaded")
                }
                
                }.resume()
        }
            
        else {
            //Login Failed
            NSLog("login failed")
            return
            
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
                withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "FitSport")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

