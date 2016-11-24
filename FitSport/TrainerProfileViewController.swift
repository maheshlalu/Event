//
//  TrainerProfileViewController.swift
//  FitSport
//
//  Created by Manishi on 11/18/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class TrainerProfileViewController: UIViewController,UITableViewDataSource,UITabBarDelegate {
    
    @IBOutlet weak var noContentLbl: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var keysArr = ["Description","Address"]
    var galleryDict:NSDictionary?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "ProfileTableViewCell")
        
        if ((galleryDict?.value(forKey: "Description")as! String) != "") && ((galleryDict?.value(forKey: "address")as! String) != ""){
                self.noContentLbl.isHidden = false
                self.tableview.isHidden = true
        }

        //        self.automaticallyAdjustsScrollViewInsets = false
        //        self.tableview.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keysArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return keysArr[section]
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
             let cell = tableview.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath as IndexPath)as! ProfileTableViewCell
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        if indexPath.section == 0{
            if ((galleryDict?.value(forKey: "Description")) as! String != ""){
                cell.cellLbl.text = galleryDict?.value(forKey: "Description") as! String?
            }else{
                cell.cellLbl.text = "No Content Available"
            }
           
            
        }else{
            
            if ((galleryDict?.value(forKey: "address")) as! String != ""){
                cell.cellLbl.text = galleryDict?.value(forKey: "address") as! String?
            }else{
                cell.cellLbl.text = "No Content Available"
            }
            
        
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let v = view as! UITableViewHeaderFooterView
        v.textLabel?.textColor = CXAppConfig.sharedInstance.getAppTheamColor()
        v.textLabel?.font = UIFont(name: "Roboto-Bold", size: 20)
        v.textLabel?.textAlignment = NSTextAlignment.center
        
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 20
    }
    
    
}
