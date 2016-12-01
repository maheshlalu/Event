//
//  FAQViewController.swift
//  FitSport
//
//  Created by Manishi on 11/30/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpSideMenu()
        tabViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabViews(){
        
        var controllerArray : [UIViewController] = []
        
        let controller1:YourQuestionsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YourQuestionsViewController") as! YourQuestionsViewController
        controller1.title = "Your Questions"
        controllerArray.append(controller1)
        
        let controller2 : RequestedQuestionsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestedQuestionsViewController") as! RequestedQuestionsViewController
        controller2.title = "Requested Questions"
        controllerArray.append(controller2)
        
        
        let parameters: [CAPSPageMenuOption] = [
            .selectionIndicatorColor(UIColor.white),
            .selectedMenuItemLabelColor(UIColor.white),
            .menuItemFont(UIFont(name: "Roboto-Bold", size: 15.0)!),
            .menuHeight(40),
            .scrollMenuBackgroundColor(CXAppConfig.sharedInstance.getAppTheamColor())
        ]
        
        
        //pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 253 , width: self.view.frame.width, height: self.view.frame.height - 309), pageMenuOptions: parameters)
        
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
        
        //self.sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpOutside)
    }
    
}
