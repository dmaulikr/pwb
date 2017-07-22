//
//  PWBLevelMaker.swift
//  PWB
//
//  Created by Nicholas Wei on 7/19/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import Foundation


func constructTestLevelWithTwoBits() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "101000", alreadyBinary: true),
        "right" : BitWrapper(fromString: "10", alreadyBinary: true),
        "top" : BitWrapper(fromString: "111100", alreadyBinary: true),
        "left" : BitWrapper(fromString: "01", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add"
    ]
    
    let name = "PWB_Test_Level_1"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "100000", alreadyBinary: true),
        BitWrapper(fromString: "010000", alreadyBinary: true)
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

func constructTestLevelWithThreeBits() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "101000", alreadyBinary: true),
        "right" : BitWrapper(fromString: "10", alreadyBinary: true),
        "top" : BitWrapper(fromString: "111100", alreadyBinary: true),
        "left" : BitWrapper(fromString: "01", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add"
    ]
    
    let name = "PWB_Test_Level_1"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "100000", alreadyBinary: true),
        BitWrapper(fromString: "010000", alreadyBinary: true),
        BitWrapper(fromString: "101010", alreadyBinary: true)
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

func constructTestLevelSmall() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "1010", alreadyBinary: true),
        "right" : BitWrapper(fromString: "10", alreadyBinary: true),
        "top" : BitWrapper(fromString: "1110", alreadyBinary: true),
        "left" : BitWrapper(fromString: "01", alreadyBinary: true)
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

func constructSolvableTestLevel() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "1010", alreadyBinary: true),
        "right" : BitWrapper(fromString: "10", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add",
        "right" : "or"
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















