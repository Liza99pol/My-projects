//
//  StorageService.swift
//  Race
//
//  Created by macbook m1 on 14.10.22.
//

import Foundation
import RealmSwift

class StorageService {
    
    var realm = try! Realm()
    
    var timerInt = 0
    
    var raceResults: Results<RaceResults>?
    
    var saveRealmResults: (()-> Void)?
    
    
    func showError() {
        
        try! realm.write({
            let results = RaceResults()
            results.dateGames = Date()
            results.timeGame = timerInt
            self.realm.add(results)
            self.saveRealmResults?()
        })
    }
    
    func getsaveResults() {

    raceResults = realm.objects(RaceResults.self)
        
    }
}
