//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/31/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.04, green: 0.6, blue: 0.98, alpha: 0.9)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        nameLabel.text = tweet.username
        messageLabel.text = tweet.text
        usernameLabel.text = tweet.userhandle
        retweetLabel.text = "audsinthecity retweeted"
        profileView.setImageWith(URL(string:tweet.urlString! as String)!)
        favoriteCountLabel.text = String(tweet.favoritesCount)
        retweetCountLabel.text = String(tweet.retweetCount)
        timeLabel.text = tweet.displayTimeSinceCreated
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onReplyButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
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
