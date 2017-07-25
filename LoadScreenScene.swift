//
//  LoadingScreenScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/24/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import SpriteKit

class LoadScreenScene: SKScene {
    
    var bitLoading = BitWrapper(fromNum: 0)
    let bitNode = SKLabelNode(fontNamed: Constants.problemFont)
    let numNode = SKLabelNode(fontNamed: Constants.displayFont)
    var currentNum = 0
    
    override func didMove(to view: SKView)
    {
        // super.didMove(to: view)
        // let bitNode = SKLabelNode(fontNamed: Constants.displayFont)
        bitNode.fontColor = SKColor.black
        bitNode.fontSize = 50
        bitNode.position = CGPoint(x: 0, y: 0)
        
       // let numNode = SKLabelNode(fontNamed: Constants.displayFont)
        numNode.fontColor = SKColor.black
        numNode.fontSize = 50
        numNode.position = CGPoint(x: 0, y: 0)
        numNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        
        self.addChild(bitNode)
        self.addChild(numNode)
        
        for i in 0...100
        {
            bitLoading = BitWrapper(fromNum: i)
            bitNode.text = bitLoading.toStr()
            numNode.text = String(bitLoading.toInt())
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        currentNum += 1
        bitLoading = BitWrapper(fromNum: currentNum)
        bitNode.text = bitLoading.toStr()
        numNode.text = String(bitLoading.toInt()) + "%"
        
        if currentNum == 100
        {
            if let scene = MainMenuScene(fileNamed: "MainMenu")
            {
                scene.scaleMode = .resizeFill
                scene.backgroundColor = UIColor.white
                view!.presentScene(scene, transition: SKTransition.fade(with: SKColor.white, duration: TimeInterval(2)))
            }
        }
        
    }
    
    
    
}   // class
