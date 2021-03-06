//
//  Level1_2Scene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/23/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class Level1_2Scene: BaseLevelScene {
    
    override func didMove(to view: SKView)
    {
        super.initLevel(fromLevel: constructStarter2()!)
        super.didMove(to: view)
        super.addDownArrowOperation(operation: "ADD")
        super.addUpArrowOperation(operation: "OR")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            if atPoint(location).name == "back"
            {
                if let scene = StarterSelectionScene(fileNamed: "StarterSelection")
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
                if let scene = Level1_3Scene(fileNamed: "LevelScene") // need to impleement
                {
                    scene.scaleMode = .resizeFill
                    scene.backgroundColor = UIColor.white
                    view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: TimeInterval(0.85)))
                }
            }
        }
    }
}   // class
