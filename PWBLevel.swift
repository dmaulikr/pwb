//
//  PWBLevel.swift
//  PWB
//
//  Created by Nicholas Wei on 7/13/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//
//  TODO:
//  - cleanup viewing, some var names too...
//  - implement move restrictions(?)

import Foundation

enum PWBLevelError: Error
{
    case invalidInit(reason: String)
}

typealias EndState = Dictionary<String, BitWrapper> // Dictionary must use the keywords: "top", "bot", "left", "right"
typealias DirectionOfOperations = Dictionary<String, String> // Dictionary will map <direction, operation-name> ex. <"up", "and">, <"down", "or">; indicates the operation to be performed
typealias BinaryOperation = (BitWrapper, BitWrapper) -> BitWrapper // operations that operate on the up/down orientation; they deal with rows of bitwrappers hence binary
typealias UnaryOperation = (BitWrapper) -> BitWrapper   // operations that operate on the right/left orientation; they deal with singular bitwrappers hence unary

class PWBLevel  // represents a "level" in the game, utilizes BitWrapper
{
    private let name: String!
    private let startState: [BitWrapper]!
    private var currentState: [BitWrapper]!
    private var finishState: DesiredState!
    private var opDirections: OperationOrientation!
    private var gameState: GameState?
    private var previousGameState: GameState?   // only record the last one, undos are only allowed once, subject to change
    private var undoAvailable: Bool = false
    private var active = false // whether or not the game has started, once set to true, some functions are allowed/restricted
    
    var levelName: String
    {
        return name
    }
    
    var state: GameState?
    {
        if let levelState = gameState
        {
            return levelState
        }
        return nil
    }
    
    var inGame: Bool
    {
        return active
    }
    
    init(withName: String, startFrom: [BitWrapper], endWith: EndState, withOperations: DirectionOfOperations) throws
    {
        name = withName
        startState = startFrom
        currentState = startState
        guard startFrom.count > 1 else {
            throw PWBLevelError.invalidInit(reason: "Must start with at least two BitWrappers in startFrom array")
        }
        guard readDesiredState(endState: endWith) != endWith.count else {
            throw PWBLevelError.invalidInit(reason: "Bad EndState")
        }
        guard readOperationOrientation(withOps: withOperations) != withOperations.count else {
            throw PWBLevelError.invalidInit(reason: "Bad Operation Orientations")
        }
    }
    
    struct GameState    // represents the current state of the game with additional info
    {
        let levelName: String
        let startingState: [BitWrapper]
        let goal: DesiredState
        
        var currentState: [BitWrapper]
        var stateSize: Int    // size of the currentState
        var moves: Int  // total number of "moves" performed
        var completed: Bool
        // let manipulationResult: AnyObject?  // result of any operations performed as a result of the last performManipulation() if applicable
    }
    
    struct DesiredState // represents the goal to the problem, all bits are represented as BitWrappers, there are 4 desired states possible (minimum one required)
    {
        var topState: BitWrapper?
        var bottomState: BitWrapper?
        var rightState: BitWrapper?
        var leftState: BitWrapper?
        
        // var topRightState: BitWrapper?
        // var bottomRightState: BitWrapper?
        // var topLeftState: BitWrapper?
        // var bottomLeftState: BitWrapper?
    }
    
    private struct OperationOrientation
    {
        var up: BinaryOperation?
        var down: BinaryOperation?
        var right: UnaryOperation?
        var left: UnaryOperation?
    }
    
    private func readDesiredState(endState: EndState) -> Int // returns number of "bad" entries in the dictionary
    {
        finishState = DesiredState()
        var faults = 0
        for (orientation, state) in endState
        {
            switch orientation
            {
            case "top": finishState.topState = state
            case "bot": finishState.bottomState = state
            case "right": finishState.rightState = state
            case "left": finishState.leftState = state
                //            case "top-right": finishState.topRightState = state
                //            case "top-left": finishState.topLeftState = state
                //            case "bottom-right": finishState.bottomRightState = state
            //            case "bottom-left": finishState.bottomLeftState = state
            default : faults += 1
            }
        }
        return faults
    }
    
    private func readOperationOrientation(withOps: DirectionOfOperations) -> Int // returns number of bad entries in dictionary
    {
        opDirections = OperationOrientation()
        var faults = 0
        for (orientation, operation) in withOps
        {
            if orientation == "up" || orientation == "down"
            {
                faults += assignBinaryOperation(withOp: operation, withDir: orientation)
            }
            else if orientation == "right" || orientation == "left"
            {
                faults += assignUnaryOperation(withOp: operation, withDir: orientation)
            }
            else
            {
                faults += 1
            }
        }
        return faults
    }
    
