//
//  UserStatusStore.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/05/04.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserStatusStore: ObjectStore {
    
    // Singleton
    static let shared = UserStatusStore()
    private init() {}
    
    typealias T = UserStatus
    
    var value: UserStatus = UserStatus(isPurchasedAdRemove: UserDefaults().bool(forKey: PurchaseManager.Purcheses.adRemove.rawValue))
    
    func update() -> Observable<UserStatus> {
        UserDefaults.standard.rx
            .observe(Bool.self, PurchaseManager.Purcheses.adRemove.rawValue)
            .distinctUntilChanged()
            .map{_ in PurchaseManager.shared.checkPurchased(purchase: .adRemove)}
            .map{ UserStatus(isPurchasedAdRemove: $0!) }
            .do(onNext: { self.value = $0 })
    }
}
