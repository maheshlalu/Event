//
//  EventsViewController.swift
//  Autolayouts_CoupoCon
//
//  Created by Rama kuppa on 21/11/16.
//  Copyright © 2016 Mahesh. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
class EventsDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var KeyArray = NSMutableArray()
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
        self.eventTableView.delegate = self
        
        let nib1 = UINib(nibName: "EventTypeNewTableViewCell", bundle: nil)
        self.eventTableView.register(nib1, forCellReuseIdentifier: "EventTypeNewTableViewCell")
        
        
        eventTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        
        
        let url : URL = URL(string: eventDetailsDict.value(forKey: "Image_URL") as! String)!
        eventImageView.sd_setImage(with: url, placeholderImage: nil)
        eventTitleLabel.text = eventDetailsDict.value(forKey: "Name") as! String?
        
        let strEventType : String = (eventDetailsDict.value(forKey: "EventType/Ticket type") as! String?)!
        if strEventType == "" {
            
        }else{
        let strCost : String = (eventDetailsDict.value(forKey: "Cost") as! String?)!
        let trimmedString = strCost.replacingOccurrences(of: " ", with: "")
        print(trimmedString)
        eventsArray = strEventType.components(separatedBy: ",")
        costArray = trimmedString.components(separatedBy: ",")
        }
        setUpSideMenu()
        // Do any additional setup after loading the view.
    }
    
    func setUpSideMenu(){
        
        let menuItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(PackageViewController.backBtnAction))
        self.navigationItem.leftBarButtonItem = menuItem
        let navigation:UINavigationItem = navigationItem
        let image = UIImage(named: "logo_white")
        
        self.navigationController?.navigationBar.isTranslucent = false
        let back = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItems = [back]
        
        navigation.titleView = UIImageView(image: image)
        
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
        let keyValue = KeyArray[section] as! String
        
        if keyValue == "Event Type/Ticket Type" {
            return eventsArray.count
        }
        else {
            return 1
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        //eventTableView.allowsSelection = false
        //eventTableView.separatorStyle = .none
        eventTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        let keyValue = KeyArray[indexPath.section] as! String
        if keyValue == "Event Type/Ticket Type" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTypeNewTableViewCell", for: indexPath)as? EventTypeNewTableViewCell
            cell?.selectionStyle = .none
            cell?.eventTypeLabel.text = eventsArray[indexPath.row]
            cell?.ticketPriceLbl.text = "(Price per Ticket is: ₹\(costArray[indexPath.row]))"
            cell?.ticketPriceLbl.textColor = UIColor.lightGray
            
            cell?.bookBtn.layer.cornerRadius = 10;
            cell?.bookBtn.layer.backgroundColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
            cell?.bookBtn.layer.borderColor = UIColor.brown.cgColor
            cell?.bookBtn.tag = indexPath.row+1
            cell?.bookBtn.setTitleColor(UIColor.white, for: .normal)
            cell?.bookBtn.addTarget(self, action: #selector(bookAction(_:)), for: .touchUpInside)
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailsTableViewCell", for: indexPath)as? EventDetailsTableViewCell
            cell?.eventTitleLabel.text = keyValue
            cell?.eventTitleLabel.textColor = UIColor.init(red: 247/255, green: 129/255, blue: 52/255, alpha: 10)
            cell?.eventDescriptionLabel.text = cateGoryData.value(forKey: keyValue)as? String
            
            cell?.layer.borderColor = UIColor.clear.cgColor
            return cell!
        }
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let keyValue = KeyArray[section] as! String
        
        if keyValue == "Event Type/Ticket Type" {
            return 5
        }
        else {
            return 5
        }
        
        //
        //        ActionSheetMultipleStringPicker.showPickerWithTitle("Multiple String Picker", rows: [
        //            ["One", "Two", "A lot"],
        //            ], initialSelection: [2], doneBlock: {
        //                picker, values, indexes in
        //
        //                print("values = \(values)")
        //                print("indexes = \(indexes)")
        //                print("picker = \(picker)")
        //                return
        //            }, cancelBlock: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let keyValue = KeyArray[section] as! String
        if keyValue == "Event Type/Ticket Type" {
            //            let headerView = UIView(frame: CGRect(x: 0, y: 20, width: tableView.bounds.size.width, height: 30))
            //            let titleLabel : UILabel = UILabel()
            //            titleLabel.frame = CGRect(x: 5, y: 5, width: 200, height: 20)
            //            titleLabel.text = "Event Type/Ticket Type"
            //            headerView.addSubview(titleLabel)
            //            headerView.backgroundColor = UIColor.white
            //            return headerView
        }
        else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 5))
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        return nil
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     ActionSheetMultipleStringPicker.show(withTitle: "Select Tickets", rows: [
     [1, 2, 3,4,5],
     ], initialSelection: [1], doneBlock: {
     picker, values, indexes in
     
     
     
     let ticketType = self.eventsArray[indexPath.row]
     let ticketCost = self.costArray[indexPath.row]
     let totalTickets = values?.last
     
     print(indexes)
     print(totalTickets)
     
     let a:Int? = totalTickets as! Int?
     let b:Int? = Int(ticketCost)
     print(b! * a!)
     //print(totalTickets * ticketCost)
     let orderDetials : OrderedDetailsViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderedDetailsViewController") as? OrderedDetailsViewController)!
     orderDetials.eventDetailsDic = self.eventDetailsDict
     let bookingDetilasDic : NSMutableDictionary = NSMutableDictionary()
     bookingDetilasDic.setObject(ticketType, forKey: "TICKET_TYPE" as NSCopying)
     bookingDetilasDic.setObject(b! * a!, forKey: "TICKET_COST" as NSCopying)
     bookingDetilasDic.setObject(totalTickets!, forKey: "TOTAL_TICKETS" as NSCopying)
     orderDetials.ticketTypeDetials = bookingDetilasDic
     self.navigationController?.pushViewController(orderDetials, animated: true)
     return
     }, cancel: { ActionMultipleStringCancelBlock in return }, origin: tableView)
     }*/
    
    
    func bookAction(_ sender : UIButton)
    {
        
        let userId = CXAppConfig.sharedInstance.getUserID()
        print(userId)
        if userId == "" {
            
            self.showAlertView(status: 1)
            
        }else{
            
            ActionSheetMultipleStringPicker.show(withTitle: "Select Tickets", rows: [
                ["1", "2", "3","4","5"],
                ], initialSelection: [0], doneBlock: {
                    picker, values, indexes in
                    
                    let ticketType = self.eventsArray[sender.tag-1]
                    let ticketCost = self.costArray[sender.tag-1]
                    var totalTickets = values?.last
                    
                    let a:Int? = (totalTickets as! Int?)! + 1
                    let b:Int? = Int(ticketCost)
                    totalTickets = a
                    let totalPrice = b! * a!
                    let orderDetials : OrderedDetailsViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderedDetailsViewController") as? OrderedDetailsViewController)!
                    orderDetials.totalAmountString = String(b! * a!)
                    orderDetials.totalTicketsString = String(describing: totalTickets!)
                    orderDetials.ticketType = ticketType
                    
                    orderDetials.eventDetailsDic = self.eventDetailsDict
                    let bookingDetilasDic : NSMutableDictionary = NSMutableDictionary()
                    bookingDetilasDic.setObject(ticketType, forKey: "TICKET_TYPE" as NSCopying)
                    bookingDetilasDic.setObject(totalPrice, forKey: "TICKET_COST" as NSCopying)
                    bookingDetilasDic.setObject(totalTickets!, forKey: "TOTAL_TICKETS" as NSCopying)
                    orderDetials.ticketTypeDetials = bookingDetilasDic
                    self.navigationController?.pushViewController(orderDetials, animated: true)
                    return
                }, cancel: { ActionMultipleStringCancelBlock in return }, origin: eventTableView)
        }
    }
    
    func showAlertView(status:Int) {
        let alert = UIAlertController(title:"Please Login!!!", message:"Login to make payment", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            if status == 1 {
                let appDel = UIApplication.shared.delegate as! AppDelegate
                appDel.applicationNavigationFlow()
            }else{
                
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
