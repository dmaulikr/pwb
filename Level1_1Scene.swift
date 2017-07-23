//
//  Level1_1Scene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/21/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class Level1_1Scene: BaseLevelScene {
    
    override func didMove(to view: SKView)
    {
        super.initLevel(fromLevel: constructTestLevel1()!)
        super.didMove(to: view)
        self.addMarkings()
    }
    
    private func addMarkings()
    {
        let rect = super.problemContainer.frame
        
        let botArrow = SKSpriteNode(imageNamed: "PWBArrow")
        botArrow.zRotation = Constants.rotate45degClock
        botArrow.position = CGPoint(x: rect.maxX - CGFloat(2), y: rect.minY * CGFloat(1.35))
        botArrow.size = CGSize(width: CGFloat(50), height: CGFloat(11))
        
        let rightArrow = SKSpriteNode(imageNamed: "PWBArrow")
        rightArrow.position = CGPoint(x: rect.maxX * CGFloat(1.35), y: rect.maxY - CGFloat(2))
        rightArrow.size = CGSize(width: CGFloat(50), height: CGFloat(11))
        
        super.addChild(botArrow)
        super.addChild(rightArrow)
        
        let botOp = SKLabelNode(fontNamed: Constants.problemFont)
        botOp.fontSize = 25
        botOp.fontColor = SKColor.darkGray
        botOp.text = "ADD"
        botOp.position = CGPoint(x: botArrow.frame.maxX + CGFloat(2), y: botArrow.frame.midY)
        botOp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        botOp.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        let rightOp = SKLabelNode(fontNamed: Constants.problemFont)
        rightOp.fontSize = 25
        rightOp.fontColor = SKColor.darkGray
        rightOp.text = "OR"
        rightOp.position = CGPoint(x: rightArrow.frame.midX, y: rightArrow.frame.maxY + CGFloat(2))
        
        super.addChild(botOp)
        super.addChild(rightOp)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        for touch in touches
        {
            let location = touch.location(in: self)
            if atPoint(location).name == "back"
            {
                if let scene = MainMenuScene(fileNamed: "MainMenu")
                {
                    scene.scaleMode = .resizeFill
                    scene.backgroundColor = UIColor.white
                    view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.down, duration: TimeInterval(0.85)))
                }
            }
            else if atPoint(location).name == "restart"
            {
                super.restartGame()
            }
            else if atPoint(location).name == "continue"
            {
                if let scene = Level1_2Scene(fileNamed: "LevelScene")
                {
                    scene.scaleMode = .resizeFill
                    scene.backgroundColor = UIColor.white
                    view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: TimeInterval(0.85)))
                }
            }
        }
    }
} // class
