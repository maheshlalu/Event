//
//  PackageViewController.swift
//  FitSportProject
//
//  Created by Rama kuppa on 10/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class PackageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var packageShareBtn: UIButton!
    @IBOutlet weak var packageFollowingBtn: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var packageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        packageTableView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0)
        
        self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width/2
        
        self.userImageView.layer.borderWidth = 1
        self.userImageView.clipsToBounds = true
        
        self.packageFollowingBtn.layer.cornerRadius = 5
        self.packageFollowingBtn.layer.borderWidth = 1
        self.packageFollowingBtn.clipsToBounds = true
        self.packageFollowingBtn.layer.borderColor = UIColor.white.cgColor
        
        let nib = UINib(nibName: "PackageTableViewCell", bundle: nil)
        self.packageTableView.register(nib, forCellReuseIdentifier: "PackageTableViewCell")

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageTableViewCell", for: indexPath)as? PackageTableViewCell
        return cell!
        
        
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
     {
        
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 90)
        
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
