//
//  GameScene.swift
//  CoinCollector
//
//  Created by Kenneth Nagata on 5/28/18.
//  Copyright © 2018 Kenneth Nagata. All rights reserved.
// <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    

    var coinMan : SKSpriteNode?
    var spawnCoinTimer : Timer?
    var ground: SKSpriteNode?
    var ceil: SKSpriteNode?
    
    let coinManCategory : UInt32 = 0x1 << 1
    let coinCategory : UInt32 = 0x1 << 2
    let bombCategory : UInt32 = 0x1 << 3
    let groundAndCeilCategory: UInt32 = 0x1 << 4
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        coinMan = childNode(withName: "coinMan") as? SKSpriteNode
        coinMan?.physicsBody?.categoryBitMask = coinManCategory
        coinMan?.physicsBody?.contactTestBitMask = coinCategory | bombCategory
        coinMan?.physicsBody?.collisionBitMask = groundAndCeilCategory
        
        
        ground = childNode(withName: "ground") as? SKSpriteNode
        ground?.physicsBody?.categoryBitMask = groundAndCeilCategory
        ground?.physicsBody?.collisionBitMask = coinManCategory
        
        ceil = childNode(withName: "ceil") as? SKSpriteNode
        ceil?.physicsBody?.categoryBitMask = groundAndCeilCategory
        ceil?.physicsBody?.collisionBitMask = coinManCategory
        
        spawnCoinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.createCoin()
        })
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        coinMan?.physicsBody?.applyForce(CGVector(dx: 0, dy: 100_000))
    }
    
    func createCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = coinManCategory
        coin.physicsBody?.collisionBitMask = 0
        
        addChild(coin)

        let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        let maxY = size.height / 2 - coin.size.height / 2
        let minY = -size.height / 2 + coin.size.height / 2
        let range = maxY - minY
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        coin.position = CGPoint(x: self.size.width / 2 + coin.size.width / 2, y: coinY)
        coin.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
    }
}
