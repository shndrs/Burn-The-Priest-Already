//
//  GameScene.swift
//  Burn The Preist Already
//
//  Created by Sahand Raeisi on 12/30/18.
//  Copyright © 2018 Sahand Raeisi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var fireBall:SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        fireBall = childNode(withName: "FireBall") as? SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
