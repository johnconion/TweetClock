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
    
    func execute() {
        twitter.getTimeline()
    }
}
