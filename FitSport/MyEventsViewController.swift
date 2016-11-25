//
//  MyEventsViewController.swift
//  FitSport
//
//  Created by Manishi on 11/17/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpSideMenu()
        tabViews()
        
//        let refreshButton = UIBarButtonItem(barButtonSystemItem:.add, target: self, action: #selector(MyEventsViewController.buttonMethod))
//        refreshButton.tintColor = UIColor.white
//        navigationItem.rightBarButtonItem = refreshButton
        
        
    }
    
    func buttonMethod() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tabViews(){
        
        var controllerArray : [UIViewController] = []
        
        let controller1:UIViewController = UIStoryboard(name: "MyProfile", bundle: nil).instantiateViewController(withIdentifier: "MyCalenderViewController")
        controller1.title = "MY CALENDER"
        controllerArray.append(controller1)
        
        let controller2 = UIViewController()
        controller2.title = "FAVORITES"
        controllerArray.append(controller2)
        
        let controller3 = UIViewController()
        controller3.title = "CREATED"
        controllerArray.append(controller3)
        
        let controller4 = UIViewController()
        controller4.title = "JOINED EVENTS"
        controllerArray.append(controller4)
        
        let controller5 = UIViewController()
        controller5.title = "PAST EVENTS"
        controllerArray.append(controller5)
        
        let parameters: [CAPSPageMenuOption] = [
            
            .selectionIndicatorColor(UIColor.white),
            .selectedMenuItemLabelColor(UIColor.white),
            .scrollMenuBackgroundColor(CXAppConfig.sharedInstance.getAppTheamColor()),
            .menuItemFont(UIFont(name: "Roboto-Bold", size: 15.0)!),
            
            ]
        
        //pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height+(self.navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
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
        
    }
    
}
