//
//  Message.swift
//  ParseChat
//
//  Created by Angeline Rao on 6/21/16.
//  Copyright © 2016 Angeline Rao. All rights reserved.
//

import UIKit
import Parse

class Message_fbuJuly2016: NSObject {
    class func newMessage(content: UITextField?, withCompletion completion: PFBooleanResultBlock?) {
        let message = PFObject(className: "Message_fbuJuly2016")
        message["text"] = content?.text
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print(message["text"])
                print("not error")
            }
            else {
                print(error)
                print("error")
            }
        }
    }

}
