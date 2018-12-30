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
    
    var fireBall: SKSpriteNode!
    var isDropping = false
    
    override func didMove(to view: SKView) {

        fireBall = childNode(withName: "FireBall") as? SKSpriteNode
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDropping {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let whereToTouched = nodes(at: touchLocation)
                
                fireBall.position.x = touchLocation.x
                
                if !whereToTouched.isEmpty {
                    
                    if whereToTouched[0] as? SKSpriteNode == fireBall {
                        print("dropped")
                        physicsWorld.gravity = CGVector(dx: 0, dy: -20)
                        isDropping = true
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDropping {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                fireBall.position.x = touchLocation.x
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if fireBall.position.y <= -571.8589477539062 {
            fireBall.position.y = 540
            fireBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            fireBall.physicsBody?.angularVelocity = 0
            fireBall.zRotation = 0
            isDropping = false
            physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        }
    }
}
