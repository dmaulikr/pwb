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
    
    let name = "PWB_Test_Level_With_Two_Bits"
    
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
        "right" : BitWrapper(fromString: "101", alreadyBinary: true),
        "top" : BitWrapper(fromString: "111100", alreadyBinary: true),
        "left" : BitWrapper(fromString: "010", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add"
    ]
    
    let name = "PWB_Test_Level__With_Three_Bits"
    
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
        "right" : BitWrapper(fromString: "10", alreadyBinary: true)
        // "top" : BitWrapper(fromString: "1110", alreadyBinary: true),
        // "left" : BitWrapper(fromString: "01", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add"
    ]
    
    let name = "Test Level"
    
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

func constructStarter1() -> PWBLevel?
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
    
    let name = "Starter - 1"
    
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

func constructStarter2() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "1010", alreadyBinary: true),
        "top" : BitWrapper(fromString: "0101", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add",
        "up" : "or"
    ]
    
    let name = "Starter - 2"
    
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

func constructStarter3() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "right" : BitWrapper(fromString: "10", alreadyBinary: true),
        "left" : BitWrapper(fromString: "10", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "right" : "xor",
        "left" : "and"
    ]
    
    let name = "Starter - 3"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "1010", alreadyBinary: true),
        BitWrapper(fromString: "0101", alreadyBinary: true)
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

func constructStarter4() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "top" : BitWrapper(fromString: "1010", alreadyBinary: true),
        "left" : BitWrapper(fromString: "11", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "up" : "xor",
        "left" : "or"
    ]
    
    let name = "Starter - 4"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "1111", alreadyBinary: true),
        BitWrapper(fromString: "0000", alreadyBinary: true)
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

func constructStarter5() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "top" : BitWrapper(fromString: "10000", alreadyBinary: true),
        "right" : BitWrapper(fromString: "10", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "up" : "add",
        "right" : "and"
    ]
    
    let name = "Starter - 5"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "1001", alreadyBinary: true),
        BitWrapper(fromString: "0000", alreadyBinary: true)
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












