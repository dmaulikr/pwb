//
//  Level1_1Scene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/21/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//
//  I gotta make one of these files with a .sks for each level I want in the game??????

import SpriteKit

class Level1_1Scene: BaseLevelScene {
    
    override func didMove(to view: SKView)
    {
        super.initLevel(fromLevel: constructSolvableTestLevel()!)
        super.didMove(to: view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        for touch in touches
        {
            let location = touch.location(in: self)
            if atPoint(location).name == "back"
            {
                if let scene = MainMenuScene(fileNamed: "MainMenu")
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
}
