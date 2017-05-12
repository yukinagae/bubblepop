//
//  GameScene.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene {

    var viewController: UIViewController?

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

        // back to home
        let backLabel = SKLabelNode(fontNamed: "Copperplate")
        backLabel.text = "Back to Home"
        backLabel.fontSize = 36
        backLabel.fontColor = SKColor.black
        backLabel.position = CGPoint(x: self.size.width/2, y: 100)
        backLabel.name = "Back"
        self.addChild(backLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch =  touches.first else {
            return
        }

        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)

        if touchedNode.name == "ReStart" {
            score = 0
            let newScene = GameScene(size: self.scene!.size)
            newScene.scaleMode = .aspectFill
            self.view?.presentScene(newScene)
        }
        if touchedNode.name == "Back" {
            self.returnToMainMenu()
            score = 0
        }
    }

    func returnToMainMenu(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
        self.viewController?.present(vc, animated: true, completion: nil)

        let username = UserDefaults.standard.string(forKey: "username")

        if var scores = UserDefaults.standard.object(forKey: "scores") as? Dictionary<String, UInt32> {
            print("aloha")
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
    }
}
