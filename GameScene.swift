//
//  GameScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/12/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit
// import GameplayKit

class GameScene: SKScene {
    
    private var levelLabel : SKLabelNode?
    private var game: PWBLevel!
    private var allBits: [SKLabelNode] = []
    
    
    override func didMove(to view: SKView) {
        
        if let loadgame = constructTestLevel()
        {
            game = loadgame
            game.start()
            
            // construct inner rectangle where problem will be displayed
            var rect = SKShapeNode(rectOf: CGSize(width: self.size.width * 0.75, height: self.size.height * 0.5))
            levelLabel = SKLabelNode(fontNamed: "Helvetica Neue UltraLight")
            levelLabel?.text = game.levelName
            levelLabel?.fontSize = 50
            levelLabel?.fontColor = SKColor.black
            levelLabel?.position = CGPoint(x: frame.midX, y: frame.maxY * 0.65)
            
            for bit in (game.state?.currentState)!
            {
                allBits.append(SKLabelNode(text: bit.toStr()))
            }
            
            let rectHeightSlice = rect.frame.size.height * CGFloat(0.5)
            let offset = 0.9

            allBits[0].position = CGPoint(x: rect.frame.midX, y: (rect.frame.midY + rectHeightSlice) * CGFloat(offset))
            allBits[0].position = CGPoint(x: rect.frame.midX, y: (rect.frame.midY - rectHeightSlice) * CGFloat(offset))
            
            for i in 0..<allBits.count
            {
                allBits[i].fontColor = SKColor.black
                allBits[i].fontSize = 90
                allBits[i].fontName = "Helvetica Neue Thin"
                self.addChild(allBits[i])
            }
            
            self.addChild(levelLabel!)
            
            rect = SKShapeNode(rectOf: CGSize(width: allBits[0].frame.size.width * CGFloat(1.1), height: self.size.height * 0.5), cornerRadius: CGFloat(3))
            rect.fillColor = .clear
            rect.lineWidth = 1
            rect.strokeColor = .black
            rect.position = CGPoint(x: frame.midX , y: frame.midY)
            self.addChild(rect)
            
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
