//
//  GameScene_Physics.swift
//  GameBat
//
//  Created by macbook m1 on 8.06.23.
//

import Foundation
import SpriteKit

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        
        if Model.sharedInstance.score > Model.sharedInstance.record {
            Model.sharedInstance.record = Model.sharedInstance.score
        }
        UserDefaults.standard.set(Model.sharedInstance.record, forKey: "record")
        
        if contact.bodyA.categoryBitMask == rapCategory || contact.bodyB.categoryBitMask == rapCategory {
            bat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            if Model.sharedInstance.sound == true {
                run(bumpPreload)
            }
            
            bat.physicsBody?.allowsRotation = false
            
            if lifeObj1.isHidden == false {
                let explosion = SKEmitterNode(fileNamed: "Magic")
                explosion?.position = lifeNode1.position
                self.addChild(explosion!)
                
                lifeObj1.isHidden = true
                batObj.removeAllChildren()
                movingObj.isHidden = true
                
                self.run(SKAction.wait(forDuration: 1)) {
                    explosion?.removeFromParent()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.setupBat()
                    self.movingObj.isHidden = false
                    self.createSky()
                }
            } else if lifeObj2.isHidden == false {
                let explosion = SKEmitterNode(fileNamed: "Magic")
                explosion?.position = lifeNode2.position
                self.addChild(explosion!)
                
                lifeObj2.isHidden = true
                batObj.removeAllChildren()
                movingObj.isHidden = true
                
                self.run(SKAction.wait(forDuration: 1)) {
                    explosion?.removeFromParent()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.setupBat()
                    self.movingObj.isHidden = false
                    self.createSky()
                }
                
            }  else if lifeObj3.isHidden == false {
                let explosion = SKEmitterNode(fileNamed: "Magic")
                explosion?.position = lifeNode3.position
                self.addChild(explosion!)
                
                lifeObj3.isHidden = true
                coinObj.removeAllChildren()
                bigCoinObj.removeAllChildren()
                groundObj.removeAllChildren()
                movingObj.removeAllChildren()
                lifeObj1.removeAllChildren()
                lifeObj2.removeAllChildren()
                lifeObj3.removeAllChildren()
                scoreObj.removeAllChildren()
                
                self.run(SKAction.wait(forDuration: 0.8)) {
                    explosion?.removeFromParent()
                }
                
                stopGameObject()
                gameOver = 1
                
                timerAddCoin.invalidate()
                timerAddBigCoin.invalidate()
                timerAddRap.invalidate()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.scene?.isPaused = true
                    self.batObj.removeAllChildren()
                    self.blureBg()
                    self.showRecordLable()
                    
                    if Model.sharedInstance.score > Model.sharedInstance.record {
                        Model.sharedInstance.record = Model.sharedInstance.score
                    }
                    
                    Model.sharedInstance.totalScore = Model.sharedInstance.totalScore + Model.sharedInstance.score
                    
                    self.gameViewController.replayButton.isHidden = false
                    self.gameViewController.menuButton.isHidden = false
                    self.gameViewController.gameOverLabel.isHidden = false
                    self.recordLable.isHidden = false
                    self.recordLable.text = "Your record: \(Model.sharedInstance.record)"
                }
            }
        }
        
        if contact.bodyA.categoryBitMask == coinCategory || contact.bodyB.categoryBitMask == coinCategory {
            let coinNode = contact.bodyA.categoryBitMask == coinCategory ? contact.bodyA.node : contact.bodyB.node
            
            if Model.sharedInstance.sound == true {
                run(takeCoinPreload)
            }
            
            coinNode?.removeFromParent()
            
            Model.sharedInstance.score += 5
            scoreLabel.text = "Score: \(Model.sharedInstance.score) "
        }
        
        if contact.bodyA.categoryBitMask == bigCoinCategory || contact.bodyB.categoryBitMask == bigCoinCategory {
            let bigCoinNode = contact.bodyA.categoryBitMask == bigCoinCategory ? contact.bodyA.node : contact.bodyB.node
            
            if Model.sharedInstance.sound == true {
                run(takeCoinPreload)
            }
            
            bigCoinNode?.removeFromParent()
            setupDoublingLable()
            
            Model.sharedInstance.score += 10
            scoreLabel.text = "Score: \(Model.sharedInstance.score)"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.doublingLableObj.removeAllChildren()
            }
        }
        UserDefaults.standard.set(Model.sharedInstance.totalScore, forKey: "totalPoint")
    }
}

