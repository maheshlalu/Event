//
//  PackageViewController.swift
//  FitSportProject
//
//  Created by Rama kuppa on 10/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class PackageViewController: UIViewController,FloatRatingViewDelegate,UIGestureRecognizerDelegate{

    @IBOutlet weak var askMeQstView: UIView!
    @IBOutlet weak var viewBottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var packageShareBtn: UIButton!
    @IBOutlet weak var packageFollowingBtn: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var rateView: FloatRatingView!
    @IBOutlet weak var shareBtn: UIButton!
    var pageMenu : CAPSPageMenu?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getTrainerProfileDetails()
      
    }
    
    func barViewAlignments(){
        
        // User Image Customization
        self.userImageView.layer.cornerRadius = 50.0
        self.userImageView.layer.borderWidth = 2
        self.userImageView.layer.borderColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
        self.userImageView.clipsToBounds = true
        
        //following Btn Customization
        self.packageFollowingBtn.layer.cornerRadius = 5
        self.packageFollowingBtn.layer.borderWidth = 1
        self.packageFollowingBtn.clipsToBounds = true
        self.packageFollowingBtn.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func askMeViewGestures(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PackageViewController.handleTap))
        tap.delegate = self
        askMeQstView.addGestureRecognizer(tap)
    }
    
    func setUpSideMenu(){
        
        let menuItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(PackageViewController.backBtnAction))
        self.navigationItem.leftBarButtonItem = menuItem
        let navigation:UINavigationItem = navigationItem
        let image = UIImage(named: "logo_white")
        navigation.titleView = UIImageView(image: image)

    }
    
    func backBtnAction(){
    
        dismiss(animated: true, completion: nil)
    
    }
    
    
    func handleTap(){
        print("Happy")
        
    }
    
    @IBAction func shareAction(_ sender: AnyObject) {
        
        let shareText = "Fitsport"
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @IBAction func askMeQstBtn(_ sender: AnyObject) {
        self.handleTap()
    }
    
    
    func setUpRatingView(){
        //star
        
        // ratingView.emptyImage = UIImage(named: "star.png")
        //ratingView.fullImage = UIImage(named: "star_sel_108.png")
        // Optional params
        //ratingView.delegate = self
        rateView.contentMode = UIViewContentMode.scaleAspectFit
        //ratingView.maxRating = 5
        //ratingView.minRating = 0
        //ratingView.rating = 0
        rateView.editable = false
        rateView.halfRatings = true
        rateView.floatRatings = false
        
    }
    
    
    //FloatRatingViewDelegates
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float){
    
    }
    
    /**
     Returns the rating value as the user pans
     */
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Float){
        
    }
    
    
    
    func tabViews(){
        
        var controllerArray : [UIViewController] = []
        
        let controller1:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrainerProfileViewController")
        controller1.title = "Profile"
        controllerArray.append(controller1)
        
        let controller2 : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrainerCertificationViewController")
        controller2.title = "Certification"
        controllerArray.append(controller2)
        
        let controller3 : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrainerPackagesViewController")
        controller3.title = "Packages"
        controllerArray.append(controller3)
        
        let parameters: [CAPSPageMenuOption] = [
            .selectionIndicatorColor(CXAppConfig.sharedInstance.getAppTheamColor()),
            .selectedMenuItemLabelColor(UIColor.white),
            .menuItemFont(UIFont(name: "Roboto-Bold", size: 15.0)!),
            .menuHeight(40)
            ]
        
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 253 , width: self.view.frame.width, height: self.view.frame.height - 309), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
    
    //http://storeongo.com:8081/Services/getMasters?type=MacIdInfo&mallId=20221
    func getTrainerProfileDetails(){
        
        CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(CXAppConfig.sharedInstance.getBaseUrl()+CXAppConfig.sharedInstance.getMasterUrl(), parameters: ["type":"MacIdInfo" as AnyObject,"mallId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (responseDict) in
            print(responseDict)
            
            let status: Int = Int(responseDict.value(forKey: "status") as! String)!
            
            if status == 1{
                
                self.barViewAlignments()
                self.setUpSideMenu()
                self.tabViews()
                self.setUpRatingView()
                self.askMeViewGestures()
            
            }
            
        }
        
    }

}
