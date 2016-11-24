//
//  CXPayMentController.swift
//  Coupocon
//
//  Created by apple on 07/11/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class CXPayMentController: UIViewController {
    typealias CompletionBlock = (_ responceDic:NSDictionary) -> Void

    var paymentUrl : NSURL! = nil
    var webRequestArry: NSMutableArray = NSMutableArray()
     var payMentWebView: UIWebView!
      var activity: UIActivityIndicatorView = UIActivityIndicatorView()
    var completion: CompletionBlock = { reason in print(reason) }

    override func viewDidLoad() {
        super.viewDidLoad()
        CXDataService.sharedInstance.showLoader(message: "Processing...")
        self.designWebView()
        let requestObj = NSURLRequest(url: paymentUrl as URL)
        self.payMentWebView.loadRequest(requestObj as URLRequest)
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "Payment Gateway "
        self.activity = UIActivityIndicatorView()
        self.activity.tintColor = CXAppConfig.sharedInstance.getAppTheamColor()
        // Do any additional setup after loading the view.
    }

    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func designWebView(){
        self.payMentWebView = UIWebView()
        self.payMentWebView.frame = CGRect(x: 0, y: 0, width: CXAppConfig.sharedInstance.mainScreenSize().width, height: CXAppConfig.sharedInstance.mainScreenSize().height)
        self.view.addSubview(self.payMentWebView)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CXPayMentController : UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        self.webRequestArry.add(String(describing: request.url!))
        print(request)
        return true
    }
    func webViewDidStartLoad(_ webView: UIWebView){
        CXDataService.sharedInstance.showLoader(message: "Processing...")
        activity.isHidden = false
        activity.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        //print(self.webRequestArry.lastObject)
        CXDataService.sharedInstance.hideLoader()
        let lastRequest : String = String(describing: self.webRequestArry.lastObject!)
        print(lastRequest)
        if ((lastRequest.range(of:"paymentorderresponse")) != nil)  {
            CXDataService.sharedInstance.showLoader(message: "Processing...")
            CXDataService.sharedInstance.synchDataToServerAndServerToMoblile(lastRequest, completion: { (responseDict) in
               // print(responseDict)
                let status : String = (responseDict.value(forKey: "status") as? String)!
                if status == "Completed" {
                    self.completion(responseDict)
                }else{
                    
                }
                //LoadingView.hide()
                CXDataService.sharedInstance.hideLoader()
            })
        }
        activity.isHidden = true
        activity.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        activity.isHidden = true
        activity.stopAnimating()
    }
    
}
