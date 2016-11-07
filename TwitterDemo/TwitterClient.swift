//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/29/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "xDbCXCHD0GaC1ZsFDa26yj2Ea", consumerSecret: "4V2jbGICckxg0YJrBQ6NHhjN9pH4EP1ZlUwdblhMNEipfTvuS4")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oath") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print(requestToken?.token)
            
            let urlString = "https://api.twitter.com/oauth/authenticate?oauth_token=\(requestToken!.token!)"
            print("hey: " + urlString)
            let url = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=\(requestToken!.token!)")
            print(url)
            UIApplication.shared.open(url! as URL)
            
            }, failure: { (error: Error?) in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error!)
        })

    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user //call to setter to save user
                self.loginSuccess?()
                }, failure: { (error: Error) -> () in
                    self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
            }, failure: { (error: Error?) -> Void in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error!)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
        })

    }
    
    func mentionsTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (test: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
        })
    }
    
    func userTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/user_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
        })
    }
    
    func createTweet(status: String, reply: Tweet?, success: @escaping (Tweet)->(), failure: @escaping ()->()){
        
        self.post("1.1/statuses/update.json", parameters: ["status":status,"in_reply_to_status_id":reply?.id], progress: nil, success: { (task:URLSessionDataTask, response: Any?) in
            let data = response as! NSDictionary
            success(Tweet(dictionary: data))
        }) { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            failure()
        }
    }
    
    func favorite(tweet: Tweet, success: @escaping ()->(), failure: @escaping ()->()) {
        self.post("1.1/favorites/create.json", parameters: ["id":tweet.id], progress: nil, success: { (task:URLSessionDataTask, response: Any?) in
            success()
        }) { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            failure()
        }
    }
    
    func retweet(tweet: Tweet, success: @escaping ()->(), failure: @escaping ()->()) {
        self.post("1.1/statuses/retweet/\(tweet.id).json", parameters: [:], progress: nil, success: { (task:URLSessionDataTask, response: Any?) in
            success()
        }) { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            failure()
        }
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }

}


