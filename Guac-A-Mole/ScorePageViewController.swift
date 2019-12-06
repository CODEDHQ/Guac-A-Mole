//
//  ScorePageViewController.swift
//  Guac-A-Mole
//
//  Created by Forat Bahrani on 12/6/19.
//  Copyright © 2019 Forat Bahrani. All rights reserved.
//

import UIKit

class ScorePageViewController: UIViewController {

    @IBOutlet weak var lblScore: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblScore.text = String.init(format: "%d", score)

    }
    @IBAction func playAgain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
