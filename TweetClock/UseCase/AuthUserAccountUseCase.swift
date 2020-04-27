//
//  AuthUserAccountUseCase.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/27.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class AuthUserAccountUseCase: NSObject {
    
    private let twitter = SwifterWrapper.share
    
    func execute(viewController:UIViewController, success: @escaping () -> Void ){
        TweetRepository.deleteAll()
        twitter.login(controller: viewController, success: { userID,screenName,key,secret in
            print("sucess")
            UserDefaultManager.setValue(key: .TwitterKey, value: key)
            UserDefaultManager.setValue(key: .TwitterSecret, value: secret)
            UserDefaultManager.setValue(key: .TwitterUserID, value: userID)
            UserDefaultManager.setValue(key: .TwitterScreenName, value: screenName)
            success()
        }, failure: { error in
            print(error!)
        })
    }
}
