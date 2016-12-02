
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
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SelectSportTableViewCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "SelectSportTableViewCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.getTheProductCategory()
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        let navigation:UINavigationItem = navigationItem
        navigation.title  = "Select Sport"
        
        self.tableview.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
    }
    
    
    @IBAction func nxtBtnAction(_ sender: AnyObject) {
        let  stringRepresentation = dataArray.componentsJoined(by: ",") as String
        self.updatingUserDict(dataString: stringRepresentation)
  
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
        return keysArr[section] as? String
        
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
        let  element = dicArry[indexPath.row] as! String
        
        if dataArray.contains(element) {
            cell?.checkBtn.isSelected = true

        }
        else {
            cell?.checkBtn.isSelected = false
        }
        
//        if indexArray .contains(indexPath) {
//            cell?.checkBtn.isSelected = true
//        }
//        else {
//            cell?.checkBtn.isSelected = false
//        }
        return cell!
        
    }
    
    func checkButtonClicked(sender:UIButton!) {
        
        let btn : UIButton = sender
        let view = sender.superview!
        let cell = view.superview as! SelectSportTableViewCell
        let indexPath = self.tableview.indexPath(for: cell)
        if btn.isSelected {
            indexArray.remove(indexPath as Any)
            dataArray.remove(cell.nameLabel.text! as String)
            btn.isSelected = false
        
        }
        else {
            indexArray.add(indexPath as Any)
            dataArray.add((cell.nameLabel?.text)! as String)
            btn.isSelected = true
        }
        self.tableview.reloadRows(at: [indexPath!], with: .none)
        
      
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let v = view as! UITableViewHeaderFooterView
        v.textLabel?.textColor = CXAppConfig.sharedInstance.getAppTheamColor()
        v.textLabel?.font = UIFont(name: "Roboto-Bold", size: 20)
        v.textLabel?.textAlignment = .center
        
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
    
    func updatingUserDict(dataString:String) {
        
        let userDict = CXAppConfig.sharedInstance.getUserUpdateDict()
        
        let jsonDic : NSMutableDictionary = NSMutableDictionary(dictionary: CXAppConfig.sharedInstance.getUserUpdateDict())
        jsonDic.setObject(dataString, forKey: "Interests" as NSCopying)
        jsonDic.setObject(userDict.value(forKey: "Image")!, forKey: "Image" as NSCopying)
        jsonDic.setObject(userDict.value(forKey: "mobileNo")!, forKey: "mobileNo" as NSCopying)

        CXAppConfig.sharedInstance.setUserUpdateDict(dictionary: jsonDic)
       // print(CXAppConfig.sharedInstance.getUserUpdateDict())
        CX_SocialIntegration.sharedInstance.activeTheUser(parameterDic: CXAppConfig.sharedInstance.getUserUpdateDict(), jobId: CXAppConfig.sharedInstance.getMacJobID()) {
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let userProfileData:UserProfile = CXAppConfig.sharedInstance.getTheUserDetails()
            
            CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(CXAppConfig.sharedInstance.getBaseUrl()+CXAppConfig.sharedInstance.getSignInUrl(), parameters: ["orgId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject,"email":userProfileData.emailId! as AnyObject,"dt":"DEVICES" as AnyObject,"isLoginWithFB":"true" as AnyObject]) { (responseDict) in
                //"password":""
                CX_SocialIntegration.sharedInstance.saveUserDeatils(userData: responseDict, completion: { (dic) in
                    
                    CXAppConfig.sharedInstance.loggedUser(userID: CXAppConfig.sharedInstance.getUserID())
                    appDel.setUpSidePanl()
                    
                })
                
            }
        }
        
    }
    
    func updateTheUserDetails(){
        
        
    }
    
    
    /*func activeTheUser(parameterDic:NSDictionary,jobId:String){
        var jsonData : NSData = NSData()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: parameterDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            // here "jsonData" is the dictionary encoded in JSON data
        } catch let error as NSError {
            print(error)
        }
        let jsonStringFormat = String(data: jsonData as Data, encoding: String.Encoding.utf8)
        print(jsonStringFormat)
        
        CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(CXAppConfig.sharedInstance.getBaseUrl()+CXAppConfig.sharedInstance.getUpdatedUserDetails(), parameters: ["jobId":jobId as AnyObject,"jsonString":jsonStringFormat! as AnyObject,"ownerId":CXAppConfig.sharedInstance.getAppMallID() as AnyObject]) { (responseDict) in
            print(responseDict)
        
            
        }
        
        
        
    }*/
//        CX_SocialIntegration.sharedInstance.updateTheSaveConsumerProperty(["ownerId":CXAppConfig.sharedInstance.getAppMallID(),"jobId":jobId,"jsonString":jsonStringFormat!]) { (resPonce) in     0
//            
//            self.navigationController?.popToRootViewControllerAnimated(true)
        
}
        
        //    http://storeongo.com:8081/ MobileAPIs/updateMultipleProperties/ jobId=200400& jsonString={"PaymentType":"249","ValidTill":"11-11-2017","userStatus":"active"}&ownerId=20217

