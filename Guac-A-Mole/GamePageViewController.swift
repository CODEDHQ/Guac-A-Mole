//
//  GamePageViewController.swift
//  Guac-A-Mole
//
//  Created by Forat Bahrani on 12/6/19.
//  Copyright © 2019 Forat Bahrani. All rights reserved.
//

import UIKit
var score = 0

class GamePageViewController: UIViewController {

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!

    var buttons: [UIButton] {
        return
        [
            btn1,
            btn2,
            btn3,
            btn4,
            btn5,
            btn6,
            btn7,
            btn8,
            btn9
        ]
    }

    func randBool() -> Bool { return [false, false, false, true].random() }
    var states: [Int] = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
    /*
     
     -1 = hidden
     0 = visible
     1 = tapped
     
     */
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    var time = 20
    var p = false
    
    override func viewWillAppear(_ animated: Bool) {
        if p {
            time = 120
            score = 0
            lblTime.textColor = lblScore.textColor
            p = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
            for i in 0..<self.states.count {
                if self.states[i] == -1 && self.randBool() {
                    self.states[i] = 0
                } else if self.states[i] == 0 {
                    self.states[i] = -1
                }
            }
        })

        for i in 0..<buttons.count {
            let btn = buttons[i]
            btn.tag = i
            btn.on(.touchDown) { (_) in
                if self.states[btn.tag] == 0 {
                    self.states[btn.tag] = 1
                    score += 5
                }
            }
        }

        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (_) in
            self.lblTime.text = String.init(format: "%3d", self.time)
            self.lblScore.text = String.init(format: "%3d", score)

            for i in 0..<self.buttons.count {
                let b = self.buttons[i]
                let s = self.states[i]
                b.isHidden = s == -1
                b.setImage(UIImage(named: s == 0 ? "avocado" : "food"), for: .normal)
                if s == 1 {
                    UIView.animate(withDuration: 3) {
                        b.alpha = 0.001
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        b.alpha = 1
                        b.isHidden = true
                        self.states[i] = -1
                    }
                }
            }

        })

        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            if self.time > 0 {
                self.time -= 1
            }
        })
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (_) in
            if self.p { return }
            if self.time <= 0 {
                self.p = true
                self.performSegue(withIdentifier: "go", sender: nil)
                return
            }
            if self.time > 10 { return }
            else {
                self.lblTime.isHidden =  !self.lblTime.isHidden
                self.lblTime.textColor = .red
            }
            
        })
    }


}
