//
//  GameScene.swift
//  Burn The Preist Already
//
//  Created by Sahand Raeisi on 12/30/18.
//  Copyright © 2018 Sahand Raeisi. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CategoryMask {
    static let fireBallMask:UInt32 = 0x1
    static let firstPriest:UInt32 = 0x1 << 1 //bits shifting
    static let secondPriest:UInt32 = 0x1 << 2
    static let thirdPriest:UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    var fireBall: SKSpriteNode!
    var firstPriest: SKSpriteNode!
    var secondPriest: SKSpriteNode!
    var thirdPriest: SKSpriteNode!
    
    var isDropping = false
    
    override func didMove(to view: SKView) {

        fireBall = childNode(withName: "FireBall") as? SKSpriteNode
        firstPriest = childNode(withName: "FirstPriest") as? SKSpriteNode
        secondPriest = childNode(withName: "SecondPriest") as? SKSpriteNode
        thirdPriest = childNode(withName: "ThirdPriest") as? SKSpriteNode
        
        fireBall.physicsBody?.categoryBitMask = CategoryMask.fireBallMask
        firstPriest.physicsBody?.categoryBitMask = CategoryMask.firstPriest
        secondPriest.physicsBody?.categoryBitMask = CategoryMask.secondPriest
        thirdPriest.physicsBody?.categoryBitMask = CategoryMask.thirdPriest
        
        fireBall.physicsBody?.contactTestBitMask = CategoryMask.firstPriest | CategoryMask.secondPriest | CategoryMask.thirdPriest
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
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
        
        if fireBall.position.y <= -571 {
            physicsWorld.gravity = CGVector(dx: 0, dy: 0)
            fireBall.position.y = 540
            fireBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            fireBall.physicsBody?.angularVelocity = 0
            fireBall.zRotation = 0
            isDropping = false
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        var bodyOneId: UInt32!
        var bodyTwoId: UInt32!
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyOneId = contact.bodyA.categoryBitMask
            bodyTwoId = contact.bodyB.categoryBitMask
        } else {
            bodyOneId = contact.bodyB.categoryBitMask
            bodyTwoId = contact.bodyA.categoryBitMask
        }
        
        if bodyOneId == CategoryMask.fireBallMask {
            if bodyTwoId == CategoryMask.firstPriest {
                firstPriest.removeFromParent()
            } else if bodyTwoId == CategoryMask.secondPriest {
                secondPriest.removeFromParent()
            } else if bodyTwoId == CategoryMask.thirdPriest {
                thirdPriest.removeFromParent()
            }
        }
    }   
}
