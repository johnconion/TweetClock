//
//  SwifterWrapper.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import Foundation
import Swifter
import PKHUD

@objc class SwifterWrapper: NSObject {
    
    @objc static let share: SwifterWrapper = SwifterWrapper()
    private var twitter: Swifter?
    private var callbackUrl: URL?
    private let twitterAccountStore = TwitterAccountStore.shared
    
    private override init() {
    }

    // MARK: - キーとシークレットの設定
    
    @objc func setup(consumerKey: String, consumerSecret: String) {
        callbackUrl = URL(string: "swifter-" + consumerKey + "://")
        twitter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
    }
    
    // MARK: - スキーマのコールバックハンドリング
    
    @objc class func handleOpen(url: URL) {
        Swifter.handleOpenURL(url)
    }
    
    // MARK: - 連携
    
    @objc func login(controller: UIViewController, success: @escaping (_ userID: String, _ screenName: String, _ token: String, _ tokenSecret: String) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        
        guard let callbackUrl = self.callbackUrl else {
            failure(nil)
            return
        }
        
        twitter?.authorize(withCallback: callbackUrl, presentingFrom: controller, success: { (accessToken, _) in
            
            guard let key = accessToken?.key else {
                failure(nil)
                return
            }

            guard let secret = accessToken?.secret else {
                failure(nil)
                return
            }
            
            guard let userID = accessToken?.userID else {
                failure(nil)
                return
            }
            
            guard let screenName = accessToken?.screenName else {
                failure(nil)
                return
            }
            success(userID, screenName, key, secret)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    // MARK: - つぶやき投稿
    
    func inviteTweet(status: String) {
        guard let oAuthToken = twitterAccountStore.value.key else { return }
        guard let secret = twitterAccountStore.value.secret else { return }
        let Sw_Token = Credential.OAuthAccessToken(key: oAuthToken, secret: secret)
        let Sw_credential = Credential(accessToken: Sw_Token)
        twitter?.client.credential = Sw_credential
        twitter?.postTweet(status: status)
    }
    
    func getTimeline(){
        guard let oAuthToken = twitterAccountStore.value.key else { return }
        guard let secret = twitterAccountStore.value.secret else { return }
        let Sw_Token = Credential.OAuthAccessToken(key: oAuthToken, secret: secret)
        let Sw_credential = Credential(accessToken: Sw_Token)
        twitter?.client.credential = Sw_credential
        twitter?.getHomeTimeline(count: 50, success: { json in
//            print(json)
            // 最後にAPIアクセスした時刻を更新
            LoadTimeLineLastTime.update()
            let json = json.description
            let data = json.data(using: .utf8)!
            do {
                let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                TweetRepository.save(dic: dic)
            } catch {
                print(error.localizedDescription)
            }
        }, failure: { error in
            print(error)
            print(error.localizedDescription)
            HUD.flash(.labeledError(title: "Twitter API error", subtitle: "時間を空けるか、再度連携し直してください"), delay: 2)
        })
    }
}
