//
//  CXDataService.swift
//  NowFloats
//
//  Created by Mahesh Y on 8/24/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire

private var _SingletonSharedInstance:CXDataService! = CXDataService()

open class CXDataService: NSObject {

    class var sharedInstance : CXDataService {
        return _SingletonSharedInstance
    }
    
    fileprivate override init() {
        
    }
    
    func destory () {
        _SingletonSharedInstance = nil
    }
    
    open func getTheAppDataFromServer(_ parameters:[String: AnyObject]? = nil ,completion:@escaping (_ responseDict:NSDictionary) -> Void){
        if Bool(1) {
            print(CXAppConfig.sharedInstance.getBaseUrl() + CXAppConfig.sharedInstance.getMasterUrl())
            print(parameters)
            
           // Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)

            // Alamofire.request("https://httpbin.org/post", parameters: parameters, encoding: URLEncoding.httpBody)
            Alamofire.request(CXAppConfig.sharedInstance.getBaseUrl() + CXAppConfig.sharedInstance.getMasterUrl(), method: .post, parameters: parameters, encoding: URLEncoding.`default`)
                .responseJSON { response in
                    //to get status code
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 201:
                            print("example success")
                        default:
                            print("error with response status: \(status)")
                        }
                    }
                    //to get JSON return value
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        //completion((response.result.value as? NSDictionary)!)
                        completion(JSON)
                    }
            }
            
            
            // Alamofire.request("",method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: [:])
        }
    }
    
    open func synchDataToServerAndServerToMoblile(_ urlstring:String, parameters:[String: AnyObject]? = nil ,completion:@escaping (_ responseDict:NSDictionary) -> Void){
    
        print(urlstring)
        print(parameters)
        
        
        Alamofire.request(urlstring, method: .post, parameters: parameters, encoding: URLEncoding.`default`)
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    completion((response.result.value as? NSDictionary)!)
                    print(JSON)
                }
                
        }
        
//        Alamofire.request(.POST,urlstring, parameters: parameters)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                   // print("Validation Successful\(response.result.value)")
//                    completion(responseDict: (response.result.value as? NSDictionary)!)
//                    break
//                case .failure(let error):
//                    print(error)
//                }
//        }

        
    }
    

 
    
    open func getTheUpdatesFromServer(_ parameters:[String: AnyObject]? = nil ,completion:@escaping (_ responseDict:NSDictionary) -> Void){
        
       /* https://api.withfloats.com/Discover/v2/floatingPoint/bizFloats?clientId=5FAE0707506C43BAB8B8C9F554586895577B22880B834423A473E797607EFCF6&skipBy=0&fpid=kljadlkcjasd898979
         
         clientId=5FAE0707506C43BAB8B8C9F554586895577B22880B834423A473E797607EFCF6&skipBy=0&fpid=kljadlkcjasd898979
        */
        //print(parameters)
        
        
        Alamofire.request("https://api.withfloats.com/Discover/v2/floatingPoint/bizFloats?", method: .post, parameters: parameters, encoding: URLEncoding.`default`)
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    completion((response.result.value as? NSDictionary)!)
                    print(JSON)
                }
                
        }

//
//        Alamofire.request(.GET,"https://api.withfloats.com/Discover/v2/floatingPoint/bizFloats?", parameters: parameters)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    //print("Validation Successful\(response.result.value)")
//                    completion(responseDict: (response.result.value as? NSDictionary)!)
//                    break
//                case .failure(let error):
//                    print(error)
//                }
//        }
        
        
    }

    func generateBoundaryString() -> String
    {
        return "\(UUID().uuidString)"
    }
  /*  open func imageUpload(_ imageData:Data,completion:@escaping (_ Response:NSDictionary) -> Void){
        
        let mutableRequest : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
        let request1 : NSMutableURLRequest =    mutableRequest.multipartFormRequest(withMethod: "POST", urlString: CXAppConfig.sharedInstance.getBaseUrl()+CXAppConfig.sharedInstance.getphotoUploadUrl(), parameters: ["refFileName": self.generateBoundaryString()], constructingBodyWith: { (formatData:AFMultipartFormData) in
            formatData.appendPart(withFileData: imageData, name: "srcFile", fileName: "uploadedFile.jpg", mimeType: "image/jpeg")
            }, error: nil)
        
        let session = URLSession.shared
        
       // let task = URLSession.shared.dataTask(with: request1 as URLRequest) { data, response, error in }

    
        let task = session.dataTask(with: request1, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8)
            let myDic = self.convertStringToDictionary(dataString! as String)
            completion(Response:myDic)
            
        })
        
        task.resume()
        
        }*/

    
    func convertDictionayToString(_ dictionary:NSDictionary) -> NSString {
        var dataString: String!
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            //print("JSON data is \(jsonData)")
            dataString = String(data: jsonData, encoding: String.Encoding.utf8)
            //print("Converted JSON string is \(dataString)")
            // here "jsonData" is the dictionary encoded in JSON data
        } catch let error as NSError {
            dataString = ""
            print(error)
        }
        return dataString as NSString
    }
    
    func convertStringToDictionary(_ string:String) -> NSDictionary {
        var jsonDict : NSDictionary = NSDictionary()
        let data = string.data(using: String.Encoding.utf8)
        do {
            jsonDict = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers ) as! NSDictionary            // CXDBSettings.sharedInstance.saveAllMallsInDB((jsonData.valueForKey("orgs") as? NSArray)!)
        } catch {
            //print("Error in parsing")
        }
        return jsonDict
    }
    
    
}
