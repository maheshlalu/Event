//
//  EventsViewController.swift
//  Autolayouts_CoupoCon
//
//  Created by Rama kuppa on 21/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit

class EventsDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var KeyArray = NSArray()
    var cateGoryData = NSDictionary()
    var eventDetailsDict:NSDictionary!
    var eventsArray : [String] = NSArray() as! [String]
    var costArray : [String] = NSArray() as! [String]
    
    //var nameArray = ["name","address","age"]

    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cateGoryData = NSDictionary(objects: ["Cricket Tournament",eventDetailsDict.value(forKey: "Event Date"),"",eventDetailsDict.value(forKey: "Description"),eventDetailsDict.value(forKey: "Venue")], forKeys: ["Event" as NSCopying,"Date" as NSCopying,"Event Type/Ticket Type"as NSCopying,"Description" as NSCopying,"Venue" as NSCopying])
        
        KeyArray = ["Event","Date","Event Type/Ticket Type","Description","Venue"]
        
        eventTableView.estimatedRowHeight = 63
        eventTableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "EventDetailsTableViewCell", bundle: nil)
        self.eventTableView.register(nib, forCellReuseIdentifier: "EventDetailsTableViewCell")
        
        let nib1 = UINib(nibName: "EventTypeTableViewCell", bundle: nil)
        self.eventTableView.register(nib1, forCellReuseIdentifier: "EventTypeTableViewCell")
        
        
        eventTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "fitsport"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Roboto-Bold", size: 20)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        let back = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItems = [back]
        
        let url : URL = URL(string: eventDetailsDict.value(forKey: "Image_URL") as! String)!
        eventImageView.sd_setImage(with: url, placeholderImage: nil)
        eventTitleLabel.text = eventDetailsDict.value(forKey: "Name") as! String?
        
        let strEventType : String = (eventDetailsDict.value(forKey: "Name") as! String?)!
        let strCost : String = (eventDetailsDict.value(forKey: "Name") as! String?)!
        
        eventsArray = strEventType.components(separatedBy: ",")
        costArray = strCost.components(separatedBy: ",")
        

        // Do any additional setup after loading the view.
    }
    
    func backTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
     func numberOfSections(in tableView: UITableView) -> Int
     {
        
        return KeyArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 2 {
            return eventsArray.count
        }
        else {
           return 1
        }
   
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        eventTableView.allowsSelection = false
        eventTableView.separatorStyle = .none
        
        eventTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        let keyValue = KeyArray[indexPath.section] as! String
        
        if keyValue == "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTypeTableViewCell", for: indexPath)as? EventTypeTableViewCell
            
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailsTableViewCell", for: indexPath)as? EventDetailsTableViewCell
            
            
            cell?.eventTitleLabel.text = keyValue as? String
            cell?.eventTitleLabel.textColor = UIColor.init(red: 247/255, green: 129/255, blue: 52/255, alpha: 10)
            cell?.eventDescriptionLabel.text = cateGoryData.value(forKey: (keyValue as? String)!)as? String
            
            //        cell?.contentView.layer.cornerRadius = 10
            //        cell?.contentView.layer.borderWidth = 1
            //        cell?.clipsToBounds = true
            
            cell?.layer.cornerRadius = 10
            cell?.layer.borderWidth = 1
            cell?.clipsToBounds = true
            cell?.layer.borderColor = UIColor.clear.cgColor
            return cell!
        }
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 5))
        
            headerView.backgroundColor = UIColor.clear
      
        return headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
