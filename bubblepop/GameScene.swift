//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017年 Yuki Nagae. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    private let bubble = Bubble()
    
    override func didMove(to view: SKView) {

        self.backgroundColor = SKColor.white
        self.bubble.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(self.bubble)
    }
}
