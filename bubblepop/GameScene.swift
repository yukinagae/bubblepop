//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit
import AudioToolbox

// score
var score: UInt32 = 0

// this class is all about this game
class GameScene: SKScene, SKPhysicsContactDelegate, BubbleTouchedDelegate {

    var viewController: UIViewController?

    var alert = false

    var counter = UserDefaults.standard.integer(forKey: "GameTime")

    let timerLabel = SKLabelNode(fontNamed:"Copperplate")
    let scoreLabel = SKLabelNode(fontNamed: "Copperplate")

    var previousColor: ColorType?
    let totalBubbles = Counter()
    var bubbles = [Bubble]()
    // TODO private var queue = DispatchQueue(label: "bubble.queue.identifier")

    // delegated method from bubble
    func onTouch(bubble: Bubble) {

        let color = bubble.myColor
        var point = color.point

        if let pColor = previousColor {
            if pColor.name == color.name {
                point = UInt32(ceil(Double(color.point) * 1.5)) // combo point
                score += point
                // show combo label
                self.showCombo(bubble: bubble)
            } else {
                score += point
            }
        } else {
            score += point
        }

        self.showPoint(point: point, bubble: bubble)

        // update score label text
        scoreLabel.text = "Score: \(score)"

        // update previous color
        self.previousColor = color

        // TODO i think total bubbles can be replaced to just count self.bubbles
        self.totalBubbles.decrement()
        self.addBubble()
    }

    func showPoint(point: UInt32, bubble: Bubble) {
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
    }

    func showCombo(bubble: Bubble) {
        let comboLabel = SKLabelNode(fontNamed:"Copperplate")
        comboLabel.text = "1.5x Combo!"
        comboLabel.fontSize = 30;
        comboLabel.fontColor = bubble.skcolor
        comboLabel.position = CGPoint(x: bubble.position.x-10, y: bubble.position.y+20);
        self.addChild(comboLabel)

        let actionFadeOut = SKAction.fadeOut(withDuration: 0.5)
        let actionDone = SKAction.removeFromParent()
        comboLabel.run(SKAction.sequence([actionFadeOut, actionDone]))
    }

    override func didMove(to view: SKView) {

        score = 0

        // count down timer
        timerLabel.text = "Time: \(self.counter)"
        timerLabel.fontSize = 18;
        timerLabel.fontColor = SKColor.black
        timerLabel.position = CGPoint(x: 50, y: self.size.height-50);
        self.addChild(timerLabel)

        // score
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 18;
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.size.width/2-30, y: self.size.height-50);
        self.addChild(scoreLabel)

        // highest score
        if let scores = UserDefaults.standard.object(forKey: "Scores") as? Dictionary<String, UInt32> {
            if let highscore = scores.values.max() {
                let highscoreLabel = SKLabelNode(fontNamed:"Copperplate")
                highscoreLabel.text = "High Score: \(highscore)"
                highscoreLabel.fontSize = 18;
                highscoreLabel.fontColor = SKColor.black
                highscoreLabel.position = CGPoint(x: self.size.width-70, y: self.size.height-50);
                self.addChild(highscoreLabel)
            }
        }

        self.backgroundColor = SKColor.white

        // frame
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody

        physicsWorld.contactDelegate = self

        // max bubbles
        let maxBubbles = UserDefaults.standard.integer(forKey: "MaxBubbles")
        for _ in 1...maxBubbles {
            self.addBubble()
        }
    }

    override func sceneDidLoad() {
        super.sceneDidLoad()
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    func removeBubble() -> Bool {

        if self.bubbles.isEmpty {
            return true
        }

        let length = self.bubbles.count

        let index = Int(Util.random(max: UInt32(length-1)))

        let bubble = self.bubbles[index]

        if bubble.touched {
            return false
        } else {
            self.bubbles.remove(at: index)

            bubble.removeFromParent()

            self.totalBubbles.decrement()
            
            return true
        }
    }

    // add bubble
    func addBubble() {

        // do nothing when already maximum bubbles
        let maxBubbles = UserDefaults.standard.integer(forKey: "MaxBubbles")

            if self.totalBubbles.value >= maxBubbles {
                return
            } else {
                // increment total bubble count
                self.totalBubbles.increment()
                
                let color = Util.getRandomColor()
                let bubble = Bubble(color: color)

                // size
                bubble.size = CGSize(width: bubble.size.width/1.5, height: bubble.size.height/1.5)

                // TODO should be random x
                let w: UInt32 = UInt32(self.size.width)
                let h: UInt32 = UInt32(self.size.height)
                let randomX = Util.random(max: w)
                let randomY = Util.random(max: h)
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

                self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
                bubble.physicsBody!.applyImpulse(CGVector(dx: 10, dy: -10.0))

                // delegate
                bubble.delegate = self
            }
    }

    // update timer
    func updateCounter() {
        if counter >= 0 {
            self.timerLabel.text = "Time: \(self.counter)"
            counter -= 1

            // TODO remove random 3 bubbles
            var removedCount = 0
            while(removedCount < 2) {
                let result = self.removeBubble()
                if result {
                    removedCount += 1
                }
            }

            // TODO add random 3 bubbles
            for _ in 0..<3 {
                self.addBubble()
            }

        } else {

            // store high score
            let username = UserDefaults.standard.string(forKey: "Username")

            if var scores = UserDefaults.standard.object(forKey: "Scores") as? Dictionary<String, UInt32> {
                if let oldScore = scores[username!] {
                    if UInt32(score) > oldScore {
                        scores[username!] = UInt32(score)
                        UserDefaults.standard.set(scores, forKey: "Scores")
                    }
                } else {
                    scores[username!] = UInt32(score)
                    UserDefaults.standard.set(scores, forKey: "Scores")
                }
            }

            if alert {
                return
            }

            if !alert {
                // vibration should be cool
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
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
