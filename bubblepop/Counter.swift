//
//  Counter.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/15.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

class Counter {
    private var queue = DispatchQueue(label: "counter.queue.identifier")
    private (set) var value: Int = 0

    func increment() {
        self.queue.sync {
            self.value += 1
        }
    }

    func decrement() {
        self.queue.sync {
            self.value -= 1
        }
    }
}
