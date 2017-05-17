//
//  Util.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/15.
//  Copyright © 2017年 Yuki Nagae. All rights reserved.
//

import Foundation

// utility class
class Util {


    // get random value
    static func random(max: UInt32) -> UInt32 {
        return arc4random_uniform(max)
    }

    // get random colour
    static func getRandomColor() -> ColorType {
        let r = Util.random(max: 100) // 0...99

        if r < ColorEnum.Red.probability {
            return ColorEnum.Red
        } else if r < ColorEnum.Pink.probability {
            return ColorEnum.Pink
        } else if r < ColorEnum.Green.probability {
            return ColorEnum.Green
        } else if r < ColorEnum.Blue.probability {
            return ColorEnum.Blue
        } else {
            return ColorEnum.Black
        }
    }
}
