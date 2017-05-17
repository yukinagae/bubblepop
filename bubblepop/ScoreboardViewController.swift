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

// View Controller showing score board
class ScoreboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var scores: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // convert stored score dictionary into score string array
        // these will be displayed in table view
        if let scs = UserDefaults.standard.object(forKey: "Scores") as? Dictionary<String, UInt32> {
            // ordered from high to low scores
            for (key, value) in (Array(scs).sorted {$0.1 > $1.1}) {
                self.scores.append(key + " \(value)")
            }
        }
    }

    // only one section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // the number of the scores
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scores.count
    }

    // set scores on each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.scores[indexPath.row]
        return cell
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
