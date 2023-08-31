//
//  MenuViewController.swift
//  GameBat
//
//  Created by macbook m1 on 28.06.23.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class MenuViewController: UIViewController {
    
    //MARK: - UIButton
    @IBOutlet weak var playButton: UIButton!
    
    //MARK: - Audio Player
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "totalPoint") != nil {
            Model.sharedInstance.totalScore = UserDefaults.standard.object(forKey: "totalPoint") as! Int
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
    
    @IBAction func openGameScene() {
        playSound()
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = str.instantiateViewController(withIdentifier: "SelectBgViewController") as? SelectBgViewController {
            
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }
}
