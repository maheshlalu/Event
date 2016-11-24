//
//  TrainerViewController.swift
//  FitSport
//
//  Created by Manishi on 11/7/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class TrainerViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{

    var screenWidth:CGFloat! = nil
    @IBOutlet weak var EventCollectionView: UICollectionView!
    var trainerArray = [[String:AnyObject]]()
    var parentView:TestViewController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        let nib = UINib(nibName: "TrainerCollectionViewCell", bundle: nil)
        self.EventCollectionView.register(nib, forCellWithReuseIdentifier: "TrainerCollectionViewCell")
        self.geTheTrainersFromServer()
        self.EventCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0)
       // setUpSideMenu()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func geTheTrainersFromServer(){
        CXDataService.sharedInstance.getTheAppDataFromServer(["type":"macIdinfo" as AnyObject,"mallId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (dict) in
           let arr = dict["jobs"] as! [[String:AnyObject]]
            
            
            for gallaeryData in arr {
                
                let picDic : NSDictionary =  gallaeryData as NSDictionary
                
                print(picDic.allKeys)
                print( picDic.value(forKey: "UserType"))
                
                if picDic.value(forKey: "UserType")! as! String == "Trainer"{
                    
                self.trainerArray.append(picDic as! [String : AnyObject])
                    
                }
            }
            print(self.trainerArray.description)
            self.EventCollectionView.reloadData()
        }
        
    }
    
    
    func setUpSideMenu(){
        
        let menuItem = UIBarButtonItem(image: UIImage(named: "sidePanelMenu-1"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.navigationItem.leftBarButtonItem = menuItem
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //self.sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpOutside)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection   : Int) -> Int
    {
        return self.trainerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell", for: indexPath)as? TrainerCollectionViewCell
        
        cell?.layer.cornerRadius = 5
        let dict = trainerArray[indexPath.item]
        cell?.trainerNameLabel.text = dict["Name"] as? String
        cell?.trainerDescriptionLabel.text = dict["Description"] as? String
        //Interests
        if dict["Interests"] != nil
        {
            let intrests : String = (dict["Interests"] as? String)!
            let intrestStr = intrests.components(separatedBy: ("(")).first
            
            cell?.sportsCategoryLabel.text = intrestStr
        }
        if dict["Image"] != nil {
            let url = NSURL(string: dict["Image"] as! String)
            cell?.trainerImage.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
        }
        return cell!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/2-9,height: 206)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let dict = trainerArray[indexPath.item]
        print(dict)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let productDetails = storyBoard.instantiateViewController(withIdentifier: "PackageViewController") as! PackageViewController
        productDetails.userDict = dict as NSDictionary!
        let navController = UINavigationController(rootViewController: productDetails) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.parentView.present(navController, animated:true, completion: nil)
        

        //        let dict = trainerArray[indexPath.item]
        //        print(dict)
        //        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //        let selectSport = storyBoard.instantiateViewController(withIdentifier: "PackageViewController") as! PackageViewController
        //        self.navigationController?.pushViewController(selectSport, animated: true)
        
    }
    
}

