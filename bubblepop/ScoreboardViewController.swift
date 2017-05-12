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

class ScoreboardViewController: UITableViewController {


    var fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
                  "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
                  "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
                  "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
                  "Pear", "Pineapple", "Raspberry", "Strawberry"]

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        cell.textLabel?.text = fruits[indexPath.row]

        print(cell)

        return cell
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
