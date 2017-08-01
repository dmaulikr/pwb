//
//  PWBLevelMaker.swift
//  PWB
//
//  Created by Nicholas Wei on 7/19/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//
//  Will reformat this later (one function to make the game that takes a struct with info as argument)

import Foundation

// Starter Pack

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

// Empirical Pack

func constructEmpirical1() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "1111", alreadyBinary: true),
        "right" : BitWrapper(fromString: "001", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add",
        "right" : "xor"
    ]
    
    let name = "Empirical - 1"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "1000", alreadyBinary: true),
        BitWrapper(fromString: "0100", alreadyBinary: true),
        BitWrapper(fromString: "0010", alreadyBinary: true)
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

func constructEmpirical2() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "100100", alreadyBinary: true),
        "right" : BitWrapper(fromString: "00", alreadyBinary: true),
        "left" : BitWrapper(fromString: "11", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add",
        "right" : "and",
        "left" : "xor"
    ]
    
    let name = "Empirical - 2"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "101010", alreadyBinary: true),
        BitWrapper(fromString: "010101", alreadyBinary: true)
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

func constructEmpirical3() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "0011", alreadyBinary: true),
        "right" : BitWrapper(fromString: "111", alreadyBinary: true),
        "left" : BitWrapper(fromString: "111", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "add",
        "right" : "add",
        "left" : "or"
    ]
    
    let name = "Empirical - 3"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "0000", alreadyBinary: true),
        BitWrapper(fromString: "0000", alreadyBinary: true),
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

func constructEmpirical4() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "0000", alreadyBinary: true),
        "right" : BitWrapper(fromString: "101", alreadyBinary: true),
        "left" : BitWrapper(fromString: "111", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "and",
        "right" : "xor",
        "left" : "or"
    ]
    
    let name = "Empirical - 4"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "0010", alreadyBinary: true),
        BitWrapper(fromString: "0000", alreadyBinary: true),
        BitWrapper(fromString: "1000", alreadyBinary: true)
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

func constructEmpirical5() -> PWBLevel?
{
    var game: PWBLevel?
    
    let goal: EndState = [
        "bot" : BitWrapper(fromString: "111111", alreadyBinary: true),
        "left" : BitWrapper(fromString: "00", alreadyBinary: true)
    ]
    
    let ops: DirectionOfOperations = [
        "down" : "or",
        "left" : "xor"
    ]
    
    let name = "Empirical - 5"
    
    let startFrom: [BitWrapper] = [
        BitWrapper(fromString: "101010", alreadyBinary: true),
        BitWrapper(fromString: "010101", alreadyBinary: true)
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







