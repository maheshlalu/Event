//
//  MyCalenderViewController.swift
//  FitSport
//
//  Created by Manishi on 11/4/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit
import FSCalendar

class MyCalenderViewController: UIViewController {
    
     var actionButton: ActionButton!
    @IBOutlet weak var myCalenderView: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        myCalenderView.firstWeekday = 2;
        myCalenderView.tintColor = CXAppConfig.sharedInstance.getAppTheamColor()
        myCalenderView.delegate = self
        setupFab()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupFab() {

        actionButton = ActionButton(attachedToView: self.view, items:nil)
        actionButton.action = {button in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    
    }
}
    
extension MyCalenderViewController : FSCalendarDataSource,FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, hasEventFor date: Date) -> Bool {
        
        return true
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date) -> Bool{ 
        
        return true
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        
//        print(date)
        let today = Calendar.current.date(byAdding: .day, value: 1, to: date)
        print(today)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date){
        print(date)
        
    }
}
