//
//  ObjectStore.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ObjectStore{
    associatedtype T
    var value : T { get }
    func update() -> Observable<T>
}
