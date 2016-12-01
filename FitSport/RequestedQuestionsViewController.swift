//
//  RequestedQuestionsViewController.swift
//  FitSport
//
//  Created by Manishi on 11/30/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class RequestedQuestionsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var FAQTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "QuestionChatTableViewCell", bundle: nil)
        FAQTableView.register(nib, forCellReuseIdentifier: "QuestionChatTableViewCell")
        
        self.FAQTableView.estimatedRowHeight = 138
        self.FAQTableView.rowHeight = UITableViewAutomaticDimension
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionChatTableViewCell") as! QuestionChatTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
    
}
