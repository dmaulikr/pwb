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
        super.initLevel(fromLevel: constructTestLevelSmall()!)
        super.didMove(to: view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
    }
}
