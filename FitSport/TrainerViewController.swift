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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.automaticallyAdjustsScrollViewInsets = false
        let nib = UINib(nibName: "TrainerCollectionViewCell", bundle: nil)
        self.EventCollectionView.register(nib, forCellWithReuseIdentifier: "TrainerCollectionViewCell")
        
        setUpSideMenu()
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainerCollectionViewCell", for: indexPath)as? TrainerCollectionViewCell
        cell?.layer.cornerRadius = 4
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
    
}

