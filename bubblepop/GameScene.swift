//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Bubble   : UInt32 = 0b1       // 1
}

var score = 0

class GameScene: SKScene, SKPhysicsContactDelegate {

    var counter = 10

    let timerLabel = SKLabelNode(fontNamed:"Chalkduster")

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

        self.backgroundColor = SKColor.white

        // frame
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody

        // TODO how many bubbles?
        (1...3).map {
            iteration in
            delay(Double(iteration)) {
                self.addBubble(point: CGPoint(x: self.size.width/2, y: self.size.height))
            }
        }
    }

    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

    override func sceneDidLoad() {
        super.sceneDidLoad()

        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    func addBubble(point: CGPoint) {
        let bubble = Bubble()
        bubble.position = point
        self.addChild(bubble)

        // physics
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: max(bubble.size.width / 2, bubble.size.height / 2))
        bubble.physicsBody?.allowsRotation = false
        bubble.physicsBody?.isDynamic = true
        bubble.physicsBody?.friction = 0
        bubble.physicsBody?.restitution = 1
        bubble.physicsBody?.linearDamping = 0
        bubble.physicsBody?.angularDamping = 0

        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        bubble.physicsBody!.applyImpulse(CGVector(dx: 2.0, dy: -2.0))
    }

    func updateCounter() {
        if counter >= 0 {
            print("\(counter) seconds to the end of the world")
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
