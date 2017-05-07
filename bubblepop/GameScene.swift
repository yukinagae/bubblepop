//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

var score = 0.0

class GameScene: SKScene, SKPhysicsContactDelegate, BubbleTouchedDelegate {

    var counter = UserDefaults.standard.integer(forKey: "GameTime")

    let timerLabel = SKLabelNode(fontNamed:"Chalkduster")
    let scoreLabel = SKLabelNode(fontNamed: "Copperplate")

    var previousColor: ColorType?

    var totalBubbles = 0

    func onTouch(color: ColorType) {

        if let pColor = previousColor {
            if pColor.name == color.name {
                score += color.point * 1.5
            }
        } else {
            score += color.point
        }

        // update score label text
        scoreLabel.text = score.description

        // update previous color
        self.previousColor = color

        // add bubble
        self.addBubble()

        // decrement total bubble count
        self.totalBubbles -= 1
    }

    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

    override func didMove(to view: SKView) {

        // count down timer
        timerLabel.text = counter.description
        timerLabel.fontSize = 48;
        timerLabel.fontColor = SKColor.black
        timerLabel.position = CGPoint(x: self.size.width/2, y: 30);
        self.addChild(timerLabel)

        // score
        scoreLabel.text = score.description
        scoreLabel.fontSize = 48;
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2);
        self.addChild(scoreLabel)

        self.backgroundColor = SKColor.white

        // frame
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody

        // max bubbles
        let maxBubbles = UserDefaults.standard.integer(forKey: "MaxBubbles")
        for _ in 1...maxBubbles {
            self.addBubble()
        }
    }

    // TODO may be better to use timer
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

// TODO uncomment later
//    override func sceneDidLoad() {
//        super.sceneDidLoad()
//        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//    }

    // add bubble
    func addBubble() {

        let maxBubbles = UserDefaults.standard.integer(forKey: "MaxBubbles")
        if self.totalBubbles >= maxBubbles {
            return
        }

        delay(1) {

            let bubble = Bubble(color: ColorEnum.Red) // TODO
            let point = CGPoint(x: self.size.width/2, y: self.size.height)
            bubble.position = point
            self.addChild(bubble)

            // physics
            bubble.physicsBody = SKPhysicsBody(circleOfRadius: max(bubble.size.width / 2, bubble.size.height / 2))
            bubble.physicsBody?.allowsRotation = false
            bubble.physicsBody?.isDynamic = true
            bubble.physicsBody?.friction = 0
            bubble.physicsBody?.restitution = 0.5
            bubble.physicsBody?.linearDamping = 0
            bubble.physicsBody?.angularDamping = 0

            self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
            bubble.physicsBody!.applyImpulse(CGVector(dx: 2.0, dy: -2.0))

            // delegate
            bubble.delegate = self

            // increment total bubble count
            self.totalBubbles += 1

            // TODO
            print(self.totalBubbles)
        }
    }

    // update timer
    func updateCounter() {
        if counter >= 0 {
            self.timerLabel.text = counter.description
            counter -= 1
        } else {
            // after the end of the world
            let newScene = ResultScene(size: self.scene!.size)
            newScene.scaleMode = .aspectFill
            self.view?.presentScene(newScene)
        }
    }
}
