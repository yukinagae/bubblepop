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

class SettingViewController: UIViewController {

    @IBOutlet weak var maxBubbleSlider: UISlider!

    @IBOutlet weak var gameTimeSlider: UISlider!

    @IBOutlet weak var maxBubbleLabel: UILabel!

    @IBOutlet weak var gameTimeLabel: UILabel!

    @IBAction func sliderChanged(_ sender: Any) {

        if let slider = sender as? UISlider {
            let currentValue = Int(slider.value)
            maxBubbleLabel.text = "\(currentValue)"
            UserDefaults.standard.set(currentValue, forKey: "MaxBubbles")
        }
    }

    @IBAction func gameTimeChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let currentValue = Int(slider.value)
            gameTimeLabel.text = "\(currentValue)"
            UserDefaults.standard.set(currentValue, forKey: "GameTime")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // max bubble
        let maxBubble = UserDefaults.standard.integer(forKey: "MaxBubbles")

        if maxBubble > 0 {
            maxBubbleLabel.text = "\(maxBubble)"
            maxBubbleSlider.value = Float(maxBubble)
        } else {
            let maxBubblesDefaultValue = 15
            maxBubbleLabel.text = "\(maxBubblesDefaultValue)"
            maxBubbleSlider.value = Float(maxBubblesDefaultValue)
        }

        // game time
        let gameTime = UserDefaults.standard.integer(forKey: "GameTime")

        if gameTime > 0 {
            gameTimeLabel.text = "\(gameTime)"
            gameTimeSlider.value = Float(gameTime)
        } else {
            let gameTimeDefaultValue = 60
            gameTimeLabel.text = "\(gameTimeDefaultValue)"
            gameTimeSlider.value = Float(gameTimeDefaultValue)
        }

    }

    //    override var shouldAutorotate: Bool {
    //        return false
    //    }

    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        if UIDevice.current.userInterfaceIdiom == .phone {
    //            return .allButUpsideDown
    //        } else {
    //            return .all
    //        }
    //    }

    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Release any cached data, images, etc that aren't in use.
    //    }

    //    override var prefersStatusBarHidden: Bool {
    //        return true
    //    }
}
