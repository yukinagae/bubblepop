//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene {

    override func didMove(to view: SKView) {

        self.backgroundColor = SKColor.white

        // title
        let titleLabel = SKLabelNode(fontNamed:"Chalkduster")
        titleLabel.text = "Result";
        titleLabel.fontSize = 48;
        titleLabel.fontColor = SKColor.black
        titleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2);
        self.addChild(titleLabel)

        // re-start
        let startLabel = SKLabelNode(fontNamed: "Copperplate")
        startLabel.text = "ReStart"
        startLabel.fontSize = 36
        startLabel.fontColor = SKColor.black
        startLabel.position = CGPoint(x: self.size.width/2, y: 200)
        startLabel.name = "ReStart"
        self.addChild(startLabel)

        // score
        let scoreLabel = SKLabelNode(fontNamed: "Copperplate")
        scoreLabel.text = score.description
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.size.width/2, y: 300)
        scoreLabel.name = "Score"
        self.addChild(scoreLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch =  touches.first else {
            return
        }

        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)

        if touchedNode.name == "ReStart" {

            // TODO
            score = 0

            let newScene = GameScene(size: self.scene!.size)
            newScene.scaleMode = .aspectFill
            self.view?.presentScene(newScene)
        }
    }
}
