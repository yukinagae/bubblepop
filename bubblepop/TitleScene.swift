//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

class TitleScene: SKScene {

    override func didMove(to view: SKView) {

        self.backgroundColor = SKColor.white

        // title
        let titleLabel = SKLabelNode(fontNamed:"Chalkduster")
        titleLabel.text = "Bubble Pop";
        titleLabel.fontSize = 48;
        titleLabel.fontColor = SKColor.black
        titleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2);
        self.addChild(titleLabel)

        // start
        let startLabel = SKLabelNode(fontNamed: "Copperplate")
        startLabel.text = "Start"
        startLabel.fontSize = 36
        startLabel.fontColor = SKColor.black
        startLabel.position = CGPoint(x: self.size.width/2, y: 200)
        startLabel.name = "Start"
        self.addChild(startLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch =  touches.first else {
            return
        }

        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)

        if touchedNode.name == "Start" {
            let newScene = GameScene(size: self.scene!.size)
            newScene.scaleMode = .aspectFill
            self.view?.presentScene(newScene)
        }
    }
}
