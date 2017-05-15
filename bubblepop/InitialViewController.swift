//
//  GameViewController.swift
//  bubblepop
//
//  Created by Yuki Nagae on 2017/05/06.
//  Copyright © 2017 Yuki Nagae. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class InitialViewController: UIViewController {

    @IBOutlet weak var yourname: UILabel!
    @IBOutlet weak var username: UITextField!

    // default setting
    override func viewDidLoad() {
        super.viewDidLoad()

        // user score dictionary
        if let _ = UserDefaults.standard.object(forKey: "scores") as? Dictionary<String, UInt32> {
        } else {
            let scores: Dictionary<String, UInt32> = [:]
            UserDefaults.standard.set(scores, forKey: "scores")
        }

        // username
        if let name = UserDefaults.standard.string(forKey: "username") {
            self.yourname.text = name
        } else {
            // default user for lazy people who don't want to enter user names :)
            UserDefaults.standard.set("default user", forKey: "username")
            self.yourname.text = "default user"
        }

        // max bubbles
        let maxBubbles = UserDefaults.standard.integer(forKey: "MaxBubbles")
        if maxBubbles == 0 {
            UserDefaults.standard.set(15, forKey: "MaxBubbles")
        }

        // game time
        let gameTime = UserDefaults.standard.integer(forKey: "GameTime")
        if gameTime == 0 {
            UserDefaults.standard.set(60, forKey: "GameTime")
        }
    }

    @IBAction func entered(_ sender: Any) {
        if let name = username.text {
            self.yourname.text = name
            UserDefaults.standard.set(name, forKey: "username")
            username.resignFirstResponder()
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
