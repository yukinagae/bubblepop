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

weak var scoreLabel: UILabel!

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // settings
        // TODO can be modified in settings controller
//        UserDefaults.standard.set(10, forKey: "GameTime")
//        UserDefaults.standard.set(15, forKey: "MaxBubbles")
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill

            scene.viewController = self
                
                // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

//    func launchViewController() {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = mainStoryboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
//        self.present(vc, animated: true, completion: nil)
//    }

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
