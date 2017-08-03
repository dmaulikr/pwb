//
//  EmpiricalSelectionScene.swift
//  PWB
//
//  Created by Nicholas Wei on 8/1/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class EmpiricalSelectionScene: SKScene {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            if let nodeName = atPoint(location).name
            {
                if nodeName == "back"
                {
                    if let scene = PackSelectionScene(fileNamed: "LevelPack")
                    {
                        scene.checkUnlocks()
                        scene.scaleMode = .resizeFill
                        scene.backgroundColor = UIColor.white
                        view!.presentScene(scene, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: TimeInterval(0.85)))
                    }
                }
                else
                {
                    var scene: BaseLevelScene?
                    switch nodeName
                    {
                    case "level2_1" : scene = Level2_1Scene(fileNamed: "LevelScene")
                    case "level2_2" : scene = Level2_2Scene(fileNamed: "LevelScene")
                    case "level2_3" : scene = Level2_3Scene(fileNamed: "LevelScene")
                    case "level2_4" : scene = Level2_4Scene(fileNamed: "LevelScene")
                    case "level2_5" : scene = Level2_5Scene(fileNamed: "LevelScene")
                    default : ()
                    }
                    
                    if let level = scene
                    {
                        level.scaleMode = .resizeFill
                        level.backgroundColor = UIColor.white
                        view!.presentScene(level, transition: SKTransition.push(with: SKTransitionDirection.up, duration: TimeInterval(0.85)))
                    }
                }
            }
        }
    }
}   // class
