//
//  PWBLevelMaker.swift
//  PWB
//
//  Created by Nicholas Wei on 7/19/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import Foundation


func constructTestLevel() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "1010", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add"
    ]
    
    let name = "PWB_Test_Level_1"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "1000", alreadyBinary: true),
        BitWrapper(fromString: "0100", alreadyBinary: true)
    ]
    
    do
    {
        try game = PWBLevel(withName: name, startFrom: startFrom, endWith: goal, withOperations: ops)
    } catch
    {
        print("Could not construct /(name)")
    }
    return game
}
