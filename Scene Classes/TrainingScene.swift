//
//  TrainingScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/28/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class TrainingScene: SKScene {
    
    var prefix = "Training"
    
    var currentScene = 0
    
    
    func setCurrentScene(index: Int)
    {
        currentScene = index
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
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
                if prevScene > 0
                {
                    let prevSceneName = prefix + String(prevScene)
                    if let scene = TrainingScene(fileNamed: prevSceneName)
                    {
                        scene.setCurrentScene(index: prevScene)
                        // scene.scaleMode = .resizeFill
                        scene.backgroundColor = UIColor.white
                        // let fadeTransition = SKTransition.fade(with: SKColor.white, duration: TimeInterval(0.5))
                        // view!.presentScene(scene, transition: fadeTransition)
                        self.scene?.view?.presentScene(scene)
                        // view!.presentScene(scene, transition: SKTransition.moveIn(with: SKTransitionDirection.left, duration: TimeInterval(0.85)))
                    }
                }
            }
            else
            {
                let nextScene = currentScene + 1
                    if nextScene <= 10
                    {
                        let nextSceneName = prefix + String(nextScene)
                        if let scene = TrainingScene(fileNamed: nextSceneName)
                        {
                            scene.setCurrentScene(index: nextScene)
                           // scene.scaleMode = .resizeFill
                            scene.backgroundColor = UIColor.white
                            // let fadeTransition = SKTransition.fade(with: SKColor.white, duration: TimeInterval(0.5))
                            self.scene?.view?.presentScene(scene)
                            // view!.presentScene(scene, transition: fadeTransition)
                            // view!.presentScene(scene, transition: SKTransition.moveIn(with: SKTransitionDirection.right, duration: TimeInterval(0.85)))
                        }
                }
            }
            
        }
    }
    
    // deinit{ print("TrainingScene\(currentScene) deinit") }

}   // class
