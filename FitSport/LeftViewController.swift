//
//  LeftViewController.swift
//  FitSport_Balu
//
//  Created by apple on 02/11/16.
//  Copyright © 2016 ongo. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var editProfileLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var leftTableView: UITableView!
    var nameArray = ["INTEREST SPORTS","EVENTS","TRAINERS","INVITE/SHARE","HELP","SIGN OUT"]
    var imageArray = ["heart","events","trainer","invite","help","logout"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.layer.cornerRadius = 35
        self.imageView.layer.borderWidth = 1
        self.imageView.clipsToBounds = true
 
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.nameArray.count
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let name = "cellid"
        var cell = tableView.dequeueReusableCell(withIdentifier: name)
        
        if cell == nil
        {
             cell = UITableViewCell.init(style: .default, reuseIdentifier: name)
        }
    
        tableView.backgroundColor = UIColor.black
        cell? .backgroundColor = UIColor.clear
        cell?.textLabel?.text = nameArray[indexPath.row]
        cell?.textLabel?.textColor = UIColor.white
        cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
        tableView.allowsSelection = false
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    

     
  

}
