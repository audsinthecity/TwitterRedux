//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/29/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var urlString: String?
    var user: [String : AnyObject]
    var username: String?
    var userhandle: String?
    
    init(dictionary: NSDictionary) {
        user = dictionary["user"] as! [String : AnyObject]
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        username = user["name"] as? String
        userhandle = user["screen_name"] as? String
        urlString = user["profile_image_url_https"] as! String
        print("urlString \(urlString)")
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as Date?
        }
    }
    
    // Display time lapsed since Tweet creation
    var displayTimeSinceCreated: String {
        if let timestamp = self.timestamp {
            let dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfYear,.day,.hour,.minute,.second]
            dateComponentsFormatter.maximumUnitCount = 1
            dateComponentsFormatter.unitsStyle = .abbreviated
            return dateComponentsFormatter.string(from: timestamp, to: Date()) ?? ""
        }
        return ""
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
        
    }

}
