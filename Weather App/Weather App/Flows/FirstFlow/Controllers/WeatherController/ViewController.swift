//
//  ViewController.swift
//  Weather App
//
//  Created by macbook m1 on 17.07.22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityLable: UILabel!
    
    @IBOutlet weak var tempLable: UILabel!
    
    @IBOutlet weak var moistureLable: UILabel!
    
    @IBOutlet weak var windLable: UILabel!
    
    var weather: WeatherData?
    var cityName: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateView()
    }
    
    @IBAction func didTapTableView() {
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc: TableViewController = str.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController {
            
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        }
    }
    
    func updateView() {
        tempLable.text = String(weather?.hourly?.temperature_2m!.first ?? 0)
        moistureLable.text = String(weather?.hourly?.relativehumidity_2m!.first ?? 0)
        windLable.text = String(weather?.hourly?.windspeed_10m!.first ?? 0)
        cityLable.text = cityName
    }
    
}

