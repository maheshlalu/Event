//
//  TestViewController.swift
//  PageMenuDemoNoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    
     override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpSideMenu()
        tabViews()
       
        navigationController?.isNavigationBarHidden = false
        
        let notificationName = Notification.Name("TapOnTab")
        NotificationCenter.default.addObserver(self, selector: #selector(TestViewController.methodOfReceivedNotification), name: notificationName, object: nil)
   
        let refreshButton = UIBarButtonItem(barButtonSystemItem:.add, target: self, action: #selector(TestViewController.buttonMethod))
        refreshButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = refreshButton


    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         //self.view.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height+(self.navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.width, height: self.view.frame.height)
    }
    
    
    
    
    func buttonMethod() {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tabViews(){
     
     var controllerArray : [UIViewController] = []
     
     let controller1:TrainerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrainerViewController") as! TrainerViewController
        controller1.parentView = self
     let nav : UINavigationController = UINavigationController(rootViewController: controller1)
     nav.navigationBar.isHidden = true
     
     controller1.title = "TRAINERS"
     controllerArray.append(nav)
     
     let controller2 : EventsViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventsViewController") as? EventsViewController)!
    controller2.parentView = self
     let nav1 : UINavigationController = UINavigationController(rootViewController: controller2)
     nav1.navigationBar.isHidden = true
     controller2.title = "EVENTS"
     controllerArray.append(nav1)
     
     let parameters: [CAPSPageMenuOption] = [
     .selectionIndicatorColor(CXAppConfig.sharedInstance.getAppTheamColor()),
     .selectedMenuItemLabelColor(UIColor.white),
     .menuItemFont(UIFont(name: "Roboto-Bold", size: 15.0)!),
     ]
     
     pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height+(self.navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
     
        //  pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
     self.view.addSubview(pageMenu!.view)
        
     }
    
    func setUpSideMenu(){
        
        let menuItem = UIBarButtonItem(image: UIImage(named: "sidePanelMenu-1"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.navigationItem.leftBarButtonItem = menuItem
        let navigation:UINavigationItem = navigationItem
        let image = UIImage(named: "logo_white")
        navigation.titleView = UIImageView(image: image)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //self.sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpOutside)
    }
    
    
    func methodOfReceivedNotification(notification:NSNotification){
        
    }
}
