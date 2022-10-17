//
//  SecondViewController.swift
//  Race
//
//  Created by macbook m1 on 18.05.22.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var road1: UIImageView = UIImageView()
    var road2: UIImageView = UIImageView()
    var startTmRoad: Timer?

    @IBOutlet var timerLable: UILabel!
    var timer = Timer()

    var bushView = UIImageView()
    var imageView = UIImageView()
    var woodView = UIImageView()
    
    var gameLiveTimer:Timer?
    var gameLiveTimer2:Timer?
    var woodTimer:Timer?
    var bushTimer:Timer?
    
    let secViewModel = SecondViewModel()
    let storageService = StorageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTmRoad = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(moveRoad), userInfo: nil, repeats: false)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moving))
        self.view.addGestureRecognizer(panGesture)
        
        
        let image = UIImage(named: secViewModel.carNameImg)
         imageView = UIImageView(frame: CGRect(x: 200, y: 700, width: 100, height: 200))
        imageView.image = image
        self.view.addSubview(imageView)
        
        
        let bush = UIImage(named: secViewModel.roadBarrier)
        bushView = UIImageView(frame: CGRect(x: 800, y: -0, width: 75, height: 75))
        bushView.image = bush
        self.view.addSubview(bushView)
        
        let wood = UIImage(named: secViewModel.roadBarrier)
        woodView = UIImageView(frame: CGRect(x: 800, y: -0, width: 75, height: 75))
        woodView.image = wood
        self.view.addSubview(woodView)
        
        
       gameLiveTimer =  Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToWood), userInfo: nil, repeats: true)
        
        gameLiveTimer2 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(moveToCenter), userInfo: nil, repeats: true)
        
        startTimer()
        bindingsViewModel()
    
    }
    
    func bindingsViewModel() {
        storageService.saveRealmResults = {[weak self] in
            self?.timerUpdate()
            self?.showError(title: "", message: "")
        }
    }
    
     func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: NSDate(), repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
        timerLable.text = "0"
    }
    
     @objc func timerUpdate() {
         storageService.timerInt = storageService.timerInt + 1
         let elapsed = storageService.timerInt
        
        if elapsed < 60 {
            timerLable.text = String(format: "%d", elapsed)
        } else {
            timerLable.text = String(format: "%d:%d", elapsed / 60, elapsed % 60)
        }
    }
    
    @objc func moveRoad() {
        road1.image = UIImage(named: "road1")
        road1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 896)
        road1.layer.zPosition = -20
        road1.contentMode = .scaleToFill
        self.view.addSubview(road1)
        
        road2.image = UIImage(named: "road1")
        road2.frame = CGRect(x: 0, y: -896, width: self.view.frame.width, height: 896)
        road2.layer.zPosition = -20
        road2.contentMode = .scaleToFill
        self.view.addSubview(road2)
        
        startTmRoad = Timer.scheduledTimer(withTimeInterval: 0.02,  repeats: true) { _ in
            var currentCenterRoad2 = self.road2.center
            currentCenterRoad2.y += 2
            self.road2.center = currentCenterRoad2
            if self.road2.frame == CGRect(x: 0, y: 896, width: self.view.frame.width, height: 896) {
                self.road2.frame = CGRect(x: 0, y: -896, width: self.view.frame.width, height: 896)
            }
            
            var currentCenterRoad1 = self.road1.center
            currentCenterRoad1.y += 2
            self.road1.center = currentCenterRoad1
            if self.road1.frame.origin.y == 896 {
                self.road1.frame.origin.y = -896
            }
        }
    }

   @objc func moveToWood() {
       
       woodTimer?.invalidate()
        self.woodView.frame = CGRect(x: 200, y: 0, width: 75, height: 75)
       
       
       
       woodTimer = Timer.scheduledTimer(withTimeInterval: 0.004, repeats: true) { timer in
           self.woodView.frame.origin.y += 2
           if self.woodView.frame.intersects(self.imageView.frame) {
               self.woodTimer?.invalidate()
               self.gameLiveTimer?.invalidate()
               self.startTmRoad?.invalidate()
               self.storageService.showError()
               self.stopTimer()
           }
       }
   }
    
       @objc func moveToCenter() {
           bushTimer?.invalidate()
        self.bushView.frame = CGRect(x: 0, y: 0, width: 75, height: 75)

           bushTimer = Timer.scheduledTimer(withTimeInterval: 0.007, repeats: true, block: { timer in
               self.bushView.frame.origin.y += 2
               if self.bushView.frame.intersects(self.imageView.frame) {
                   
                   self.bushTimer?.invalidate()
                   self.gameLiveTimer2?.invalidate()
                   self.startTmRoad?.invalidate()
                   self.storageService.showError()
                   self.stopTimer()
               }
           })
    }
    
    @objc func moving(sender: UIPanGestureRecognizer) {
        
        if sender.state == .began {
            
        } else if sender.state == .changed {
            
            let translation = sender.translation(in: self.view)
            
            let newX = imageView.center.x + translation.x
            let newY = imageView.center.y + translation.y
            
            imageView.center = CGPoint(x: newX, y: newY)
            sender.setTranslation(CGPoint.zero, in: self.view)
        } else if sender.state == .ended {
            
        }
    }
}

extension  UIViewController {
    
    func showError(title: String, message: String, completionHandler: (()-> Void)? = nil) {
        let allertViewController = UIAlertController(title: "Вы проиграли", message: "Для выхода нажмите <OK>", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            
            self.navigationController?.popToRootViewController(animated: true)
            
            completionHandler?()
        }
        
        allertViewController.addAction(okButton)
        self.present(allertViewController, animated: true)
    }
}
