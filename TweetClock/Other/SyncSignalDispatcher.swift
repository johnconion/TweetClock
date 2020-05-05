//
//  SyncSignalDispatcher.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SyncSignalDispatcher {
    // Singleton
    static let shared = SyncSignalDispatcher()
    private init() {}
    
    var loadTimelineInterval : Double = UserDefaultManager.getDouble(key: .LoadTimelineInterval)

    var clockTimer: Observable<Int> {
        Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
            .startWith(0)
            .share(replay: 1)
    }
    
    var tweetTimer: Observable<Int> {
        Observable<Int>.interval(loadTimelineInterval * 60 + 1, scheduler: MainScheduler.instance)
            .startWith(0)
            .share(replay: 1)
    }
    
    var interstitialTimer: Observable<Int> {
        Observable<Int>.interval(900, scheduler: MainScheduler.instance)
            .startWith(0)
            .filter{ _ in UserStatusStore.shared.value.isPurchasedAdRemove.not() } // 広告消去を買っているユーザーはストリームを流さない
            .delay(1, scheduler: MainScheduler.instance)
            .share(replay: 1)
    }
}
