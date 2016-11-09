//
//  EventsViewController.swift
//  FitSport
//
//  Created by Manishi on 11/4/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var EventsArray = [[String:AnyObject]]()
    @IBOutlet weak var eventCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "JoinedEventsCollectionViewCell", bundle: nil)
        self.eventCollectionView.register(nib, forCellWithReuseIdentifier: "JoinedEventsCollectionViewCell")
        self.geTheEventsFromServer()
        
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
        if dict["Image_URL"] != nil {
            let url = NSURL(string: dict["Image_URL"] as! String)
            cell?.joinedEventImageView.setImageWith(url as! URL)
        }
        return cell!
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 246)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
