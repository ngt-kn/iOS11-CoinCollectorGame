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
    
    override func didMove(to view: SKView) {
        
        coinMan = childNode(withName: "coinMan") as? SKSpriteNode
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        coinMan?.physicsBody?.applyForce(CGVector(dx: 0, dy: 100_000))
    }
    
    func createCoin() {
        
    }
    
}
