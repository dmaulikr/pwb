//
//  MainMenuScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/22/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches
//        {
//            let location = touch.location(in: self)
//            if atPoint(location).name == "Play"
//            {
//                if let scene = SKScene(fileNamed: "TestLevelScene")
//                {
//                    scene.scaleMode = .resizeFill
//                    view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: TimeInterval(1)))
//                }
//            }
//        }
        if let scene = Level1_1Scene(fileNamed: "LevelScene")
        {
            scene.scaleMode = .resizeFill
            scene.backgroundColor = UIColor.white
            view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: TimeInterval(1))) // chain this with bg iamge
        }
    }
}   // class
