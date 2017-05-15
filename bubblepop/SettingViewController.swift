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

// show and mamnage setting
class SettingViewController: UIViewController {

    @IBOutlet weak var maxBubbleSlider: UISlider!
    @IBOutlet weak var maxBubbleLabel: UILabel!

    @IBOutlet weak var gameTimeSlider: UISlider!
    @IBOutlet weak var gameTimeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // max bubble
        let maxBubble = UserDefaults.standard.integer(forKey: "MaxBubbles")
        maxBubbleLabel.text = "\(maxBubble)"
        maxBubbleSlider.value = Float(maxBubble)

        // game time
        let gameTime = UserDefaults.standard.integer(forKey: "GameTime")
        gameTimeLabel.text = "\(gameTime)"
        gameTimeSlider.value = Float(gameTime)
        
    }

    // when max bubble slider changed
    @IBAction func maxBubbleChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let currentValue = Int(slider.value)
            maxBubbleLabel.text = "\(currentValue)"
            UserDefaults.standard.set(currentValue, forKey: "MaxBubbles") // update max bubble setting
        }
    }

    // when game time slider changed
    @IBAction func gameTimeChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let currentValue = Int(slider.value)
            gameTimeLabel.text = "\(currentValue)"
            UserDefaults.standard.set(currentValue, forKey: "GameTime") // update game time setting
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
