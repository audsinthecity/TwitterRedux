//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 11/2/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var userHeaderView: UIView!
    @IBOutlet weak var userStatsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var numberTweetsLabel: UILabel!
    @IBOutlet weak var numberFollowingLabel: UILabel!
    @IBOutlet weak var numberFollowersLabel: UILabel!
    
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = User.currentUser?.name as String?
        userNameLabel.text = User.currentUser?.screenname as String?
        profileView.setImageWith(User.currentUser?.profileUrl as! URL)
        numberTweetsLabel.text = String(describing: User.currentUser!.numberTweets)
        numberFollowersLabel.text = String(describing: User.currentUser?.numberFollowers)
        numberFollowingLabel.text = String(describing: User.currentUser?.numberFollowing)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.04, green: 0.6, blue: 0.98, alpha: 0.9)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        TwitterClient.sharedInstance?.userTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets {
                print(tweet.text)
            }
            self.tableView.reloadData()
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets?.count != nil {
            return tweets.count
        } else { return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets {
                print(tweet.text)
                print("Refreshing")
            }
            self.tableView.reloadData()
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
        })
        
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell {
            let cell = sender as! UITableViewCell
            
            // Use a light blue color when the user selects the cell
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.init(red: 0.04, green: 0.6, blue: 0.98, alpha: 0.1)
            cell.selectedBackgroundView = backgroundView
            
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            let detailViewController = segue.destination as! TweetDetailViewController
            detailViewController.tweet = tweet
            
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


    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
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
