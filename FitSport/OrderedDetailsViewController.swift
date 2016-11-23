//
//  OrderedDetailsViewController.swift
//  FitSport
//
//  Created by Manishi on 11/22/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class OrderedDetailsViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var orderImgView: UIImageView!
    @IBOutlet weak var orderTitleLbl: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderPlace: UILabel!
    @IBOutlet weak var eachItemCost: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var totalTickets: UILabel!
    
    @IBOutlet weak var subtotalLbl: UILabel!
    @IBOutlet weak var internetHandlingLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userMobileLbl: UILabel!
    
    @IBOutlet weak var payButton: UIButton!
    var eventDetailsDic : NSDictionary! = nil
    var ticketTypeDetials : NSDictionary! = nil
    var totalTicketsString : String! = nil
    var totalAmountString : String! = nil


    override func viewDidLoad() {
        
        super.viewDidLoad()
        imageViewCutomization()
        headerView.layer.cornerRadius = 4
        setUpSideMenu()
        self.populteTheBookingDetails()
    }

    func imageViewCutomization(){
        
        orderImgView.layer.cornerRadius = 25
        orderImgView.layer.borderColor = UIColor.white.cgColor
        orderImgView!.layer.masksToBounds = true
        orderImgView!.clipsToBounds = true
        
    }
    
    func setUpSideMenu(){
        
        let menuItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(PackageViewController.backBtnAction))
        self.navigationItem.leftBarButtonItem = menuItem
        let navigation:UINavigationItem = navigationItem
        let image = UIImage(named: "logo_white")
        navigation.titleView = UIImageView(image: image)
        
    }
    
    func populteTheBookingDetails(){
        
        print(eventDetailsDic.allKeys)
        print(ticketTypeDetials.allKeys)
        
        if eventDetailsDic["Image_URL"] != nil {
            let url = NSURL(string: eventDetailsDic["Image_URL"] as! String)
            self.orderImgView.setImageWith(url as URL!, usingActivityIndicatorStyle: .gray)
        }
        
        self.orderTitleLbl.text = eventDetailsDic["Name"] as? String
        self.orderDate.text = eventDetailsDic["Event Date"] as? String
        self.orderPlace.text = eventDetailsDic["City"] as? String
        self.orderTitleLbl.text = eventDetailsDic["Name"] as? String
        
        self.totalTickets.text = self.totalTicketsString
        self.totalAmount.text = "₹" + (self.totalAmountString!)
        self.subtotalLbl.text = "₹" + (self.totalAmountString!)
        self.payButton.setTitle( "Pay₹" + (self.totalAmountString!), for: .normal)
 
        
        /*
         [Image_URL, Next_Job_Statuses, PackageName, EventType/Ticket type, ItemCode, Attachments, publicURL, Category_Mall, Cost, Current_Job_StatusId, P3rdCategory, id, Name, jobTypeName, guestUserEmail, FromDate, Current_Job_Status, Additional_Details, jobTypeId, Image_Name, CreatedSubJobs, ToDate, ExternalBooking, Venue, Event Sport, createdById, SubCategoryType, NumberOfPeople, jobComments, Event Date, Per Session, SlotPeriod, guestUserId, Description, lastModifiedDate, Insights, createdByFullName, City, Days, overallRating, createdOn, hrsOfOperation, CategoryType, Provider, Next_Seq_Nos, totalReviews, In_Time]
         [TICKET_TYPE, TICKET_COST, TOTAL_TICKETS]
         */
    }
    
    
    
    func backBtnAction(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func editDetailsBtnAction(_ sender: AnyObject) {
        
        
    }
    @IBAction func paymentAction(_ sender: AnyObject) {
        let userId = CXAppConfig.sharedInstance.getUserID()
        print(userId)
        if userId == "" {

            self.showAlertView(status: 1)
            
        }else{
            let userProfileData:UserProfile = CXAppConfig.sharedInstance.getTheUserDetails()

            CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(CXAppConfig.sharedInstance.getPaymentGateWayUrl(), parameters: ["name":"mahesh" as AnyObject,"email":"" as AnyObject,"amount":self.totalAmountString as AnyObject,"description":"FitSport Payment" as AnyObject,"phone":"" as AnyObject,"macId":userProfileData.macId as AnyObject,"mallId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (responseDict) in
                
                let payMentCntl : CXPayMentController = CXPayMentController()
                payMentCntl.paymentUrl =  NSURL(string: responseDict.value(forKey: "payment_url")! as! String)
                print(payMentCntl.paymentUrl)
                self.navigationController?.pushViewController(payMentCntl, animated: true)
            }
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
}
