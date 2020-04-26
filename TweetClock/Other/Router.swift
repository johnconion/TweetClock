//
//  Router.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class Router {
    
    static func presentMainView() -> UIViewController{
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "main_view")
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
    static func presentSettingsView() -> UIViewController{
        let vc = UIStoryboard(name: "Settings", bundle: Bundle.main).instantiateViewController(withIdentifier: "settings_view")
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
    static func presentColorSettingView(type:ColorSettingType) -> UIViewController{
        let vc = UIStoryboard(name: "ColorSetting", bundle: Bundle.main).instantiateViewController(withIdentifier: "color_setting") as! ColorSettingViewController
        vc.type = type
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
    static func openTweet(vc:UIViewController,id:String){
        let urlStr = "twitter://status?id=\(id)"
        let url = URL(string: (urlStr).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("インストールされていなかったらSafariで開く")
        }
    }
}
