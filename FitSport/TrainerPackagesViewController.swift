//
//  TrainerPackagesViewController.swift
//  FitSport
//
//  Created by Manishi on 11/18/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

struct StoreLocations {
    
    var sessionType: String
    var price: String
    var duration: String
    
}

class TrainerPackagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,FloatRatingViewDelegate {
    
    @IBOutlet weak var noContentLbl: UILabel!
    @IBOutlet weak var packageTableView: UITableView!
    var galleryDict:NSDictionary?
    var merchantDict:NSMutableDictionary! = nil
    var storeLocationArray = [StoreLocations]()
    var userProfileData:UserProfile!
    var parentView:PackageViewController! = nil
    var selectedStore:StoreLocations!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parsingAboutUsDetails()
        packageTableView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0)
        let nib = UINib(nibName: "PackageTableViewCell", bundle: nil)
        self.packageTableView.register(nib, forCellReuseIdentifier: "PackageTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if ((galleryDict?.value(forKey: "SessionType")) as! String != ""){
             return storeLocationArray.count
        }else{
            self.noContentLbl.isHidden = false
            self.packageTableView.isHidden = true
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageTableViewCell", for: indexPath)as? PackageTableViewCell
        
        cell?.rateView.contentMode = UIViewContentMode.scaleAspectFit
        cell?.rateView.editable = false
        cell?.rateView.halfRatings = true
        cell?.rateView.floatRatings = false
        
        let storeLocation : StoreLocations =  (self.storeLocationArray[indexPath.row] as? StoreLocations)!
        
        cell?.sessionPriceLbl.text = "₹" + (storeLocation.price)
        cell?.sessionTypeLbl.text = storeLocation.sessionType
        cell?.sessionDurationLbl.text = "Duration: "+(storeLocation.duration)
        
        cell?.bookBtn.addTarget(self, action:#selector(paymentAction(_:)), for:.touchUpInside)
        cell?.bookBtn.tag = indexPath.row+1
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/1-9,height: 90)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storeLocation : StoreLocations =  (self.storeLocationArray[indexPath.row] as? StoreLocations)!

        /*
         var sessionType: String
         var price: String
         var duration: String
         */
    }
    
    //FloatRatingViewDelegates
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float){
        
    }
    
    /**
     Returns the rating value as the user pans
     */
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Float){
        
    }
    
    func parsingAboutUsDetails(){
        
        self.merchantDict = NSMutableDictionary()
        self.merchantDict!.setObject((galleryDict?.value(forKey: "Price"))!, forKey: "Price" as NSCopying)
        self.merchantDict!.setObject((galleryDict?.value(forKey: "SessionType"))!, forKey: "SessionType" as NSCopying)
        self.merchantDict!.setObject((galleryDict?.value(forKey: "Duration"))!, forKey: "Duration" as NSCopying)
        self.packageTableView.reloadData()
        
        let priceStr = (galleryDict?.value(forKey: "Price"))! as! NSString
        let sessionStr = (galleryDict?.value(forKey: "SessionType"))! as! NSString
        let durationStr = (galleryDict?.value(forKey: "Duration"))! as! NSString
        
            
        let priceArr = priceStr.components(separatedBy: ",")
        let sessionArr = sessionStr.components(separatedBy: ",")
        let durationArr = durationStr.components(separatedBy: ",")

        for i in 0 ..< priceArr.count {
            let locationStruct : StoreLocations = StoreLocations( sessionType: sessionArr[i] , price: priceArr[i], duration: durationArr[i])
            storeLocationArray.append(locationStruct)
            print(storeLocationArray)
        }
    }
    
    func showAlertView() {
        
        let alert = UIAlertController(title:"Please Login!!!", message:"Login to continue payment", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Take Me to Login Page", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.applicationNavigationFlow()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive) {
            UIAlertAction in
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
  func paymentAction(_ sender: UIButton) {
    
    
    let userId = CXAppConfig.sharedInstance.getUserID()
    print(userId)
    if userId == "" {
        
        self.showAlertView()
        
    }else{

    let appdata:NSArray = UserProfile.mr_findAll() as NSArray
    if appdata.count != 0{
        userProfileData = appdata.lastObject as! UserProfile
    }
    
    var mobileStr:String = String()
    if userProfileData.phoneNumber == nil{
        mobileStr = ""
    }else{
        mobileStr = userProfileData.phoneNumber!
    }
    
    self.selectedStore =  self.storeLocationArray[sender.tag-1] as StoreLocations
    print(selectedStore)
    
    
    let refreshAlert = UIAlertController(title:"Fitsport", message:"Are you sure want to book \(selectedStore.sessionType)", preferredStyle: .alert)
    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
        
    }))
    
 
    
    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
        
        CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(CXAppConfig.sharedInstance.getPaymentGateWayUrl(), parameters: ["name":self.userProfileData.firstName! as AnyObject,"email":self.userProfileData.emailId! as AnyObject,"amount":self.selectedStore.price as AnyObject,"description":"FitSport Payment" as AnyObject,"phone":mobileStr as AnyObject,"macId":self.userProfileData.macId! as AnyObject,"mallId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (responseDict) in
            
            let payMentCntl : CXPayMentController = CXPayMentController()
            payMentCntl.paymentUrl =  NSURL(string: responseDict.value(forKey: "payment_url")! as! String)
            print(payMentCntl.paymentUrl)
            payMentCntl.paymentDelegate  = self
            self.parentView.navigationController?.pushViewController(payMentCntl, animated: true)
            payMentCntl.completion = {_ in responseDict
                print(responseDict)
              self.showAlertView(message: "You can view your Booking History in side panel", status: 0)
                self.parentView.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }))
    
    self.present(refreshAlert, animated: true, completion: nil)
    
    }
     }
    
    
    func showAlertView(message:String,status:Int) {
        
        let alert = UIAlertController(title:"Payment Successfully Completed!!!", message:message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}


extension TrainerPackagesViewController : paymentDelegate {
    
    
    
    func pamentSuccessFully(resultDiuct:NSDictionary){
        self.sendTheBookingHistoryDetailsToServer(paymentDic: resultDiuct)
    }
    
    func sendTheBookingHistoryDetailsToServer(paymentDic:NSDictionary){
        print(paymentDic)
        
        let userProfileData:UserProfile = CXAppConfig.sharedInstance.getTheUserDetails()
        print(galleryDict)
        let historyDic : NSMutableDictionary = NSMutableDictionary()
        
        historyDic.setObject(paymentDic.value(forKey: "id")!, forKey: "paymentId" as NSCopying)
        historyDic.setObject(userProfileData.emailId!, forKey: "consumerEmail" as NSCopying)
        historyDic.setObject(self.selectedStore.sessionType, forKey: "Event_Name" as NSCopying)
        historyDic.setObject("Session", forKey: "Event_Type" as NSCopying)
        historyDic.setObject(galleryDict!.value(forKey: "address")!, forKey: "Address" as NSCopying)
        historyDic.setObject(self.selectedStore.duration, forKey: "Event_timings" as NSCopying)
        historyDic.setObject(paymentDic.value(forKey: "amount")!, forKey: "amount" as NSCopying)
        historyDic.setObject(CXAppConfig.sharedInstance.getAppMallID(), forKey: "mallId" as NSCopying)
        
        CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(CXAppConfig.sharedInstance.getBaseUrl() + CXAppConfig.sharedInstance.getcreateBookingHistoryByPIdUrl(), parameters: (historyDic as NSDictionary) as? [String : AnyObject]) { (responseDict) in
            
            print(responseDict)
        }
        /*
         http://apps.storeongo.com:8081/MobileAPIs/createBookingHistoryByPId?paymentId=6bbf30d7ad694995b635bf459ab9278f&consumerEmail=chaitu.yeddla@gmail.com&Event_Name=Movie1&Event_Type=Entertainments&Event_Image_URL=&No_of_Units=3&Address=HYD&Event_timings=5pm-9pm&amount=670&mallId=4
         */
        
        
        
    }
    
}
