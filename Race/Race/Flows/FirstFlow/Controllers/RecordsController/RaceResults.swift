//
//  RaceResults.swift
//  Race
//
//  Created by macbook m1 on 2.07.22.
//

import Foundation
import RealmSwift

class RaceResults: Object {
    
   @Persisted var dateGames: Date?
   @Persisted var timeGame: Int?
   
}
