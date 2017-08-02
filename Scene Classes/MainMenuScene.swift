//
//  MainMenuScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/22/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    func segue()
    {
        if let scene = PackSelectionScene(fileNamed: "LevelPack")
        {
            scene.checkUnlocks()
            scene.scaleMode = .resizeFill
            scene.backgroundColor = UIColor.white
            view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.left, duration: TimeInterval(0.85)))
            // view!.presentScene(scene, transition: SKTransition.moveIn(with: SKTransitionDirection.down, duration: TimeInterval(1)))
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            if atPoint(location).name == "play"
            {
                self.segue()
            }
            
        }
//        if let scene = Level1_1Scene(fileNamed: "LevelScene")
//        {
//            scene.scaleMode = .resizeFill
//            scene.backgroundColor = UIColor.white
//            view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: TimeInterval(1))) // chain this with bg iamge
//        }
    }
}   // class
