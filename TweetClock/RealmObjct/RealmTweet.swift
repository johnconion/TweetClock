//
//  RealmTweetItem.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RealmSwift

class RealmTweet: Object {
    @objc dynamic var id = ""
    @objc dynamic var date = Date()
    @objc dynamic var text = ""
    @objc dynamic var favoriteCount = 0
    @objc dynamic var retweetCount = 0
    @objc dynamic var user : RealmTwitterUser?
    let images = List<RealmTwitterImage>()
    
    override static func primaryKey() -> String? {
      return "id"
    }
}
