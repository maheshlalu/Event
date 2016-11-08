//
//  TableViewController.swift
//  FitSportProject
//
//  Created by Rama kuppa on 27/10/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class SelectTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var cateGoryData = NSDictionary()
    var keysArr = [AnyObject]()
    var indexArray = NSMutableArray()
    var dataArray = NSMutableArray()
    
    @IBOutlet weak var selectSportsLabel: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var notTrainerBtn: UIButton!
    @IBOutlet weak var enterSportLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var nameArray = ["Cricket","Volley Ball","Tennis","Hockey","Badminton","Basket Ball"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SelectSportTableViewCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "SelectSportTableViewCell")
        self.automaticallyAdjustsScrollViewInsets = false
        
        cateGoryData  = NSDictionary(objects:
            [["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"],["Kriya","Aruna","Sudharshana"],["Salsa","Zumba"],["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"],["Hockey","Cricket","Badminton","Tennis","Shuttle","Swimming","Basketball","Volleyball","Kabaddi","Archery"]],
                                     
                                     forKeys: ["SPORTS" as NSCopying,"YOGA" as NSCopying,"DANCE" as NSCopying,"DATA" as NSCopying,"TEXT" as NSCopying,])
        
        keysArr = NSArray(array: cateGoryData.allKeys) as [AnyObject]
        print(keysArr)
        
        
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
        //        print("Button Clicked")
        let btn : UIButton = sender
        print(btn.isSelected)
        //        btn.isSelected = !btn.isSelected
        
        
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
        
        self.tableview.reloadData()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 50
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let v = view as! UITableViewHeaderFooterView
        v.textLabel?.textColor = UIColor.black
        v.textLabel?.font = UIFont(name: "Roboto", size: 14)
        
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
