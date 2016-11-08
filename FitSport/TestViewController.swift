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
   

    }
    
    func tabViews(){
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let controller1:UIViewController = UIStoryboard(name: "MyProfile", bundle: nil).instantiateViewController(withIdentifier: "Calender") as UIViewController
        controller1.title = "MY Calender"
        controllerArray.append(controller1)
        
        let controller2 : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventsViewController")
        controller2.title = "Joined Events"
        controllerArray.append(controller2)
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: UIApplication.shared.statusBarFrame.height+(self.navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: nil)

        self.view.addSubview(pageMenu!.view)
    }
    
    func setUpSideMenu(){
        
        let menuItem = UIBarButtonItem(image: UIImage(named: "sidePanelMenu-1"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.navigationItem.leftBarButtonItem = menuItem
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //self.sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpOutside)
    }
}
