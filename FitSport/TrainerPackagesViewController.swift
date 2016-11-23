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
    
}

class TrainerPackagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,FloatRatingViewDelegate {
    
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
        return 3
        
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
        self.packageTableView.reloadData()
        //jobTypeName
        
        if ((galleryDict?.value(forKey: "SessionType") as? [String]) != nil) {
            //Array
            let priceArray : NSArray = (galleryDict?.value(forKey: "Price"))! as! NSArray
            let sessionArray : NSArray = (galleryDict?.value(forKey: "SessionType"))! as! NSArray
            
            for i in 0 ..< priceArray.count {
                let locationStruct : StoreLocations = StoreLocations(sessionType: sessionArray[i] as! String, price: priceArray[i] as! String )
                storeLocationArray.append(locationStruct)
                print(storeLocationArray)
            }

        }else{
            //String
            
            let locationStruct : StoreLocations = StoreLocations(sessionType: galleryDict?.value(forKey: "SessionType") as! String, price: (galleryDict?.value(forKey: "Price"))! as! String)
            storeLocationArray.append(locationStruct)
            
        }

    }

}
