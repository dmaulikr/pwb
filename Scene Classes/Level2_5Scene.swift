//
//  Level2_5Scene.swift
//  PWB
//
//  Created by Nicholas Wei on 8/3/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class Level2_5Scene: BaseLevelScene {
    
    override func didMove(to view: SKView)
    {
        super.initLevel(fromLevel: constructEmpirical5()!)
        super.didMove(to: view)
        super.addDownArrowOperation(operation: "OR")
        super.addLeftArrowOperation(operation: "XOR")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            if atPoint(location).name == "back" || atPoint(location).name == "continue"
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
        }
    }
    
} // class
