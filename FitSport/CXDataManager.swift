//
//  CXDataManager.swift
//  FitSport
//
//  Created by apple on 17/11/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit
private var _sharedInstance:CXDataManager! = CXDataManager()

class CXDataManager: NSObject {

    class var sharedInstance : CXDataManager {
        return _sharedInstance
    }
    
    fileprivate override init() {
        
    }
    
}

//MARK: Search Functionality 




/*
 CXDataService.sharedInstance.getTheAppDataFromServer(["type":"allProducts","keyWord":self.searchBar.text!,"mallId":CXAppConfig.sharedInstance.getAppMallID()]) { (responseDict) in
 let jobs : NSArray =  responseDict.valueForKey("jobs")! as! NSArray
 self.searchResults = jobs
 self.searchCollectionView.reloadData()
 LoadingView.hide()
 }
 */
