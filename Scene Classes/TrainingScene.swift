//
//  TrainingScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/28/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class TrainingScene: SKScene {
    
    var currentScene = 0
    
    lazy var scenes: [TrainingScene?] = [
        TrainingScene(fileNamed: "Training1"),
        TrainingScene(fileNamed: "Training2"),
        TrainingScene(fileNamed: "Training3"),
        TrainingScene(fileNamed: "Training4"),
        TrainingScene(fileNamed: "Training5"),
        TrainingScene(fileNamed: "Training6"),
        TrainingScene(fileNamed: "Training7"),
        TrainingScene(fileNamed: "Training8"),
        TrainingScene(fileNamed: "Training9")
    ]
    
    func setCurrentScene(index: Int)
    {
        currentScene = index
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            let nodeName = atPoint(location).name
            if nodeName == "return"
            {
                if let scene = PackSelectionScene(fileNamed: "LevelPack")
                {
                    scene.scaleMode = .resizeFill
                    scene.backgroundColor = UIColor.white
                    view!.presentScene(scene, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: TimeInterval(0.85)))
                }
            }
            else if nodeName == "back"
            {
                let prevScene = currentScene - 1
                if prevScene >= 0
                {
                    if let scene = scenes[prevScene]
                    {
                        scene.setCurrentScene(index: prevScene)
                        scene.scaleMode = .resizeFill
                        scene.backgroundColor = UIColor.white
                        view!.presentScene(scene, transition: SKTransition.fade(with: SKColor.white, duration: TimeInterval(0.85)))
                    }
                }
            }
            else
            {
                let nextScene = currentScene + 1
                    if nextScene < scenes.count
                    {
                        if let scene = scenes[nextScene]
                        {
                            scene.setCurrentScene(index: nextScene)
                            scene.scaleMode = .resizeFill
                            scene.backgroundColor = UIColor.white
                            view!.presentScene(scene, transition: SKTransition.fade(with: SKColor.white, duration: TimeInterval(0.85)))
                        }
                }
            }
            
        }
    }

}   // class
