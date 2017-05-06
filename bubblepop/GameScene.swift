//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

var score = 0

class GameScene: SKScene {

    var counter = 10

    let counterLabel = SKLabelNode(fontNamed:"Chalkduster")

    override func didMove(to view: SKView) {

        // count down timer
        timerLabel.text = score.description
        timerLabel.fontSize = 48;
        timerLabel.fontColor = SKColor.black
        timerLabel.position = CGPoint(x: self.size.width/2, y: 30);
        self.addChild(timerLabel)

        self.backgroundColor = SKColor.white

        let widthBlock = self.size.width/4
        let heightBlock = self.size.height/8

        for i in 1..<4 {
            for j in 1..<6 {
                let bubble = Bubble()
                bubble.position = CGPoint(x: CGFloat(i) * widthBlock, y: CGFloat(j) * heightBlock)
                self.addChild(bubble)
            }
        }
    }

    override func sceneDidLoad() {
        super.sceneDidLoad()

        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    func updateCounter() {
        if counter >= 0 {
            print("\(counter) seconds to the end of the world")
            self.counterLabel.text = counter.description
            counter -= 1
        } else {
            // after the end of the world
            let newScene = ResultScene(size: self.scene!.size)
            newScene.scaleMode = .aspectFill
            self.view?.presentScene(newScene)
        }
    }
}
