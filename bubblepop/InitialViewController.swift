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

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }

    @IBOutlet weak var username: UITextField!

    @IBAction func entered(_ sender: Any) {
        if let name = username.text {
            print(name)
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
