//
//  Color.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class Color{
    private var redColor : Float = 0
    private var greenColor : Float = 0
    private var blueColor : Float = 0
    
    init() {}
    
    init(r:Float,g:Float,b:Float) {
        redColor = r
        greenColor = g
        blueColor = b
    }
    
    func getRedValue() -> CGFloat { CGFloat(redColor) }
    func setRedValue(r:Float) -> Color {
        redColor = r
        return self
    }
    
    func getGreenValue() -> CGFloat { CGFloat(greenColor) }
    func setGreenValue(g:Float) -> Color {
        greenColor = g
        return self
    }
    
    func getBlueValue() -> CGFloat { CGFloat(blueColor) }
    func setBlueValue(b:Float) -> Color {
        blueColor = b
        return self
    }
}
