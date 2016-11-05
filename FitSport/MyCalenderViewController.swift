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

    @IBOutlet weak var myCalenderView: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        myCalenderView.firstWeekday = 2;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}

extension MyCalenderViewController : FSCalendarDataSource,FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, hasEventFor date: Date) -> Bool {
        
        return true
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date) -> Bool{ 
        
        return true
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        
        print(date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date){
        print(date)
        
    }
}
