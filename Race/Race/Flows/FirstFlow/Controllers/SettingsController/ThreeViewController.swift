//
//  ThreeViewController.swift
//  Race
//
//  Created by macbook m1 on 12.06.22.
//

import UIKit

class ThreeViewController: UIViewController {
    
    @IBOutlet  var carView1: UIImageView!
    let carImage1 = UIImage(named: "car1")
    
    @IBOutlet var carView2: UIImageView!
    let carImage2 = UIImage(named: "car2")
    
    @IBOutlet var bushView: UIImageView!
    let bushImage = UIImage(named: "bush")
    
    @IBOutlet var roadView: UIImageView!
    let roadImage = UIImage(named: "roadsign")
    
    let thrViewModel = ThreeViewModel()
    
    @IBOutlet var nameUser: UITextField!
    @IBOutlet var carColor: UISegmentedControl!
    @IBOutlet var barrier: UISegmentedControl!
    
    @IBOutlet var settings: UILabel!
    @IBOutlet var userNmae: UILabel!
    @IBOutlet var selectCar: UILabel!
    @IBOutlet var obstacle: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameUser.text = thrViewModel.getSavedName()
        carColor.selectedSegmentIndex = thrViewModel.getSavedCarIndex()
        barrier.selectedSegmentIndex = thrViewModel.getSavedBarrierIndex()
        
        settings.text = NSLocalizedString("ThreeViewController_Title", comment: "")
        userNmae.text = NSLocalizedString("ThreeViewController_Name", comment: "")
        selectCar.text = NSLocalizedString("ThreeViewController_ColorCar", comment: "")
        obstacle.text = NSLocalizedString("ThreeViewController_Obstacle", comment: "")
        saveButton.setTitle(NSLocalizedString("ThreeViewController_Save", comment: ""), for: .normal)
        
        carView1.image = carImage1
        carView2.image = carImage2
        bushView.image = bushImage
        roadView.image = roadImage
    }
    
    @IBAction func saveSettings()  {
        self.thrViewModel.saveName(name: nameUser.text ?? "")

        if carColor.selectedSegmentIndex == 0 {
            self.thrViewModel.saveSelectCar(imageName: "car1", carIndex: 0)
        } else if carColor.selectedSegmentIndex == 1 {
            self.thrViewModel.saveSelectCar(imageName: "car2", carIndex: 1)
        }

        if barrier.selectedSegmentIndex == 0 {
            self.thrViewModel.saveBarrier(imageName: "bush", barrierIndex: 0)
        } else if barrier.selectedSegmentIndex == 1 {
            self.thrViewModel.saveBarrier(imageName: "roadsign", barrierIndex: 1)
        }
    }
}
