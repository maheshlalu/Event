//
//  CreateEventViewController.swift
//  FitSport
//
//  Created by Manishi on 11/5/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        scrollView.isDirectionalLockEnabled = true
        scrollView.delegate = self
//        CGRect frameRect = textField.frame;
//        frameRect.size.height = 53;
//        textField.frame = frameRect;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x<0 || scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    @IBAction func submitAction(_ sender: UIBarButtonItem) {
        
    }

}
