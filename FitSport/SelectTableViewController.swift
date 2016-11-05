//
//  TableViewController.swift
//  FitSportProject
//
//  Created by Rama kuppa on 27/10/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit
import Alamofire
class SelectTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var dataArr:NSArray! = nil
    var sectinArry : NSArray = NSArray()
    var nameArray : NSMutableArray =  NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        let navigation:UINavigationItem = navigationItem
        navigation.title  = "Select Sport"
        
        //http://storeongo.com:8081/Services/getMasters?type=P3rdLevelCategories&mallId=20221
        
        //AHTagTableViewCell
        let nibForAHTag = UINib(nibName: "AHTagTableViewCell", bundle: nil)
        self.tableview.register(nibForAHTag, forCellReuseIdentifier: "cell")
        
        self.getTheCategoriesFromServer()
        
        //dataArr = self.papulateTheData() as NSArray
        //print(self.constructTheAhTagsArray())
    }
    
    //MARK: Get The data From Server
    
    func getTheCategoriesFromServer(){
        
        
        let parameters: Parameters = ["type": "P3rdLevelCategories","mallId":CXAppConfig.sharedInstance.getAppMallID()]
        
        CXDataService.sharedInstance.getTheAppDataFromServer(parameters as [String : AnyObject]?) { (dataDic) in
            let categories:NSArray   =  NSMutableArray(array: (dataDic.value(forKey: "jobs") as? NSArray!)!)
            let groupNames:NSMutableArray = NSMutableArray()
            let filteredGroups:NSMutableArray = NSMutableArray()
            for jobDict in categories {
                groupNames.add((jobDict as! NSDictionary).value(forKey: "SubCategory"))
            }
            let orderSet : NSOrderedSet = NSOrderedSet(array: groupNames as [AnyObject])
            filteredGroups.addObjects(from: orderSet.array)
            groupNames.removeAllObjects()
            print(groupNames)
        }
        
        
        
    }
    
    
    func filterTheCategory(){
        
        
    }
    
    
    
    private var dataSource = { () -> [Array<AHTag>] in
        return [
            pinterest,
            genre,
            device,
            app]
    }()
    
    
    func constructTheAhTagsArray () {
        
        let cateGoryData : NSDictionary = NSDictionary(objects: [["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"],["Kriya","Aruna","Sudharshana"],["Salsa","Zumba"],["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"],["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"]], forKeys: ["SPORTS" as NSCopying,"YOGA" as NSCopying,"DANCE" as NSCopying,"DATA" as NSCopying,"TEXT" as NSCopying,])
        var groupArray = [Array<AHTag>]()
        for catDictKey in cateGoryData.allKeys {
            var newArray = [AHTag]()
            for innerData in cateGoryData.value(forKey: catDictKey as! String) as! NSArray{
                newArray.append(AHTag(category: catDictKey as! String, title: innerData as! String, color:CXAppConfig.sharedInstance.getAppTheamColor(), URL: nil, enabled: false))
            }
            groupArray.append(newArray)
        }
        self.dataSource = groupArray
        
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    private func configureCell(_ object: AnyObject, atIndexPath indexPath: IndexPath) {
        if object.isKind(of: AHTagTableViewCell.classForCoder()) == false {
            abort()
        }
        let cell = object as! AHTagTableViewCell
        let tags = self.dataSource[indexPath.section]
        cell.label.setTags(tags)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return   self.dataSource[section][0].category
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let v = view as! UITableViewHeaderFooterView
        v.textLabel?.textColor = UIColor.darkGray
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


