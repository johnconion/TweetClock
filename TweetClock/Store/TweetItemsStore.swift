//
//  TweetItemsStore.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm

class TweetItemsStore {
    // Singleton
    static let shared = TweetItemsStore()
    private init() {_ = updates().subscribe(){ _ in }.dispose()}
    
    private var tweets:[Tweet] = []
    
    var realm: Realm { get{ RealmManager.shared.realm } }
    
    private func sharedUpdates() -> Observable<Array<Tweet>> {
        Observable
            .changeset(from: realm.objects(RealmTweet.self))
            .do(onNext:{self.tweets = self.creatTweetArray(data: $0.0)})
            .map{_ in self.tweets}
    }
    
    func getRecords() -> [Tweet] { tweets }
    
    func get(index: Int) -> Tweet { tweets[index] }
    
    func size() -> Int { tweets.count }
    
    func updates() -> Observable<Array<Tweet>> { sharedUpdates() }
}

private extension TweetItemsStore{
    func creatTweetArray(data:AnyRealmCollection<RealmTweet>)->[Tweet]{
        return data.map{ d in
            Tweet(id: d.id, text: d.text, favoriteCount: d.favoriteCount, retweetCount: d.retweetCount, user: TwitterUser(iconUrl: URL(string: d.user!.iconUrl)!, userName: d.user!.userName), images: d.images.map{TwitterImage(imageUrl: URL(string: $0.imageUrl)!)})
        }
    }
}

