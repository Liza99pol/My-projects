//
//  GameScene_Touches.swift
//  GameBat
//
//  Created by macbook m1 on 24.07.23.
//

import Foundation
import SpriteKit

extension GameScene {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameOver == 0 {
            bat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 11))
        }
    }
}
