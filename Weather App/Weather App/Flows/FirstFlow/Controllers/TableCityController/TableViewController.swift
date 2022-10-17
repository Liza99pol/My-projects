//
//  TableViewController.swift
//  Weather App
//
//  Created by macbook m1 on 28.07.22.
//

import Foundation
import UIKit

//struct CityInfo {
//    
//    var nameCity: String
//    var lat: Double
//    var lon: Double
//    
//}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
  
   let viewModel = TableViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    bindingsViewModel()
        
    }
    
    func bindingsViewModel() {
        viewModel.finishLoadData = {[weak self] in
            self?.tableView.reloadData()
            self?.openWeatherInfo()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableCell", for: indexPath )
        if let nameCell = cell as? NameTableCell {
            
            let city = viewModel.cityInfo[indexPath.row]
            nameCell.cityCell.text = city.nameCity

            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = viewModel.cityInfo[indexPath.row]
        viewModel.lowData(cityInfo: city)
    }

    func openWeatherInfo() {
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc: ViewController = str.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            
           
            vc.cityName = viewModel.cityName
            vc.weather = viewModel.weather
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        }
    }
}

