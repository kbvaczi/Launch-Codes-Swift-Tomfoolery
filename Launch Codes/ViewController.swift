//
//  ViewController.swift
//  Launch Codes
//
//  Created by KENNETH VACZI on 8/6/16.
//  Copyright © 2016 KENNETH VACZI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var disarmCode = 0
    var guessesLeft = 0
    
    @IBOutlet weak var codeEnterTextField: UITextField!
    @IBOutlet weak var guessResponseLabel: UILabel!
    @IBOutlet weak var countdownTimerLabel: UILabel!
    
    @IBAction func guessButtonTap(_ sender: UIButton) {
        if !(codeEnterTextField.text ?? "").isEmpty {
            if (codeEnterTextField.text! as NSString).integerValue == disarmCode {
                //Disarm
                guessResponseLabel.text = "Congratulations!!"
                countdownTimerLabel.text = "You stopped the launch"
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                    self.initializeCountdown()
                }
            } else if guessesLeft > 1 {
                //Wrong
                guessResponseLabel.text = "Nope!"
                guessesLeft -= 1
                countdownTimerLabel.text = String(guessesLeft)
            } else {
                //Boom
                let countriesPotentiallyDestroyed = ["Brazil", "Russia", "USA", "Croatia", "Australia"] //Random countries
                guessResponseLabel.text = "Oops!!"
                countdownTimerLabel.text = "You destroyed \(countriesPotentiallyDestroyed[Int(arc4random_uniform(UInt32(countriesPotentiallyDestroyed.count)))])"
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                    self.initializeCountdown()
                }
            }
        }
    }
    
    func initializeCountdown() {
        disarmCode = Int(arc4random_uniform(10)) + 1 //random number 1-10
        guessesLeft = 6
        countdownTimerLabel.text = String(guessesLeft)
        guessResponseLabel.text = ""
        codeEnterTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeCountdown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
