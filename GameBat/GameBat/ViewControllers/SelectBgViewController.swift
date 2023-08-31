//
//  SelectBgViewController.swift
//  GameBat
//
//  Created by macbook m1 on 17.08.23.
//

import UIKit
import SpriteKit
import AVFoundation

class SelectBgViewController: UIViewController {
    
    //MARK: - UILable
    @IBOutlet weak var totalScoreLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var pointLable1: UILabel!
    @IBOutlet weak var pointLable2: UILabel!
    @IBOutlet weak var pointLable3: UILabel!
    
    //MARK: - UIButton
    @IBOutlet weak var bgButton1: UIButton!
    @IBOutlet var bgButton2: UIButton!
    @IBOutlet weak var bgButton3: UIButton!
    @IBOutlet weak var bgButton4: UIButton!
    
    //MARK: - Audio Player
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUILabel()
        setupPointLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        scoreLable.text = "\(Model.sharedInstance.totalScore)"

        if Model.sharedInstance.totalScore > Model.sharedInstance.level2UnlockValue && Model.sharedInstance.totalScore < Model.sharedInstance.level3UnlockValue {
            pointLable1.isHidden = true
        } else if Model.sharedInstance.totalScore > Model.sharedInstance.level3UnlockValue && Model.sharedInstance.totalScore > Model.sharedInstance.level2UnlockValue && Model.sharedInstance.totalScore < Model.sharedInstance.level4uUnlockValue {
            pointLable1.isHidden = true
            pointLable2.isHidden = true
        } else if Model.sharedInstance.totalScore > Model.sharedInstance.level4uUnlockValue && Model.sharedInstance.totalScore > Model.sharedInstance.level3UnlockValue && Model.sharedInstance.totalScore > Model.sharedInstance.level2UnlockValue {
            pointLable1.isHidden = true
            pointLable2.isHidden = true
            pointLable3.isHidden = true
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "buttonSound", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
              guard let player = player else { return }

              player.prepareToPlay()
              player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }

    func setupUILabel() {
        totalScoreLable.font = .init(name: "AmericanTypewriter-Bold", size: 35)
        totalScoreLable.text = "Total Score"
        totalScoreLable.textColor = .systemRed
        totalScoreLable.shadowColor = .black
        totalScoreLable.shadowOffset = .init(width: 1, height: -0.7)
        
        scoreLable.font = .init(name: "AmericanTypewriter-Bold", size: 35)
        scoreLable.textColor = .systemRed
        scoreLable.shadowColor = .black
        scoreLable.shadowOffset = .init(width: 1, height: -0.7)
    }
    
    func setupPointLabels() {
        pointLable1.font = .init(name: "AmericanTypewriter-Bold", size: 22)
        pointLable1.text = "Get 200 point to unlock"
        pointLable1.textColor = .yellow
        
        pointLable2.font = .init(name: "AmericanTypewriter-Bold", size: 22)
        pointLable2.text = "Get 400 point to unlock"
        pointLable2.textColor = .yellow
        
        pointLable3.font = .init(name: "AmericanTypewriter-Bold", size: 22)
        pointLable3.text = "Get 800 point to unlock"
        pointLable3.textColor = .yellow
    }
    
    @IBAction func selectBg(sender: UIButton) {
        playSound()
        if let storyboard = storyboard {
            let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            
            gameViewController.gameVCBgSelect = SelectBg(rawValue: sender.tag)!
            
            gameViewController.modalPresentationStyle = .fullScreen
            gameViewController.modalTransitionStyle = .crossDissolve
            
            if gameViewController.gameVCBgSelect.rawValue == 0 {
                self.present(gameViewController, animated: true)
            } else if gameViewController.gameVCBgSelect.rawValue == 1 && Model.sharedInstance.totalScore > Model.sharedInstance.level2UnlockValue {
                self.present(gameViewController, animated: true)
            } else if gameViewController.gameVCBgSelect.rawValue == 2 && Model.sharedInstance.totalScore > Model.sharedInstance.level3UnlockValue {
                self.present(gameViewController, animated: true)
            } else if gameViewController.gameVCBgSelect.rawValue == 3 && Model.sharedInstance.totalScore > Model.sharedInstance.level4uUnlockValue {
                self.present(gameViewController, animated: true)
            }
        }
    }
    
    @IBAction func backToMenu() {
        playSound()
        self.dismiss(animated: true)
    }
}
