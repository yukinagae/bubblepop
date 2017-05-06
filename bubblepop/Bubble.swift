//
//  Bubble.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

class Bubble: SKSpriteNode {

    init() {
        let texture = SKTexture(imageNamed: "Bubble")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.isUserInteractionEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch :)")

        let actionWait = SKAction.wait(forDuration: 0.5)
        let actionDone = SKAction.removeFromParent()
        self.run(SKAction.sequence([actionWait, actionDone]))
    }
}
