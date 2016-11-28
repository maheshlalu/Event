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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "BookingHistoryCollectionViewCell", bundle: nil)
        self.bookingHistoryCollectionView.register(nib, forCellWithReuseIdentifier: "BookingHistoryCollectionViewCell")
        self.bookingHistoryCollectionView.backgroundColor = UIColor.clear
        self.view.backgroundColor = CXAppConfig.sharedInstance.getAppTheamColor()
        self.bookingHistoryCollectionView.contentSize = CGSize(width: 320, height: 235)
        // Do any additional setup after loading the view.
        
        setUpSideMenu()
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
        
        return 5
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingHistoryCollectionViewCell", for: indexPath)as? BookingHistoryCollectionViewCell
     
        return cell!
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 235)
        
    }
    
    
    
}
