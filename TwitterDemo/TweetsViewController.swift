//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/29/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewSelector : String = ""
    
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.04, green: 0.6, blue: 0.98, alpha: 0.9)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        /*
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(gestureRecognizer)
         */       
 
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
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
    
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
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
        cell.delegate = self
        
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


    /*func onTap(tapGestureRecognizer: UITapGestureRecognizer) {
        print("got the tap gesture from home!")
        performSegue(withIdentifier: "onHomeToProfileSegue", sender: tapGestureRecognizer)
    } */
    
    func tweetCellDidTriggerProfileView(user: User) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        profileViewController.profileUser = user
        self.navigationController?.pushViewController(profileViewController, animated: true)
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

        } else if let cell = sender as? UIBarButtonItem {
            print("Not a UITableViewCell segue")
            //let cell = sender as! UIBarButtonItem
            
            let user = User.currentUser
            
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.user = user
        } else {
            print("Segue to profile page")
            
            
        }
        
        
    }


}
