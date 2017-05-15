//
//  Bubble.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

// delegate protocol
// this is used to pass touch event to parent (GameScene)
protocol BubbleTouchedDelegate : class {

    func onTouch(bubble: Bubble) -> Void
}

// Bubble class
class Bubble: SKSpriteNode {

    weak var delegate: BubbleTouchedDelegate?

    let myColor: ColorType
    let skcolor: SKColor
    var touched = false

    init(color: ColorType) {
        self.myColor = color
        self.skcolor = color.skcolor
        let texture = SKTexture(imageNamed: color.name)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.isUserInteractionEnabled = true // user interaction should be enabled
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // when bubble touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.touched = true // touched will be true so that its parent(=GameScene) does not remove this bubble twice

        let actionDone = SKAction.removeFromParent()
        self.run(SKAction.sequence([actionDone]))

        self.delegate?.onTouch(bubble: self) // notify game scene to calculate points
    }
}
