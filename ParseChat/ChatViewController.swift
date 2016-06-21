//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Angeline Rao on 6/21/16.
//  Copyright © 2016 Angeline Rao. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messages: [PFObject]? {
        didSet {
            print("SEt messages")
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        NSTimer.scheduledTimerWithTimeInterval(5, target:  self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        let query = PFQuery(className:"Message_fbuJuly2016")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:NSError?) in
            if error != nil{
                print(error)
            } else {
                print("Successfully retrieved \(objects!.count) messages.")
                self.messages = objects
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func onCompose(sender: AnyObject) {
        Message_fbuJuly2016.newMessage(chatField) { (success: Bool, error: NSError?) in
            if error != nil {
                print("success")
            }
            else {
                print(error)
                print("onCompose")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func onTimer() {
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("MessageTableViewCell", forIndexPath: indexPath) as! MessageTableViewCell
        let message = messages![indexPath.row]
        
        cell.messageCellLabel.text = message["text"] as? String
        let user = message["user"] as? PFUser
        cell.usernameLabel.text = user?.username
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }

}
