//
//  ColorType.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/07.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

struct ColorType {
    var name       : String // name (should be equal to image name)
    var point      : Int    // points
    var probability: Int    // %
}

enum ColorEnum {
    static let Red   = ColorType(name: "red",   point: 1,  probability: 40)
    static let Pink  = ColorType(name: "pink",  point: 2,  probability: 30)
    static let Green = ColorType(name: "green", point: 5,  probability: 15)
    static let Blue  = ColorType(name: "blue",  point: 8,  probability: 10)
    static let Black = ColorType(name: "black", point: 10, probability: 5)
}
