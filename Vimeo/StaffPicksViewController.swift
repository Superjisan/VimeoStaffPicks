//
//  StaffPicksViewController.swift
//  Vimeo
//
//  Created by Jisan Zaman on 7/8/15.
//  Copyright (c) 2015 Jisan Zaman. All rights reserved.
//

import UIKit

class StaffPicksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    
    
    let items = ["Jisan", "Geri", "Kate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Staff Picks"
        self.setupTableView()
        self.refreshItems()
    }
    
    //MARK: Setup
    func setupTableView(){
        
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: NSStringFromClass(VideoCell.self))
        
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(VideoCell.self)) as! VideoCell
        
        cell.nameLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func refreshItems(){
        VimeoClient.staffpicks { (videos, error) -> Void in
            println("error: \(error) \n videos: \(videos)")
        }
    }

}