    private func assignBinaryOperation(withOp: String, withDir: String) -> Int // returns 1 if fault detected, else 0
    {
        if withDir == "up"
        {
            switch withOp
            {
            case "add" : opDirections.up = BitWrapper.add
            case "or" : opDirections.up = BitWrapper.or
            case "and" : opDirections.up = BitWrapper.and
            case "xor" : opDirections.up = BitWrapper.xor
            default : return 1
            }
        }
        else
        {
            switch withOp
            {
            case "add" : opDirections.down = BitWrapper.add
            case "or" : opDirections.down = BitWrapper.or
            case "and" : opDirections.down = BitWrapper.and
            case "xor" : opDirections.down = BitWrapper.xor
            default : return 1
            }
        }
        return 0
    }
    
    private func assignUnaryOperation(withOp: String, withDir: String) -> Int
    {
        if withDir == "right"
        {
            switch withOp
            {
            case "add" : opDirections.right = BitWrapper.selfAdd
            case "or" : opDirections.right = BitWrapper.selfOr
            case "and" : opDirections.right = BitWrapper.selfAnd
            case "xor" : opDirections.right = BitWrapper.selfOr
            default : return 1
            }
        }
        else
        {
            switch withOp
            {
            case "add" : opDirections.left = BitWrapper.selfAdd
            case "or" : opDirections.left = BitWrapper.selfOr
            case "and" : opDirections.left = BitWrapper.selfAnd
            case "xor" : opDirections.left = BitWrapper.selfOr
            default : return 1
            }
        }
        return 0
    }
    
    func start()    // sets up the game state and allows calls to action(), can also be called to restart the level
    {
        gameState = GameState(levelName: name, startingState: startState, goal: finishState,
                              currentState: startState, stateSize: currentState.count, moves: 0, completed: false)
        active = true
        previousGameState = nil
        undoAvailable = false
    }
    
    func action(rowIndex: Int, action: String, numIndex: Int? = nil) -> GameState? // perform action and update/return game state
    {
        if active
        {
            previousGameState = gameState
            if previousGameState != nil
            {
                undoAvailable = true
            }
            let move = performManipulation(index: rowIndex, manipulation: action, withExtraParam: numIndex)
            updateGameState(moves: move)
        }
        return state
    }
    
    func undo() -> GameState?
    {
        if active && undoAvailable
        {
            gameState = previousGameState
            undoAvailable = false
        }
        return state
    }
    
    private func updateGameState(moves: Int)
    {
        gameState!.currentState = currentState
        gameState!.stateSize = currentState.count
        gameState!.moves += moves
        gameState!.completed = checkCompletion()
        if gameState!.completed
        {
            active = false
        }
    }
    
    private func performManipulation(index: Int, manipulation: String, withExtraParam: Int? = nil) -> Int // handles flip, not, and shifts; returns 1 if successful, 0 if not
    {
        switch manipulation
        {
        case "shift-left" : currentState[index].shiftLeft()
        case "shift-right" : currentState[index].shiftRight()
        case "not" : currentState[index].selfNot()
        case "flip" : if let binaryIndex = withExtraParam {currentState[index].flip(index: binaryIndex)} else {return 0}
        default : return 0
        }
        return 1
    }
    
    private func checkCompletion() -> Bool
    {
        if finishState.topState != nil
        {
            if !checkDirection(direction: "up")
            {
                return false
            }
        }
        if finishState.bottomState != nil
        {
            if !checkDirection(direction: "down")
            {
                return false
            }
        }
        if finishState.rightState != nil
        {
            if !checkDirection(direction: "right")
            {
                return false
            }
        }
        if finishState.leftState != nil
        {
            if !checkDirection(direction: "left")
            {
                return false
            }
        }
        return true // passed all the checks, all states will never be nil at the same time due to checks at init
    }
    
    private func checkDirection(direction: String) -> Bool
    {
        var equals = false
        var bitToCheck: BitWrapper?
        var unaryFunc: UnaryOperation?
        var binaryFunc: BinaryOperation?
        var binary: Bool
        
        switch direction
        {
        case "up" : bitToCheck = finishState.topState; binaryFunc = opDirections.up; binary = true
        case "down" : bitToCheck = finishState.bottomState; binaryFunc = opDirections.down; binary = true
        case "right" : bitToCheck = finishState.rightState; unaryFunc = opDirections.right; binary = false
        case "left" : bitToCheck = finishState.leftState; unaryFunc = opDirections.left; binary = false
        default : return false
        }
        
        if let answer = bitToCheck
        {
            if binary
            {
                if let operation = binaryFunc
                {
                    let initialValue = currentState[0]
                    let computedValue = currentState[1..<currentState.count].reduce(initialValue, operation)
                    
                    // print(computedValue.toStr())
                    equals = BitWrapper.equals(lhs: answer, rhs: computedValue)
                }
            }
            else
            {
                if let operation = unaryFunc
                {
                    var strAnswer = ""
                    for bit in currentState
                    {
                        strAnswer += operation(bit).toStr()
                    }
                    
                    let computedValue = BitWrapper(fromString: strAnswer, alreadyBinary: true)
                    
                    equals = BitWrapper.equals(lhs: answer, rhs: computedValue)
                }
            }
        }
        return equals
    }
    
} // class
