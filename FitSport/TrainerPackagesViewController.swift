//
//  TrainerPackagesViewController.swift
//  FitSport
//
//  Created by Manishi on 11/18/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

struct StoreLocations {
    
    var sessionType: String
    var price: String
    var duration: String
    
}

class TrainerPackagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,FloatRatingViewDelegate {
    
    @IBOutlet weak var noContentLbl: UILabel!
    @IBOutlet weak var packageTableView: UITableView!
    var galleryDict:NSDictionary?
    var merchantDict:NSMutableDictionary! = nil
    var storeLocationArray = [StoreLocations]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parsingAboutUsDetails()
        packageTableView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0)
        let nib = UINib(nibName: "PackageTableViewCell", bundle: nil)
        self.packageTableView.register(nib, forCellReuseIdentifier: "PackageTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if ((galleryDict?.value(forKey: "SessionType")) as! String != ""){
             return storeLocationArray.count
        }else{
            self.noContentLbl.isHidden = false
            self.packageTableView.isHidden = true
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageTableViewCell", for: indexPath)as? PackageTableViewCell
        
        cell?.rateView.contentMode = UIViewContentMode.scaleAspectFit
        cell?.rateView.editable = false
        cell?.rateView.halfRatings = true
        cell?.rateView.floatRatings = false
        
        let storeLocation : StoreLocations =  (self.storeLocationArray[indexPath.row] as? StoreLocations)!
        
        cell?.sessionPriceLbl.text = "₹" + (storeLocation.price)
        cell?.sessionTypeLbl.text = storeLocation.sessionType
        cell?.sessionDurationLbl.text = "Duration: "+(storeLocation.duration)
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 90)
        
    }
    
    //FloatRatingViewDelegates
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float){
        
    }
    
    /**
     Returns the rating value as the user pans
     */
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Float){
        
    }
    
    func parsingAboutUsDetails(){
        
        self.merchantDict = NSMutableDictionary()
        self.merchantDict!.setObject((galleryDict?.value(forKey: "Price"))!, forKey: "Price" as NSCopying)
        self.merchantDict!.setObject((galleryDict?.value(forKey: "SessionType"))!, forKey: "SessionType" as NSCopying)
        self.merchantDict!.setObject((galleryDict?.value(forKey: "Duration"))!, forKey: "Duration" as NSCopying)
        self.packageTableView.reloadData()
        
        let priceStr = (galleryDict?.value(forKey: "Price"))! as! NSString
        let sessionStr = (galleryDict?.value(forKey: "SessionType"))! as! NSString
        let durationStr = (galleryDict?.value(forKey: "Duration"))! as! NSString
        
            
        let priceArr = priceStr.components(separatedBy: ",")
        let sessionArr = sessionStr.components(separatedBy: ",")
        let durationArr = durationStr.components(separatedBy: ",")

        for i in 0 ..< priceArr.count {
            let locationStruct : StoreLocations = StoreLocations( sessionType: sessionArr[i] , price: priceArr[i], duration: durationArr[i])
            storeLocationArray.append(locationStruct)
            print(storeLocationArray)
        }
    }
}

