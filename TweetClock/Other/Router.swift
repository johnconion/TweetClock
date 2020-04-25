//
//  Router.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class Router {
    static func presentSettingsView() -> UIViewController{
        return UIStoryboard(name: "Settings", bundle: Bundle.main).instantiateViewController(withIdentifier: "settings_view")
    }
}
