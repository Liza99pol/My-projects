//
//  Model.swift
//  GameBat
//
//  Created by macbook m1 on 17.08.23.
//

import Foundation

enum SelectBg: Int {
    case bg1, bg2, bg3, bg4
}

class Model {
    static let sharedInstance = Model()
    
    //Variables
    var sound = true
    var score = 0
    var record = 0
    var totalScore = 0
    
    var level2UnlockValue = 200
    var level3UnlockValue = 400
    var level4uUnlockValue = 800
}
