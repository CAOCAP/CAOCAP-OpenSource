//
//  SpaceScene.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 16/08/2024.
//

import SpriteKit

class SpaceScene: SKScene {

    override func didMove(to view: SKView) {
        setupSpaceParticales()
    }
    
    func setupSpaceParticales() {
        if let particales = SKEmitterNode(fileNamed: "Space") {
            particales.position = CGPoint(x: 1000, y: 0)
            particales.advanceSimulationTime(60)
            particales.zPosition = -1
            addChild(particales)
        }
    }
    
}
