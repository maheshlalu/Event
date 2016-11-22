//
//  TrainerPackagesViewController.swift
//  FitSport
//
//  Created by Manishi on 11/18/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class TrainerPackagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
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
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 90)
        
    }

}
