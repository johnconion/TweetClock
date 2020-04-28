//
//  LoadTimeLineUseCase.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/27.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class LoadTimeLineUseCase {
    
    private let twitter = SwifterWrapper.share
    private let twitterAccountStore = TwitterAccountStore.shared
    
    func execute() {
        if LoadTimeLineLastTime.inTerm().not() && twitterAccountStore.value.isLogined() {
            twitter.getTimeline()
        }
    }
}
