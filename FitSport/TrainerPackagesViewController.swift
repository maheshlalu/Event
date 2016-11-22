//
//  TrainerPackagesViewController.swift
//  FitSport
//
//  Created by Manishi on 11/18/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class TrainerPackagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,FloatRatingViewDelegate {
    
    @IBOutlet weak var packageTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
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

}
