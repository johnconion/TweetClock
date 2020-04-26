
//
//  RealmManeger.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager {
    // 自動的に遅延初期化される(初回アクセスのタイミングでインスタンス生成)
    static let shared = RealmManager()
    // 外部からのインスタンス生成をコンパイルレベルで禁止
    private init() {
        realm = try! Realm()
    }
    
    let realm : Realm

}
