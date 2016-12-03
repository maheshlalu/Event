//
//  BookingHistoryViewController.swift
//  FitSport
//
//  Created by Manishi on 11/28/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class BookingHistoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var bookingHistoryCollectionView: UICollectionView!
    var bookingHistoryDict:NSDictionary!
    var bookingHistoryArr = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "BookingHistoryCollectionViewCell", bundle: nil)
        self.bookingHistoryCollectionView.register(nib, forCellWithReuseIdentifier: "BookingHistoryCollectionViewCell")
        self.bookingHistoryCollectionView.backgroundColor = UIColor.clear
        self.view.backgroundColor = CXAppConfig.sharedInstance.getAppTheamColor()
        self.bookingHistoryCollectionView.contentSize = CGSize(width: 320, height: 235)
        // Do any additional setup after loading the view.
        
        setUpSideMenu()
        bookingHistoryCall()

    }

    // Header for BookingHistoryView From SideMenu
    func setUpSideMenu(){
        
        let menuItem = UIBarButtonItem(image: UIImage(named: "sidePanelMenu-1"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.navigationItem.leftBarButtonItem = menuItem
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.title = "Booking History"
    }
    
    // CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return bookingHistoryArr.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingHistoryCollectionViewCell", for: indexPath)as? BookingHistoryCollectionViewCell
        
        var dict = bookingHistoryArr[indexPath.item]
        
        print(dict)
        
        if dict["Event_Type"] as! String == "Session"{
            cell?.ticketsStakeView.isHidden = true
            cell?.orderHistoryImageView.isHidden = true
            
        }else{
            cell?.ticketsStakeView.isHidden = false
            cell?.orderHistoryImageView.isHidden = false
            if (dict["Event_Image_URL"] as! String) != "" {
                let url = NSURL(string: dict["Event_Image_URL"] as! String)
                cell?.orderHistoryImageView.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
            }
        }
        cell?.orderDate.text = dict["createdOn"] as? String

        cell?.orderNameLbl.text = dict["Event_Name"] as? String
        cell?.orderDateLbl.text = dict["createdAt"] as? String
        cell?.orderPlaceLbl.text = dict["Address"] as? String
        cell?.ticketsCountLbl.text = dict["No_of_Units"] as? String
        
        let price: Float = Float((dict["amount"] as? String)!)!
        cell?.orderTotalAmountLbl.text = "₹ "+String(format: price == floor(price) ? "%.0f" : "%.1f", price)
        
        return cell!
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 235)
        
    }
    
    //Booking History Api Call
    //type=PaymentOrderDetails&consumerId=46&mallId=4
    func bookingHistoryCall(){
        CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(CXAppConfig.sharedInstance.getBaseUrl()+CXAppConfig.sharedInstance.getMasterUrl(), parameters: ["type":"PaymentOrderDetails" as AnyObject,"consumerId":CXAppConfig.sharedInstance.getMacJobID() as AnyObject,"mallId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (responseDict) in
            let arr = responseDict["jobs"] as! [[String:AnyObject]]
            for gallaeryData in arr {
                let picDic : NSDictionary =  gallaeryData as NSDictionary
                print( picDic.value(forKey: "status"))
                if (picDic.value(forKey: "status")! as! String == "Completed") && (picDic.value(forKey: "Event_Name")! as! String != ""){
                    self.bookingHistoryArr.append(picDic as! [String : AnyObject])
                }
            }
            self.bookingHistoryCollectionView.reloadData()
        }
    }
    
}

