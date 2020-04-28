//
//  AuthUserAccountUseCase.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/27.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import PKHUD

class AuthUserAccountUseCase: NSObject {
    
    private let twitter = SwifterWrapper.share
    
    func execute(viewController:UIViewController, success: @escaping () -> Void, error: @escaping () -> Void ){
        twitter.login(controller: viewController, success: { userID,screenName,key,secret in
            print("sucess")
            TweetRepository.deleteAll()
            UserDefaultManager.setValue(key: .TwitterKey, value: key)
            UserDefaultManager.setValue(key: .TwitterSecret, value: secret)
            UserDefaultManager.setValue(key: .TwitterUserID, value: userID)
            UserDefaultManager.setValue(key: .TwitterScreenName, value: screenName)
            self.twitter.getTimeline()
            success()
        }, failure: { e in
            print(e!)
            HUD.flash(.labeledError(title: "Twitter API error", subtitle: "時間を開けるか、再度連携し直してください"), delay: 2)
            error()
        })
    }
}
