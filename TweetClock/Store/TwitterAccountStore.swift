//
//  TwitterAccountStatusStore.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TwitterAccountStore: ObjectStore {
    
    // Singleton
    static let shared = TwitterAccountStore()
    private init() { _ = update().subscribe(){_ in}.dispose() }
    
    typealias T = TwitterAccount
    
    var value = TwitterAccount()
    
    func update() -> Observable<TwitterAccount> {
        Observable.zip(
            UserDefaults.standard.rx
                .observe(String.self, UserDefaultKey.TwitterKey.rawValue),
            UserDefaults.standard.rx
                .observe(String.self, UserDefaultKey.TwitterSecret.rawValue),
            UserDefaults.standard.rx
                .observe(String.self, UserDefaultKey.TwitterUserID.rawValue),
            UserDefaults.standard.rx
                .observe(String.self, UserDefaultKey.TwitterScreenName.rawValue)
        )
            .filter { $0.notNil() && $1.notNil() && $2.notNil() && $3.notNil() }
            .map{ TwitterAccount(key: $0.0!, secret: $0.1!, userID: $0.2!, screenName: $0.3!) }
            .do(onNext: {self.value = $0 })
    }
}
