//
//  Level2_3Scene.swift
//  PWB
//
//  Created by Nicholas Wei on 8/3/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class Level2_3Scene: BaseLevelScene {
    
    override func didMove(to view: SKView)
    {
        super.initLevel(fromLevel: constructEmpirical3()!)
        super.didMove(to: view)
        super.addDownArrowOperation(operation: "ADD")
        super.addRightArrowOperation(operation: "ADD")
        super.addLeftArrowOperation(operation: "OR")
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
                if let scene = EmpiricalSelectionScene(fileNamed: "EmpiricalSelection")
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
                if let scene = Level2_4Scene(fileNamed: "LevelScene")
                {
                    scene.scaleMode = .resizeFill
                    scene.backgroundColor = UIColor.white
                    view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: TimeInterval(0.85)))
                }
            }
        }
    }

} // class
