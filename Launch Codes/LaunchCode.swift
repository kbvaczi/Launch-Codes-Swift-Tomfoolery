//
//  LaunchCode.swift
//  Launch Codes
//
//  Created by KENNETH VACZI on 8/19/16.
//  Copyright © 2016 KENNETH VACZI. All rights reserved.
//

import Foundation

class LaunchCode {
    
    var code: [String]
    var codeLength = 4
    
    var guessList: [String]
    var guessListLength = 8
    
    
    let dictionaryList = ["Tower", "X-ray", "Alpha", "Tree", "Dog", "Cat", "Wolf", "Omega", "Bird", "Tango", "Romeo", "Trap", "Park", "Blow", "Kilo", "Echo", "Alpha", "India", "Zulu", "Victor", "Golf", "Delta", "Granny", "Farce", "Gooey", "Up", "Below", "Jump", "Mouse", "Grass", "Smell", "Funny", "Gross", "Tarp", "Body", "Hand", "Spray", "Boss", "Shock", "Roll"]
    
    init() {
        code = []
        for _ in (1...codeLength) {
            code.append(dictionaryList[Int(arc4random_uniform(UInt32(dictionaryList.count - 1)))])
        }
        guessList = code
        for _ in (1...(guessListLength - codeLength)) {
            guessList.append(dictionaryList[Int(arc4random_uniform(UInt32(dictionaryList.count - 1)))])
        }
        guessList.sort()
    }
    
    public func displayCode() -> [String] {
        var displayCode: [String] = []
        for i in (0..<codeLength) {
            displayCode.append(code[i])
        }
        return displayCode
    }
    
    public func displayGuessList() -> [String] {
        var displayCode: [String] = []
        for i in (0..<guessListLength) {
            displayCode.append(guessList[i])
        }
        return displayCode
    }
    
    public func checkCode(_ potentialCode: [String?]) -> [Bool] {
        var matchList: [Bool] = []
        for (index, codeEntry) in potentialCode.enumerated() {
            matchList.append(codeEntry == code[index])
        }
        return matchList
    }
}
