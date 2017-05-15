//
//  ColorType.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/07.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

// color type
struct ColorType {
    var skcolor     : SKColor // colour
    var name        : String  // name (should be equal to image name)
    var point       : UInt32  // points
    var probability : UInt32  // %
}

// all the colours you can use in this game
// you can add more colours if you want
enum ColorEnum {
    static let Red   = ColorType(skcolor: SKColor.red,    name: "red",   point: 1,  probability: 40)  // 40% (1...40)
    static let Pink  = ColorType(skcolor: SKColor.purple, name: "pink",  point: 2,  probability: 70)  // 30% (41...70)
    static let Green = ColorType(skcolor: SKColor.green,  name: "green", point: 5,  probability: 85)  // 15% (71...85)
    static let Blue  = ColorType(skcolor: SKColor.blue,   name: "blue",  point: 8,  probability: 95)  // 10% (86...95)
    static let Black = ColorType(skcolor: SKColor.black,  name: "black", point: 10, probability: 100) // 5%  (96...100)
}
