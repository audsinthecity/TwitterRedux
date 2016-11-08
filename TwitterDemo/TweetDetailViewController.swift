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
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet!
    var profileUser: User!
    
    
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
        
        favoriteButton.setImage(#imageLiteral(resourceName: "like-action"), for:.normal);
        favoriteButton.setImage(#imageLiteral(resourceName: "like-action-on"), for:.highlighted);
        
        retweetButton.setImage(#imageLiteral(resourceName: "retweet-action"), for:.normal);
        retweetButton.setImage(#imageLiteral(resourceName: "retweet-action-on"), for: .highlighted)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(gestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onReplyButton(_ sender: AnyObject) {
        print("Replied!")
        dismiss(animated: true, completion: nil)
    }
    

    
    
    @IBAction func onRetweet(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.retweet(tweet: tweet, success: {
            print("Retweeted!")
            sender.setImage(#imageLiteral(resourceName: "retweet-action-on"), for: UIControlState.highlighted)
            self.tweet.retweetCount += 1
            self.retweetCountLabel.text = String(self.tweet.retweetCount)
            }, failure: {
                print("Retweet fail")
        })

    }
    
    
    @IBAction func onLike(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favorite(tweet: tweet, success: {
            print("Favorited!")
            sender.setImage(#imageLiteral(resourceName: "like-action-on"),for: UIControlState.highlighted)
            self.tweet.favoritesCount += 1
            self.favoriteCountLabel.text = String(self.tweet.favoritesCount)
            }, failure: {
                print("Favorite fail")
        })
    }
    
    
    @IBAction func onProfileTapGesture(_ sender: AnyObject) {
        print("tap gesture working")
    }
    
    /*@IBAction func onProfileTapGesture(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        print("tap gesture working")
        
        let imageView = tapGestureRecognizer.view as! UIImageView
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        //tap.delegate = self
        imageView.addGestureRecognizer(tap)
    } */
    
    func onTap(tapGestureRecognizer: UITapGestureRecognizer) {
        print("got the tap gesture!")
        performSegue(withIdentifier: "profileSegue", sender: tapGestureRecognizer)
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITapGestureRecognizer {
            let cell = sender as! UITapGestureRecognizer
            
            //var dictionary: [Any:Any]
            
            //init(dictionary: NSDictionary) {
            
            var dictionary = [
                //self.dictionary = dictionary
                
                "name" : tweet.username as? NSString,
                "screenname" : tweet.userhandle as? NSString,
                
                /*
                let profileUrlString = tweet.urlString as? String
                if let profileUrlString = profileUrlString {
                    profileUrl = URL(string: profileUrlString) as NSURL?
                }
                
                let profileBackgroundString = tweet.backgroundUrlString as? String
                if let profileBackgroundString = profileBackgroundString {
                    profileBackgroundUrl = URL(string: profileBackgroundString) as NSURL?
                }
                 */
                
                //tagline = dictionary["description"] as? NSString
                
                "numberFollowing" : tweet.friendsCount,
                "numberFollowers" : tweet.followersCount,
                "numberTweets" : tweet.numberTweets
            ] as [String : Any]
            //}
            
            let tweetUser = User.init(dictionary: dictionary as NSDictionary)
            
            //let profileUser = tweet.user
            
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.profileUser = tweetUser
            
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            
        } else {
            print("Not a UITableViewCell segue")
            //let cell = sender as! UIBarButtonItem
            
            let user = User.currentUser
            
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.user = user
        }
    }


}
