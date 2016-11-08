
//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/30/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func tweetCellDidTriggerProfileView(user: User)
}

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    weak var delegate: TweetCellDelegate?
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.username as String?
            messageLabel.text = tweet.text as String?
            userLabel.text = tweet.userhandle as String?
            retweetLabel.text = "audsinthecity retweeted"
            profileView.setImageWith(URL(string:tweet.urlString! as String)!)
            favoriteCountLabel.text = String(tweet.favoritesCount)
            retweetCountLabel.text = String(tweet.retweetCount)
            timeLabel.text = tweet.displayTimeSinceCreated
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        profileView.addGestureRecognizer(gestureRecognizer)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onTap() {
        delegate?.tweetCellDidTriggerProfileView(user: tweet.tweetUser)
        
    }
    
    
}



