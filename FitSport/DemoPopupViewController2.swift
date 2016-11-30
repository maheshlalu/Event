//
//  DemoPopupViewController2.swift
//  PopupController
//
//  Created by 佐藤 大輔 on 2/4/16.
//  Copyright © 2016 Daisuke Sato. All rights reserved.
//

import UIKit

class DemoPopupViewController2: UIViewController, PopupContentViewController {
    var closeHandler: (() -> Void)?
    @IBOutlet weak var questionTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.layer.borderColor = CXAppConfig.sharedInstance.getAppTheamColor().cgColor
        questionTextView.layer.cornerRadius = 4
        questionTextView.layer.borderWidth = 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layer.cornerRadius = 4
    }
    
    class func instance() -> DemoPopupViewController2 {
        let storyboard = UIStoryboard(name: "DemoPopupViewController2", bundle: nil)
        return storyboard.instantiateInitialViewController() as! DemoPopupViewController2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSize(width: 300, height: 230)
    }
    
    @IBAction func submitAction(_ sender: AnyObject) {
        closeHandler!()
    }
    
}
