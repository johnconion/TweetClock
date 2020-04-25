//
//  BackGroundColorStore.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BackgroundColorStore: ObjectStore {
    
    // Singleton
    static let shared = BackgroundColorStore()
    private init() {}
    
    typealias T = Color
    
    var value: Color = Color()
    
    func update() -> Observable<Color> {
        Observable.combineLatest(
            UserDefaults.standard.rx
                .observe(Float.self, UserDefaultKey.BackgroundRedColor.rawValue),
            UserDefaults.standard.rx
            .observe(Float.self, UserDefaultKey.BackgroundGreenColor.rawValue),
            UserDefaults.standard.rx
            .observe(Float.self, UserDefaultKey.BackgroundBlueColor.rawValue)
        )
            .filter { $0.0 != nil && $0.1 != nil && $0.2 != nil }
            .map{ Color(r: $0.0!, g: $0.1!, b: $0.2!) }
            .do(onNext: {self.value = $0 })
    }
}
