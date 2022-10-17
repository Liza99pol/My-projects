//
//  SecondViewModel.swift
//  Race
//
//  Created by macbook m1 on 4.10.22.
//

import Foundation
//import RealmSwift

class SecondViewModel {
    
    let carNameImg = UserDefaults.standard.string(forKey: KeyDefaults.carName) ?? "car1"
    let roadBarrier = UserDefaults.standard.string(forKey: KeyDefaults.barrierName) ?? "bush"
    
    var startGameDat = Date()
    

    func gameDat() {
    
    let calendar = Calendar.current
    
    let date1 = calendar.startOfDay(for: startGameDat)
    
    let date2 = calendar.startOfDay(for: startGameDat)

    let components = calendar.dateComponents([.second], from: date1, to: date2)
        
    let seconds = components.second
        
    }
}
