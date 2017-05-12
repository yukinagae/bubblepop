//
//  Bubble.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

protocol BubbleTouchedDelegate : class {

    func onTouch(color: ColorType) -> Void
    func onRemoved() -> Void
}

class Bubble: SKSpriteNode {

    weak var delegate: BubbleTouchedDelegate?

    let myColor: ColorType

    init(color: ColorType) {
        self.myColor = color
        let texture = SKTexture(imageNamed: color.name)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.isUserInteractionEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func disappear() {
//        let actionFadeOut = SKAction.fadeOut(withDuration: 0.5)
//        let actionDone = SKAction.removeFromParent()
//        self.run(SKAction.sequence([actionFadeOut, actionDone]))
//
//        self.delegate?.onRemoved()
//    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let actionFadeOut = SKAction.fadeOut(withDuration: 0.5)
        let actionDone = SKAction.removeFromParent()
        self.run(SKAction.sequence([actionDone]))

        // delegate
        self.delegate?.onTouch(color: myColor)
    }
}
