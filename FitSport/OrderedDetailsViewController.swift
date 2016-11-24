//
//  OrderedDetailsViewController.swift
//  FitSport
//
//  Created by Manishi on 11/22/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit
import SCLAlertView

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
        getUserDetails()
    }

    func imageViewCutomization(){
        
        orderImgView.layer.cornerRadius = 25
        orderImgView.layer.borderColor = UIColor.white.cgColor
        orderImgView!.layer.masksToBounds = true
        orderImgView!.clipsToBounds = true
        
    }
    
    func getUserDetails()
    {
        let userDict = CXAppConfig.sharedInstance.getUserUpdateDict()
        let userProfileData:UserProfile = CXAppConfig.sharedInstance.getTheUserDetails()
        print(userDict.value(forKey: "mobileNo"))
        userEmailLbl.text = userProfileData.emailId
        userMobileLbl.text = userDict.value(forKey: "mobileNo") as! String?
        
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
        self.payButton.setTitle( "Pay ₹" + (self.totalAmountString!), for: .normal)
 
        
        /*
         [Image_URL, Next_Job_Statuses, PackageName, EventType/Ticket type, ItemCode, Attachments, publicURL, Category_Mall, Cost, Current_Job_StatusId, P3rdCategory, id, Name, jobTypeName, guestUserEmail, FromDate, Current_Job_Status, Additional_Details, jobTypeId, Image_Name, CreatedSubJobs, ToDate, ExternalBooking, Venue, Event Sport, createdById, SubCategoryType, NumberOfPeople, jobComments, Event Date, Per Session, SlotPeriod, guestUserId, Description, lastModifiedDate, Insights, createdByFullName, City, Days, overallRating, createdOn, hrsOfOperation, CategoryType, Provider, Next_Seq_Nos, totalReviews, In_Time]
         [TICKET_TYPE, TICKET_COST, TOTAL_TICKETS]
         */
    }
    
    
    
    func backBtnAction(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func editDetailsBtnAction(_ sender: AnyObject) {
        
        setUpAlertView()
        
    }
    
    func setUpAlertView()
    {
        // Example of using the view to add two text fields to the alert
        // Create the subview
        let color : CGColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "Roboto-Regular", size: 20)!,
            kTextFont: UIFont(name: "Roboto-Regular", size: 14)!,
            kButtonFont: UIFont(name: "Roboto-Bold", size: 14)!,
            showCloseButton: false
            
        )
        
        // Initialize SCLAlertView using custom Appearance
        
        let alert = SCLAlertView(appearance: appearance)
        
        // Creat the subview
        let subview = UIView(frame: CGRect(x:0,y:0,width:216,height:70))
        let x = (subview.frame.width - 180) / 2
        
        // Add textfield 1
        let textfield1 = UITextField(frame: CGRect(x:x,y:10,width:180,height:25))
        textfield1.layer.borderColor = UIColor.green.cgColor
        textfield1.layer.borderWidth = 1
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Email ID"
        textfield1.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield1)
        
        // Add textfield 2
        let textfield2 = UITextField(frame: CGRect(x:x,y:textfield1.frame.maxY + 10,width:180,height:25))
        textfield2.layer.borderColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
        textfield2.layer.borderWidth = 1
        textfield2.layer.cornerRadius = 5
        textfield1.layer.borderColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
        textfield2.placeholder = "Mobile No"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        alert.addButton("Update", target:self, selector:#selector(updateButtonTapped(sender:)))
       
        
        
        alert.showInfo("fitsport", subTitle: "", duration: 0)
    }
    
    func updateButtonTapped(sender:UIButton)
    {
       print("Update tapped")
    }
    
    
    @IBAction func paymentAction(_ sender: AnyObject) {
  
        let userDict = CXAppConfig.sharedInstance.getUserUpdateDict()
        let userProfileData:UserProfile = CXAppConfig.sharedInstance.getTheUserDetails()
       
       
//        let dict  = CXDataService.sharedInstance.convertStringToDictionary(userProfileData.json!)
        
            CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(CXAppConfig.sharedInstance.getPaymentGateWayUrl(), parameters: ["name":userProfileData.firstName! as AnyObject,"email":userProfileData.emailId! as AnyObject,"amount":self.totalAmountString! as AnyObject,"description":"FitSport Payment" as AnyObject,"phone":userDict.value(forKey: "mobileNo")! as AnyObject,"macId":userProfileData.macId! as AnyObject,"mallId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (responseDict) in
                
                let payMentCntl : CXPayMentController = CXPayMentController()
                payMentCntl.paymentUrl =  NSURL(string: responseDict.value(forKey: "payment_url")! as! String)
                print(payMentCntl.paymentUrl)
                self.navigationController?.pushViewController(payMentCntl, animated: true)
            }
        

}
    
    
}
