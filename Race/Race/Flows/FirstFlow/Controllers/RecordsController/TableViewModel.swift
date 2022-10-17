//
//  TableViewModel.swift
//  Race
//
//  Created by macbook m1 on 5.10.22.
//

import Foundation
import RealmSwift

class TableViewModel {
    
    var realm = try! Realm()
    
    var raceResults: Results<RaceResults>?
    
    
    func dateGame(date: Date) -> String? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "Дата заезда: dd.MM.yy  HH:mm"
        let dateString  = dateFormater.string(from: date)
        return dateString
    }
    
    func timeGames(seconds: Int) -> String {
        if seconds < 60 {
            return String(format:" , время игры: %d c.", seconds)
        } else {
            return String(format:" , время игры: %d:%d c.", seconds / 60, seconds % 60)
        }
    }
    
    func getsaveResults() {

    raceResults = realm.objects(RaceResults.self)
        
    }
}
