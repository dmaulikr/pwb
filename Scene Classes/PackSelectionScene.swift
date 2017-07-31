//
//  PackSelectionScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/27/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class PackSelectionScene: SKScene {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            let nodeName = atPoint(location).name
            if nodeName == "starter"
            {
                if let scene = StarterSelectionScene(fileNamed: "StarterSelection")
                {
                    scene.scaleMode = .resizeFill
                    scene.backgroundColor = UIColor.white
                    view!.presentScene(scene, transition: SKTransition.moveIn(with: SKTransitionDirection.down, duration: TimeInterval(0.55)))
                }
            }
            else if nodeName == "tutorial"
            {
                if let scene = TrainingScene(fileNamed: "Training1")
                {
                    scene.setCurrentScene(index: 1)
                    scene.scaleMode = .resizeFill
                    scene.backgroundColor = UIColor.white
                    view!.presentScene(scene, transition: SKTransition.moveIn(with: SKTransitionDirection.down, duration: TimeInterval(0.55)))
                }
            }
            else if nodeName == "back"
            {
                if let scene = SKScene(fileNamed: "MainMenu")
                {
                    scene.scaleMode = .resizeFill
                    scene.backgroundColor = UIColor(hue: 0.5222, saturation: 1, brightness: 0.97, alpha: 1)
                    view!.presentScene(scene, transition: SKTransition.push(with: SKTransitionDirection.right, duration: TimeInterval(0.85)))
                }
            }
            
        }
    }
}   // class
