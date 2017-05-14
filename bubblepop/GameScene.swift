//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

// score
var score: UInt32 = 0

// physics category
let BubbleCategory   : UInt32 = 0x1 << 0
//let BorderCategory   : UInt32 = 0x1 << 1

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

    var viewController: UIViewController?

    var alert = false

    var counter = UserDefaults.standard.integer(forKey: "GameTime")

    let timerLabel = SKLabelNode(fontNamed:"Copperplate")
    let scoreLabel = SKLabelNode(fontNamed: "Copperplate")

    var previousColor: ColorType?

    let totalBubbles = Counter()

    var bubbles = [Bubble]()

    private var queue = DispatchQueue(label: "my.queue.identifier")

    // delegated method from bubble
    func onTouch(bubble: Bubble) {

        let color = bubble.myColor

        var combo = false
        var point = color.point

        if let pColor = previousColor {
            if pColor.name == color.name {
                point = UInt32(ceil(Double(color.point) * 1.5))
                score += point
                combo = true
            } else {
                score += point
            }
        } else {
            score += point
        }

        // TODO debug
        print("point:\(point)")

        // touched score
        let touchedScore = SKLabelNode(fontNamed:"Copperplate")
        touchedScore.text = "+\(point)"
        touchedScore.fontSize = 30;
        touchedScore.fontColor = bubble.skcolor
        touchedScore.position = CGPoint(x: bubble.position.x, y: bubble.position.y);
        self.addChild(touchedScore)

        let actionFadeOut = SKAction.fadeOut(withDuration: 0.5)
        let actionDone = SKAction.removeFromParent()
        touchedScore.run(SKAction.sequence([actionFadeOut, actionDone]))

        // combo label
        if combo {
            let comboLabel = SKLabelNode(fontNamed:"Copperplate")
            comboLabel.text = "1.5x Combo!"
            comboLabel.fontSize = 30;
            comboLabel.fontColor = bubble.skcolor
            comboLabel.position = CGPoint(x: bubble.position.x-10, y: bubble.position.y+20);
            self.addChild(comboLabel)
            comboLabel.run(SKAction.sequence([actionFadeOut, actionDone]))
        }

        // update score label text
        scoreLabel.text = "Score: \(score)"

        // update previous color
        self.previousColor = color

        // decrement total bubble count
//        synced(self.totalBubbles) {
            self.totalBubbles.decrement()
            self.addBubble()
//        }
    }

    func onRemoved() {
        self.queue.sync {
            self.totalBubbles.decrement()
            print(self.totalBubbles.value)
            self.addBubble()
        }
    }

    override func didMove(to view: SKView) {

        score = 0

        // count down timer
        timerLabel.text = "Time: \(self.counter)"
        timerLabel.fontSize = 48;
        timerLabel.fontColor = SKColor.black
        timerLabel.position = CGPoint(x: self.size.width/2, y: self.size.height - 50);
        self.addChild(timerLabel)

        // score
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 48;
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.size.width/2, y: 50);
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


// TODO uncomment later
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

    func removeBubble() {

        if self.bubbles.isEmpty {
            return
        }

        let length = self.bubbles.count

        let index = Int(self.random(max: UInt32(length-1)))



        let bubble = self.bubbles.remove(at: index)

        bubble.removeFromParent()

        self.totalBubbles.decrement()
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

                // add child bubbles
                self.bubbles.append(bubble)

                // physics
                bubble.physicsBody = SKPhysicsBody(circleOfRadius: max(bubble.size.width / 2, bubble.size.height / 2))
                bubble.physicsBody?.allowsRotation = false
                bubble.physicsBody?.isDynamic = true
                bubble.physicsBody?.friction = 0
                bubble.physicsBody?.restitution = 1
                bubble.physicsBody?.linearDamping = 0
                bubble.physicsBody?.angularDamping = 0
//                bubble.physicsBody?.categoryBitMask = BubbleCategory

                self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
                bubble.physicsBody!.applyImpulse(CGVector(dx: 10, dy: -10.0))

                // delegate
                bubble.delegate = self

                // TODO debug
                print("total bubble: \(self.totalBubbles.value)")
                print("total bubbles actual: \(self.bubbles.count)")
            }
    }

    // update timer
    func updateCounter() {
        if counter >= 0 {
            self.timerLabel.text = "Time: \(self.counter)"
            counter -= 1

            // remove random 3 bubbles
            for _ in 0..<3 {
                print("removed!")
                self.removeBubble()
            }

            // add random 3 bubbles
            for _ in 0..<3 {
                print("add!")
                self.addBubble()
            }

        } else {

            // store high score
            let username = UserDefaults.standard.string(forKey: "username")

            if var scores = UserDefaults.standard.object(forKey: "scores") as? Dictionary<String, UInt32> {
                print(score)
                if let oldScore = scores[username!] {
                    print(oldScore)
                    if UInt32(score) > oldScore {
                        scores[username!] = UInt32(score)
                        UserDefaults.standard.set(scores, forKey: "scores")
                    }
                } else {
                    scores[username!] = UInt32(score)
                    UserDefaults.standard.set(scores, forKey: "scores")
                }
            }

            if alert {
                return
            }


            // after the end of the game
            let alertController = UIAlertController(title: "Game Over", message: "Score: \(score)", preferredStyle: .alert)

            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreboardViewController") as! ScoreboardViewController
                self.viewController?.present(vc, animated: true, completion: nil)
                return
            }
            alertController.addAction(OKAction)

            self.viewController?.present(alertController, animated: true, completion: nil)

            alert = true
        }
    }
}
