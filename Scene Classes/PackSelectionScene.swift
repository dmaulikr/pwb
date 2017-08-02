//
//  PackSelectionScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/27/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class PackSelectionScene: SKScene {

    let starterLevels = ["Starter - 1", "Starter - 2", "Starter - 3", "Starter - 4", "Starter - 5"]
    private var empiricalUnlocked = false
    
    private func checkEmpirical()
    {
        guard let empUnlock = SwiftyPlistManager.shared.fetchValue(for: "empiricalUnlocked", fromPlistWithName: "PWBData") else {return}
        if (empUnlock as! Bool)
        {
            empiricalUnlocked = true
            return
        }
        var numCompleted = 0
        for levelName in starterLevels
        {
            guard let completion = SwiftyPlistManager.shared.fetchValue(for: levelName, fromPlistWithName: "PWBData") else {return}
            if completion as! String == "completed"
            {
                numCompleted += 1
            }
        }
        if numCompleted == starterLevels.count
        {
            SwiftyPlistManager.shared.save(true, forKey: "empiricalUnlocked", toPlistWithName: "PWBData") { (err) in
                if err == nil
                {
                    print("Empirical Unlocked")
                }
            }
            empiricalUnlocked = true
        }
    }
    
    func checkUnlocks()
    {
        self.checkEmpirical()
        if empiricalUnlocked
        {
            let label = childNode(withName: "empiricalLabel") as! SKLabelNode
            label.text = "Empirical"
            label.fontColor = SKColor.black
            
            let labelBox = childNode(withName: "empirical") as! SKShapeNode
            labelBox.strokeColor = SKColor.black
        }
    }

    
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
            else if (nodeName == "empirical" || nodeName == "empiricalLabel") && empiricalUnlocked
            {
                if let scene = EmpiricalSelectionScene(fileNamed: "EmpiricalSelection")
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
