//
//  TableViewController.swift
//  FitSportProject
//
//  Created by Rama kuppa on 27/10/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class SelectTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var cateGoryData = NSMutableDictionary()
    var keysArr = [AnyObject]()
    var indexArray = NSMutableArray()
    var dataArray = NSMutableArray()
    let mainDict = NSMutableDictionary()

    @IBOutlet weak var selectSportsLabel: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var notTrainerBtn: UIButton!
    @IBOutlet weak var enterSportLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SelectSportTableViewCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "SelectSportTableViewCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.getTheProductCategory()
    }
    
    
    func getTheProductCategory(){
        //let URLString = "http://storeongo.com:8081/Services/getMasters?type=P3rdLevelCategories&mallId=20221"
        CXDataService.sharedInstance.getTheAppDataFromServer(["type":"P3rdLevelCategories" as AnyObject,"mallId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (dict) in
            let jobsArr : NSArray = (dict.object(forKey: "jobs") as? NSArray)!
            let subCatArray = NSMutableArray()
            for  tempDict in jobsArr{
                let dataDict : NSDictionary = tempDict as! NSDictionary
                let name = dataDict.object(forKey: "SubCategory") as! String
                subCatArray.add(name)
            }
            let setValue : NSSet = NSSet(array: subCatArray as [AnyObject])
            let arr = setValue.allObjects as! [String]
            
            for  str in arr{
                let  catNamesArray = NSMutableArray()
                for  tempDict in jobsArr{
                    let dataDict : NSDictionary = tempDict as! NSDictionary
                    
                    let name = dataDict.object(forKey: "SubCategory") as! String
                    if str == name {
                        catNamesArray.add(dataDict.object(forKey: "Name") as! String)
                    }
                }
                let name =  str.components(separatedBy: "(").first
                self.cateGoryData.setObject(catNamesArray, forKey: name as! NSCopying)
            }
            self.keysArr = NSArray(array: self.cateGoryData.allKeys) as [AnyObject]
            self.tableview.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keysArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let keyValue = keysArr[section]
        let dicArry : NSArray = cateGoryData.value(forKey: keyValue as! String) as! NSArray
        return dicArry.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return keysArr[section] as! String
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectSportTableViewCell", for: indexPath) as?SelectSportTableViewCell
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        let keyValue = keysArr[indexPath.section]
        let dicArry : NSArray = cateGoryData.value(forKey: keyValue as! String) as! NSArray
        print(dicArry)
        
        cell?.nameLabel.text = dicArry[indexPath.row] as? String
        cell?.nameLabel.font = CXAppConfig.sharedInstance.appMediumFont()
        cell?.checkBtn.addTarget(self, action:#selector(checkButtonClicked(sender:)), for: .touchUpInside)
        if indexArray .contains(indexPath) {
            cell?.checkBtn.isSelected = true
        }
        else {
            cell?.checkBtn.isSelected = false
        }
        return cell!
        
    }
    
    func checkButtonClicked(sender:UIButton!) {
        //  print("Button Clicked")
        let btn : UIButton = sender
        let view = sender.superview!
        let cell = view.superview as! SelectSportTableViewCell
        let indexPath = self.tableview.indexPath(for: cell)
        if btn.isSelected {
            indexArray.remove(indexPath as Any)
            //   indexArray
        }
        else {
            indexArray.add(indexPath as Any)
            dataArray.add(cell.nameLabel?.text as Any)
        }
       // btn.isSelected = !btn.isSelected

        self.tableview.reloadRows(at: [indexPath!], with: .middle)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 50
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let v = view as! UITableViewHeaderFooterView
        v.textLabel?.textColor = UIColor.black
        v.textLabel?.font = CXAppConfig.sharedInstance.appLargeFont()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 18
    }
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    //    {
    //        let headerview = UIView()
    //        headerview.backgroundColor = UIColor.clear
    //        headerview
    //        //return headerview
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

/*
 
 //        cateGoryData  = NSDictionary(objects:
 //            [["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"],["Kriya","Aruna","Sudharshana"],["Salsa","Zumba"],["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"],["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"]],
 //
 //                                     forKeys: ["SPORTS" as NSCopying,"YOGA" as NSCopying,"DANCE" as NSCopying,"DATA" as NSCopying,"TEXT" as NSCopying,])
 //
 //        keysArr = NSArray(array: cateGoryData.allKeys) as [AnyObject]

 */
