//
//  FirstFlowCoordinator.swift
//  Race
//
//  Created by macbook m1 on 14.10.22.
//

import Foundation
import UIKit

class  FirstFlowCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        openFirstViewController()
    }
    
    func openFirstViewController() {
        let str = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = str.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {return}
        viewController.openSecondViewScreen = {[weak self] in
            self?.openGameController()
        }
        
        viewController.openThreeViewScreen = {[weak self] in
            self?.openSettingsController()
        }
        
        viewController.openTableViewScreen = {[weak self] in
            self?.openRecordsController()
        }
        
        navigationController.viewControllers.append(viewController)
    }
    
    func openGameController() {
        let str = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = str.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openSettingsController() {
        let str = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = str.instantiateViewController(withIdentifier: "ThreeViewController") as? ThreeViewController else {return}
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openRecordsController() {
        let str = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = str.instantiateViewController(withIdentifier: "TableRecords") as? TableRecords else {return}
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
