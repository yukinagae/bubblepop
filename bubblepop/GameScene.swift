//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

// score
var score = 0.0

class Counter {
    private var queue = DispatchQueue(label: "your.queue.identifier")
    private (set) var value: Int = 0

    func increment() {
        queue.sync {
            value += 1
        }
    }

    func decrement() {
        queue.sync {
            value -= 1
        }
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate, BubbleTouchedDelegate {

    var counter = UserDefaults.standard.integer(forKey: "GameTime")

    let timerLabel = SKLabelNode(fontNamed:"Chalkduster")
    let scoreLabel = SKLabelNode(fontNamed: "Copperplate")

    var previousColor: ColorType?

    let totalBubbles = Counter()

//    var bubbles = [Bubble]() TODO may be better to check intersect

    private var queue = DispatchQueue(label: "my.queue.identifier")

    // delegated method from bubble
    func onTouch(color: ColorType) {

        if let pColor = previousColor {
            if pColor.name == color.name {
                score += color.point * 1.5
            } else {
                score += color.point
            }
        } else {
            score += color.point
        }

        // update score label text
        scoreLabel.text = score.description

        // update previous color
        self.previousColor = color

        self.totalBubbles.decrement()
        self.addBubble()
    }

    func onRemoved() {
        self.queue.sync {
            self.totalBubbles.decrement()
            print(self.totalBubbles.value)
            self.addBubble()
        }
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

        physicsWorld.contactDelegate = self

        // max bubbles
        let maxBubbles = UserDefaults.standard.integer(forKey: "MaxBubbles")
        print(maxBubbles)
        for _ in 1...maxBubbles {
            self.queue.sync {
                self.addBubble()
            }
        }
    }

    // TODO may be better to use timer
//    func delay(_ delay:Double, closure:@escaping ()->()) {
//        DispatchQueue.main.asyncAfter(
//            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
//    }

//    func synced(_ lock: Any, closure: () -> ()) {
//        objc_sync_enter(lock)
//        closure()
//        objc_sync_exit(lock)
//    }

    override func sceneDidLoad() {
        super.sceneDidLoad()
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    func random(max: UInt32) -> UInt32 {
        return arc4random_uniform(max)
    }

    func getRandomColor() -> ColorType {
        let r = self.random(max: 100) // 0...99

        // TODO debug
        print("random value: \(r)")

        if r < ColorEnum.Red.probability {
            return ColorEnum.Red
        } else if r < ColorEnum.Pink.probability {
            return ColorEnum.Pink
        } else if r < ColorEnum.Green.probability {
            return ColorEnum.Green
        } else if r < ColorEnum.Blue.probability {
            return ColorEnum.Blue
        } else {
            return ColorEnum.Black
        }
    }

    // add bubble
    func addBubble() {

        // do nothing when already maximum bubbles
        let maxBubbles = UserDefaults.standard.integer(forKey: "MaxBubbles")

            // TODO debug
            print(maxBubbles)
            print(self.totalBubbles.value)

            if self.totalBubbles.value >= maxBubbles {
                return
            } else {
                // increment total bubble count
                self.totalBubbles.increment()
                
                let color = self.getRandomColor()
                let bubble = Bubble(color: color)

                // size
                bubble.size = CGSize(width: bubble.size.width/1.5, height: bubble.size.height/1.5)

                // TODO should be random x
                let w: UInt32 = UInt32(self.size.width)
                let h: UInt32 = UInt32(self.size.height)
                let randomX = self.random(max: w)
                let randomY = self.random(max: h)
                let point = CGPoint(x: CGFloat(randomX), y: CGFloat(randomY))
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

                self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
                bubble.physicsBody!.applyImpulse(CGVector(dx: 10, dy: -10.0))

                // delegate
                bubble.delegate = self

                // TODO debug
                print("total bubble: \(self.totalBubbles.value)")
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
