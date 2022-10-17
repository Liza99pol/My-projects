//
//  ThreeViewModel.swift
//  Race
//
//  Created by macbook m1 on 4.10.22.
//

import Foundation
import UIKit

struct KeyDefaults {
    static let keyName = "name"
    static let keyCar = "car"
    static let keyBarrier = "carBarrier"
    static let carName = "carName"
    static let barrierName = "barrierName"
}

class ThreeViewModel {

    let defaults = UserDefaults.standard
    
   
    func getSavedName() -> String {
        return defaults.string(forKey: KeyDefaults.keyName) ?? ""
    }
    
    func getSavedCarIndex() -> Int {
        return defaults.integer(forKey: KeyDefaults.keyCar)
    }
    
    func getSavedBarrierIndex() -> Int {
        return defaults.integer(forKey: KeyDefaults.keyBarrier)
    }
    
    func saveSelectCar(imageName: String, carIndex: Int) {
        defaults.set(imageName, forKey: KeyDefaults.carName)
        defaults.set(carIndex, forKey: KeyDefaults.keyCar)
    }
    
    func saveBarrier(imageName: String, barrierIndex: Int) {
        defaults.set(imageName, forKey: KeyDefaults.barrierName)
        defaults.set(barrierIndex, forKey: KeyDefaults.keyBarrier)
    }
    
    func saveName(name: String) {
        defaults.set(name, forKey: KeyDefaults.keyName)
    }
}
