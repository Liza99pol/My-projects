//
//  TableRecords.swift
//  Race
//
//  Created by macbook m1 on 6.07.22.
//

import Foundation
import UIKit
import RealmSwift

class TableRecords: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let tableViewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableViewModel.getsaveResults()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Результаты гонок"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.raceResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableCell", for: indexPath) as? NameTableCell {
            
            let result = tableViewModel.raceResults?[indexPath.row]
            let gameDateString = tableViewModel.dateGame(date: result?.dateGames ?? Date())! + tableViewModel.timeGames(seconds: result?.timeGame ?? 0 )

            cell.titleCell.text = gameDateString
            
            return cell
        }
        
        return UITableViewCell()
    }
}
