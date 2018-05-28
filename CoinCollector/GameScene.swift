//
//  GameScene.swift
//  CoinCollector
//
//  Created by Kenneth Nagata on 5/28/18.
//  Copyright © 2018 Kenneth Nagata. All rights reserved.
// <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    var coinMan : SKSpriteNode?
    var spawnCoinTimer : Timer?
    
    override func didMove(to view: SKView) {
        
        coinMan = childNode(withName: "coinMan") as? SKSpriteNode
        createCoin()
        
        spawnCoinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.createCoin()
        })
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        coinMan?.physicsBody?.applyForce(CGVector(dx: 0, dy: 100_000))
    }
    
    func createCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        let maxY = size.height / 2 - coin.size.height / 2
        let minY = -size.height / 2 + coin.size.height / 2
        let range = maxY - minY
        
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        addChild(coin)
        
        coin.position = CGPoint(x: self.size.width / 2 + coin.size.width / 2, y: coinY)
        
        coin.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
        
    }
    
}
