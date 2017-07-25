//
//  Level1_1Scene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/21/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.

import SpriteKit

class Level1_1Scene: BaseLevelScene {
    
    override func didMove(to view: SKView)
    {
        super.initLevel(fromLevel: constructTestLevel1()!)
        // super.initLevel(fromLevel: constructTestLevelWithThreeBits()!)
        super.didMove(to: view)
        // super.addUpArrowOperation(operation: "XOR")
        super.addDownArrowOperation(operation: "ADD")
        // super.addLeftArrowOperation(operation: "AND")
        super.addRightArrowOperation(operation: "OR")
        // self.addMarkings()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            if atPoint(location).name == "back"
            {
                if let scene = LevelSelectionScene(fileNamed: "LevelSelection")
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // back and restart nodes will be moved into the base level scene class
        // while the "next level" node will be moved into each level class because not all levels have "continue" available aka last level
        super.touchesBegan(touches, with: event)
    }
} // class
