//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/30/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = User.currentUser?.name as String?
            messageLabel.text = tweet.description
            userLabel.text = User.currentUser?.screenname as String?
            retweetLabel.text = String(tweet.retweetCount)
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
