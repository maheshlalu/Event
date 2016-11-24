//
//  EventsViewController.swift
//  FitSport
//
//  Created by Manishi on 11/4/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var parentView:TestViewController! = nil

    var EventsArray = [[String:AnyObject]]()
    @IBOutlet weak var eventCollectionView: UICollectionView!

    @IBOutlet weak var eventSearch: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        let nib = UINib(nibName: "JoinedEventsCollectionViewCell", bundle: nil)
        self.eventCollectionView.register(nib, forCellWithReuseIdentifier: "JoinedEventsCollectionViewCell")
        self.geTheEventsFromServer()
        self.eventCollectionView.contentSize = CGSize(width: 780, height: 900)
        self.eventCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0)
    }
    
    
    func geTheEventsFromServer(){
        CXDataService.sharedInstance.getTheAppDataFromServer(["type":"Events" as AnyObject,"mallId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (dict) in
            self.EventsArray = dict["jobs"] as! [[String:AnyObject]]
            self.eventCollectionView.reloadData()
        }
        
    }
    

    //MARK:
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return self.EventsArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JoinedEventsCollectionViewCell", for: indexPath)as? JoinedEventsCollectionViewCell
        let dict = EventsArray[indexPath.item]
        cell?.eventTaskLbl.text = dict["Name"] as? String
        cell?.joinedEventDescriptionLabel.text = dict["Description"]as? String
        cell?.locationLbl.text = dict["City"]as? String //City
        cell?.eventDateLbl.text =  dict["Event Date"]as? String //Event Date
        if dict["Image_URL"] != nil {
            let url = NSURL(string: dict["Image_URL"] as! String)
            cell?.joinedEventImageView.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)

        }
        return cell!
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 246)
        
    }
    
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let dict = EventsArray[indexPath.item]
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let eventDetails = storyBoard.instantiateViewController(withIdentifier: "EventsDetailViewController") as! EventsDetailViewController
    eventDetails.eventDetailsDict = dict as NSDictionary!
//    self.navigationController?.pushViewController(eventDetails, animated: true)
    let nav : UINavigationController = UINavigationController(rootViewController: eventDetails)
    self.parentView.present(nav, animated:true, completion: nil)

    func searchshou(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
}
