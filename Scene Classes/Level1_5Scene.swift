//
//  Level1_5Scene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/29/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class Level1_5Scene: BaseLevelScene {
    
    override func didMove(to view: SKView)
    {
        super.initLevel(fromLevel: constructStarter5()!)
        super.didMove(to: view)
        super.addUpArrowOperation(operation: "ADD")
        super.addRightArrowOperation(operation: "AND")
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
        }
    }
}   // class
