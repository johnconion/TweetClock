//
//  TweetRepository.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RealmSwift

class TweetRepository {
    static func save(dic:[[String: Any?]]){
        let realm = try! Realm()
        
        var tweets : [RealmTweet] = []
        
        for tweetDic in dic{
            let tweet = RealmTweet()
            
            tweet.id = tweetDic["id_str"] as! String
            tweet.text = tweetDic["text"] as! String
            tweet.favoriteCount = tweetDic["favorite_count"] as! Int
            tweet.retweetCount = tweetDic["retweet_count"] as! Int
            
            let user = RealmTwitterUser()
            let userDic = tweetDic["user"] as! [String:Any]
            user.iconUrl = userDic["profile_image_url"] as! String
            user.userName = userDic["name"] as! String
            tweet.user = user

            if tweetDic["extended_entities"] != nil{
                let imagesArray = (tweetDic["extended_entities"] as! [String:Any])["media"] as! [[String:Any]]
                for imageData in imagesArray{
                    let image = RealmTwitterImage()
                    image.imageUrl = imageData["media_url"] as! String
                    tweet.images.append(image)
                }
            }
            
            tweets.append(tweet)
        }

        // トランザクションを開始して、オブジェクトをRealmに追加する
        try! realm.write {
            for tweet in tweets{
                realm.add(tweet, update: .all)
            }
        }
    }
}
