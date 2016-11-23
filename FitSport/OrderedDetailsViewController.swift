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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imageViewCutomization()
        headerView.layer.cornerRadius = 4
        setUpSideMenu()
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
    
    func backBtnAction(){
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func editDetailsBtnAction(_ sender: AnyObject) {
        
        
    }

}
