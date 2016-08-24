//
//  LaunchCodesViewController.swift
//  Launch Codes
//
//  Created by KENNETH VACZI on 8/19/16.
//  Copyright © 2016 KENNETH VACZI. All rights reserved.
//

import UIKit

class LaunchCodesViewController: UIViewController {

    @IBOutlet weak var code1Label: LaunchCodeLabel!
    @IBOutlet weak var code2Label: LaunchCodeLabel!
    @IBOutlet weak var code3Label: LaunchCodeLabel!
    @IBOutlet weak var code4Label: LaunchCodeLabel!
    
    @IBOutlet weak var guess1Button: LaunchCodeButton!
    @IBOutlet weak var guess2Button: LaunchCodeButton!
    @IBOutlet weak var guess3Button: LaunchCodeButton!
    @IBOutlet weak var guess4Button: LaunchCodeButton!
    @IBOutlet weak var guess5Button: LaunchCodeButton!
    @IBOutlet weak var guess6Button: LaunchCodeButton!
    @IBOutlet weak var guess7Button: LaunchCodeButton!
    @IBOutlet weak var guess8Button: LaunchCodeButton!
    
    @IBAction func guess1ButtonTap(_ sender: LaunchCodeButton) {
        guessButtonTap(sender)
    }
    @IBAction func guess2ButtonTap(_ sender: LaunchCodeButton) {
        guessButtonTap(sender)
    }
    @IBAction func guess3ButtonTap(_ sender: LaunchCodeButton) {
        guessButtonTap(sender)
    }
    @IBAction func guess4ButtonTap(_ sender: LaunchCodeButton) {
        guessButtonTap(sender)
    }
    @IBAction func guess5ButtonTap(_ sender: LaunchCodeButton) {
        guessButtonTap(sender)
    }
    @IBAction func guess6ButtonTap(_ sender: LaunchCodeButton) {
        guessButtonTap(sender)
    }
    @IBAction func guess7ButtonTap(_ sender: LaunchCodeButton) {
        guessButtonTap(sender)
    }
    @IBAction func guess8ButtonTap(_ sender: LaunchCodeButton) {
        guessButtonTap(sender)
    }
    
    var guessList: [String?] = []
    var guessButtons: [LaunchCodeButton] = []
    var codeLabels: [LaunchCodeLabel] = []
    var code = LaunchCode()
    
    func guessButtonTap(_ sender: LaunchCodeButton) {
        print("tapped guess \(sender.label())")
        if sender.isAtOrigin() {
            if let firstSlot = firstAvailableGuessSlot() {
                moveGuessToGuessList(sender, destinationPosition: firstSlot)
            }
        } else {
            if sender.currentGuessPosition != nil {
                print("moved from slot \(sender.currentGuessPosition)")
                guessList[sender.currentGuessPosition!] = nil
                sender.moveBackToOrigin()
            }
        }
    }
    
    func firstAvailableGuessSlot() -> Int? {
        for (index, guess) in guessList.enumerated() {
            if guess == nil {
                return index
            }
        }
        return nil
    }
    
    func guessSlotsAreFull() -> Bool {
        return firstAvailableGuessSlot() == nil
    }
    
    func moveGuessToGuessList(_ guess: LaunchCodeButton, destinationPosition: Int) {
        print("moved to slot \(destinationPosition)")
        guess.moveToPoint(codeLabels[destinationPosition].frame.origin, destinationGuessPosition: destinationPosition)
        if let label = guess.titleLabel?.text {
            guessList[destinationPosition] = label
        }
        if guessSlotsAreFull() {
            testCompleteCodeAndReturnIncorrects()
        }
    }
    
    func testCompleteCodeAndReturnIncorrects() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for (index, codeSegmentCheck) in self.code.checkCode(self.guessList).enumerated() {
                if codeSegmentCheck == true {
                    print ("code segment in slot \(index) is correct")
                } else {
                    for guessButton in self.guessButtons {
                        if guessButton.currentGuessPosition == index {
                            print("code segment in slot \(index) is incorrect")
                            self.guessList[guessButton.currentGuessPosition!] = nil
                            guessButton.moveBackToOrigin()
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        code = LaunchCode()
        guessList = [nil, nil, nil, nil]
        guessButtons = []
        
        code1Label.text = ""
        code2Label.text = ""
        code3Label.text = ""
        code4Label.text = ""
        
        codeLabels.append(code1Label)
        codeLabels.append(code2Label)
        codeLabels.append(code3Label)
        codeLabels.append(code4Label)
        
        guessButtons.append(guess1Button)
        guessButtons.append(guess2Button)
        guessButtons.append(guess3Button)
        guessButtons.append(guess4Button)
        guessButtons.append(guess5Button)
        guessButtons.append(guess6Button)
        guessButtons.append(guess7Button)
        guessButtons.append(guess8Button)
        
        for (index, guess) in code.displayGuessList().enumerated() {
            guessButtons[index].setTitle(guess, for: .normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

