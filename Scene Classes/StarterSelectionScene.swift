//
//  LevelSelectionScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/23/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class StarterSelectionScene: SKScene {
    
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
                    case "level1_1" : scene = Level1_1Scene(fileNamed: "LevelScene")
                    case "level1_2" : scene = Level1_2Scene(fileNamed: "LevelScene")
                    case "level1_3" : scene = Level1_3Scene(fileNamed: "LevelScene")
                    case "level1_4" : scene = Level1_4Scene(fileNamed: "LevelScene")
                    case "level1_5" : scene = Level1_5Scene(fileNamed: "LevelScene")
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
