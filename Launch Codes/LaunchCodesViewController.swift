//
//  LaunchCodesViewController.swift
//  Launch Codes
//
//  Created by KENNETH VACZI on 8/19/16.
//  Copyright © 2016 KENNETH VACZI. All rights reserved.
//

import UIKit

class LaunchCodesViewController: UIViewController {
    
    @IBOutlet weak var codeLabelsLabel: UILabel!
    @IBOutlet weak var code1Label: LaunchCodeLabel!
    @IBOutlet weak var code2Label: LaunchCodeLabel!
    @IBOutlet weak var code3Label: LaunchCodeLabel!
    @IBOutlet weak var code4Label: LaunchCodeLabel!
    
    @IBOutlet weak var guessButtonsLabel: UILabel!
    @IBOutlet weak var guess1Button: LaunchCodeButton!
    @IBOutlet weak var guess2Button: LaunchCodeButton!
    @IBOutlet weak var guess3Button: LaunchCodeButton!
    @IBOutlet weak var guess4Button: LaunchCodeButton!
    @IBOutlet weak var guess5Button: LaunchCodeButton!
    @IBOutlet weak var guess6Button: LaunchCodeButton!
    @IBOutlet weak var guess7Button: LaunchCodeButton!
    @IBOutlet weak var guess8Button: LaunchCodeButton!
    
    @IBOutlet weak var countdownTimerLabel: UILabel!
    
    @IBAction func guessButtonTap(_ sender: LaunchCodeButton) {
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

    var guessList: [String?] = []
    var guessButtons: [LaunchCodeButton] = []
    var codeLabels: [LaunchCodeLabel] = []
    var code = LaunchCode()
    var countdownSecondsLeft: Int = 60
    var countdown = Timer()
    
    let guessButtonBackgroundColor = UIColor(white: 0.9, alpha: 1)
    let guessButtonTextColor = UIColor(white: 0.25, alpha: 1)
    let guessButtonCorrectTextColor = UIColor.green
    
    
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
            var codeIsCorrect = true
            for (index, codeSegmentCheck) in self.code.checkCode(self.guessList).enumerated() {
                if codeSegmentCheck == true {
                    for guessButton in self.guessButtons {
                        if guessButton.currentGuessPosition == index {
                            print("code segment in slot \(index) is correct")
                            guessButton.backgroundColor = nil
                            guessButton.titleLabel?.textColor = self.guessButtonCorrectTextColor
                        }
                    }
                } else {
                    for guessButton in self.guessButtons {
                        if guessButton.currentGuessPosition == index {
                            print("code segment in slot \(index) is incorrect")
                            self.guessList[guessButton.currentGuessPosition!] = nil
                            guessButton.moveBackToOrigin()
                            codeIsCorrect = false
                            guessButton.backgroundColor = self.guessButtonBackgroundColor
                            guessButton.titleLabel?.textColor = self.guessButtonTextColor
                        }
                    }
                }
            }
            if codeIsCorrect == true {
                self.winGame()
            }
        }
    }
    
    func winGame() {
        print("congratulations you won")
        countdown.invalidate()
        resetLaunchCode()
    }
    
    func loseGame() {
        print("congratulations you lost")
        countdown.invalidate()
        resetLaunchCode()
    }
    
    func decreaseCountdown() {
        print ("decreasing countdown")
        countdownSecondsLeft -= 1
        countdownTimerLabel.text = String(countdownSecondsLeft)
        if countdownSecondsLeft <= 0 {
            loseGame()
        }        
    }
    
    func initializeCountdown() {
        countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decreaseCountdown), userInfo: nil, repeats: true)
    }
    
    func resetLaunchCode() {
        code = LaunchCode()
        guessList = [nil, nil, nil, nil]
        guessButtons = []
        codeLabels = []
        countdownSecondsLeft = 60
        
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
        
        for guessButton in guessButtons {
            guessButton.backgroundColor = guessButtonBackgroundColor
            guessButton.titleLabel?.textColor = guessButtonTextColor
        }
        
        initializeCountdown()
        
        arrangeLayout()
    }
    
    func arrangeLayout () {
        let buttonWidth = (self.view.frame.width / CGFloat(code.guessListLength + 2)) * 2
        let buttonHeight = CGFloat((guess1Button.titleLabel?.font.lineHeight)!) * 1.5
        let buttonSpacingX = (self.view.frame.width - buttonWidth * CGFloat(code.guessListLength / 2)) / CGFloat(code.guessListLength / 2 + 1)
        let firstRowSpacingY = self.view.frame.height - buttonHeight * 5
        let secondRowSpacingY = firstRowSpacingY + buttonHeight * 1.5
        for (index, button) in guessButtons[0...3].enumerated() {
            button.frame = CGRect(x: (buttonSpacingX + buttonWidth) * CGFloat(index) + buttonSpacingX, y: firstRowSpacingY, width: buttonWidth, height: buttonHeight)
        }
        for (index, button) in guessButtons[4...7].enumerated() {
            button.frame = CGRect(x: (buttonSpacingX + buttonWidth) * CGFloat(index) + buttonSpacingX, y: secondRowSpacingY, width: buttonWidth, height: buttonHeight)
        }
        let codeSpacingY = buttonHeight * 4
        for (index, label) in codeLabels[0...3].enumerated() {
            label.frame = CGRect(x: (buttonSpacingX + buttonWidth) * CGFloat(index) + buttonSpacingX, y: codeSpacingY, width: buttonWidth, height: buttonHeight)
            label.backgroundColor = nil
        }
        guessButtonsLabel.frame = CGRect(x: buttonSpacingX, y: firstRowSpacingY - buttonHeight, width: self.view.frame.width, height: buttonHeight)
        codeLabelsLabel.frame = CGRect(x: buttonSpacingX, y: codeSpacingY - buttonHeight, width: self.view.frame.width, height: buttonHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetLaunchCode()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

