//
//  TrainerCertificationViewController.swift
//  FitSport
//
//  Created by Manishi on 11/18/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import SDWebImage

class TrainerCertificationViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var noContentLbl: UICollectionView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    var images = [SKPhoto]()
    var gallaryItems:NSMutableArray = []
    var galleryDict:NSDictionary?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        let nib = UINib(nibName: "PhotosCollectionViewCell", bundle: nil)
        self.photosCollectionView.register(nib, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        self.photosCollectionView.contentSize = CGSize(width: 780, height: 900)
        self.photosCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0)
        
        self.photosCollectionView.backgroundColor = UIColor.white
        let arr = galleryDict?.value(forKey: "Attachments") as! NSArray
        for gallaeryData in arr {
            
            let picDic : NSDictionary =  gallaeryData as! NSDictionary
            let pic = picDic.value(forKey: "URL")!
            gallaryItems.add(pic)
  
        }
        if gallaryItems.count == 0{
            
            self.noContentLbl.isHidden = false
            self.photosCollectionView.isHidden = true
        }
        print(gallaryItems.description)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return self.gallaryItems.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath as IndexPath)as! PhotosCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        cell.layer.masksToBounds = true
        let url = NSURL(string: gallaryItems[indexPath.item] as! String)
        cell.photosImage.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
        
        let photo = SKPhoto.photoWithImageURL(gallaryItems[indexPath.item] as! String)
        photo.shouldCachePhotoURLImage = false // you can use image cache by true(NSCache)
        images.append(photo)
   
   
        return cell
    }
    
     private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width,height: 205)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(indexPath.row)
        present(browser, animated: true, completion: {})
        
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
}

