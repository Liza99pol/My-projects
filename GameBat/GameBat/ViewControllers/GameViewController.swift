//
//  GameViewController.swift
//  GameBat
//
//  Created by macbook m1 on 31.05.23.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    //MARK: - SKScene
    var scene = GameScene(fileNamed: "GameScene")
    
    //MARK: - Variables
    var gameVCBgSelect: SelectBg!
    
    //MARK: - UIButton
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    //MARK: - UILable
    @IBOutlet weak var gameOverLabel: UILabel!
    
    //MARK: - Audio Player
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        replayButton.isHidden = true
        menuButton.isHidden = true
        gameOverLabel.isHidden = true
        
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        scene?.gameSceneBg = gameVCBgSelect
        scene?.gameViewController = self
        scene!.scaleMode = .aspectFill
        view.presentScene(scene)
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
    
    @IBAction func replayGameButton(sender: UIButton) {
        playSound()
        scene?.replayGame()
        replayButton.isHidden = true
        menuButton.isHidden = true
        gameOverLabel.isHidden = true
        scene?.recordLable.isHidden = true
    }
    
    @IBAction func backToMenu() {
        playSound()
        self.dismiss(animated: true)
        
        DispatchQueue.main.async {
            self.scene?.removeAll()
        }
    }
    
    func setupUI() {
        gameOverLabel.font = .init(name: "AmericanTypewriter-Bold", size: 50)
        gameOverLabel.text = "Game Over"
        gameOverLabel.textColor = .white
        gameOverLabel.shadowColor = .black
        gameOverLabel.shadowOffset = .init(width: 3, height: -1)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
