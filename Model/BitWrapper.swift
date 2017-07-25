//
//  BitWrapper.swift
//  PWB
//
//  Created by Nicholas Wei on 7/12/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//
//  TODO:
//  - cleanup viewing (put public functions/properties above internal implementation details)

import Foundation


enum BitWrapperError: Error
{
    case invalidInit(reason: String)
    case badArgs
}

class BitWrapper    // class to represent binary numbers for easy manipulations in the game
{
    
    // private var fullBinary: String?    // contains the entire binary number in string form; NOT UPDATED IN REAL TIME/WILL BE EDITED OUT LATER
    private var binary: [Character]!         // binary number stored in array with each slot representing a char-form bit of fullBinary
    
    var expansion: [Character]
    {
        return binary
    }
    
    init(fromString stringNum: String, alreadyBinary: Bool) // initializes from a string of an int
    {
        if let number = Int(stringNum)  // ensure that number is valid regardless if its in binary form or not
        {
            if !alreadyBinary
            {
                binary = Array(String(number, radix: 2).characters) // convert to binary
            }
            else
            {
                binary = Array(stringNum.characters)
            }
            // removeLeadingZeros()
        }
        //        else    // bad arguments
        //        {
        //            throw BitWrapperError.invalidInit(reason: "String does not represent an int")
        //        }
    }
    
    init(fromNum number: Int) // initializes from an Int
    {
        binary = Array(String(number, radix: 2).characters)
    }
    
    init(fromBit wrapper: BitWrapper)   // initialize from another BitWrapper
    {
        binary = wrapper.binary
        // removeLeadingZeros()
    }
    
    func removeLeadingZeros()   // ex. "00010" to "10"
    {
        if (binary.count > 1 && binary?[0] == "0")
        {
            binary.removeFirst()
            removeLeadingZeros()
        }
    }
    
    func addLeadingZeros(num: Int)
    {
        binary = Array(String(repeating: "0", count: num).characters) + binary
    }
    
    func flip(index: Int) // flips the bit
    {
        if let bit = binary?[index]
        {
            if bit == "0"
            {
                binary[index] = "1"
            }
            else
            {
                binary[index] = "0"
            }
        }
    }
    
    func shiftLeft()
    {
        binary.removeFirst()
        binary.append("0")
        // removeLeadingZeros()
    }
    
    func shiftRight()
    {
        if binary.count > 1
        {
            binary.removeLast()
        }
        else
        {
            binary[0] = "0"
        }
        
        binary!.insert("0", at: 0)
    }
    
    func toStr() -> String
    {
        return String(binary!)
    }
    
    func toInt() -> Int
    {
        return Int(self.toStr(), radix: 2)!
    }
    
    static func selfAdd(fromBit: BitWrapper) -> BitWrapper   // adds itself together as if each bit was its own number ex. selfAdd("11110") = 4 or 0b100
    {
        return BitWrapper(fromNum: fromBit.binary.filter{$0 == "1"}.count)
    }
    
    static func selfAnd(fromBit: BitWrapper) -> BitWrapper   // ANDs itself together as if each bit was independent
    {
        if (fromBit.binary.filter{$0 == "0"}.count) >= 1
        {
            return BitWrapper(fromNum: 0)
        }
        return BitWrapper(fromNum: 1)
    }
    
    static func selfOr(fromBit: BitWrapper) -> BitWrapper    // ORs the bit as if each bit was independent
    {
        if (fromBit.binary.filter{$0 == "1"}.count) >= 1
        {
            return BitWrapper(fromNum: 1)
        }
        return BitWrapper(fromNum: 0)
    }
    
    static func selfXor(fromBit: BitWrapper) -> BitWrapper  // XORs the bit as if each bit was independent
    {
        if (fromBit.binary.filter{$0 == "1"}.count % 2) == 0    // even number of 1s, result should be 0
        {
            return BitWrapper(fromNum: 0)
        }
        return BitWrapper(fromNum: 1)
    }
    
    func selfNot()   // NOTs the bits modifies original self
    {
        
        for i in 0..<binary.count
        {
            self.flip(index: i)
        }
        // removeLeadingZeros()
    }
    
    static func add(lhs: BitWrapper, rhs: BitWrapper) -> BitWrapper    // static bitwise addition function, does not require constructed BitWrapper
    {
        return BitWrapper(fromNum: (lhs.toInt() + rhs.toInt()))
    }
    
    
    static func or(lhs: BitWrapper, rhs: BitWrapper) -> BitWrapper  // static OR bitwise function
    {
        if lhs.binary.count == rhs.binary.count
        {
            var stringBit = ""
            
            for i in 0..<lhs.binary.count
            {
                if lhs.binary[i] == "1" || rhs.binary[i] == "1"
                {
                    stringBit += "1"
                }
                else
                {
                    stringBit += "0"
                }
            }
            
            return BitWrapper(fromString: stringBit, alreadyBinary: true)
        }
        else
        {
            return BitWrapper(fromNum: -1)
        }
    }
    
    static func and(lhs: BitWrapper, rhs: BitWrapper) -> BitWrapper
    {
        if lhs.binary.count == rhs.binary.count
        {
            var stringBit = ""
            
            for i in 0..<lhs.binary.count
            {
                if lhs.binary[i] == "1" && rhs.binary[i] == "1"
                {
                    stringBit += "1"
                }
                else
                {
                    stringBit += "0"
                }
            }
            
            return BitWrapper(fromString: stringBit, alreadyBinary: true)
        }
        else
        {
            return BitWrapper(fromNum: -1)  // don't want to throw error, instead just return -1 in BitWrapper form since all levels deal with only positive nums
        }
    }
    
    static func xor(lhs: BitWrapper, rhs: BitWrapper) -> BitWrapper
    {
        if lhs.binary.count == rhs.binary.count
        {
            var stringBit = ""
            
            for i in 0..<lhs.binary.count
            {
                if lhs.binary[i] == "1" && rhs.binary[i] == "1"
                {
                    stringBit += "0"
                }
                else if lhs.binary[i] == "1" || rhs.binary[i] == "1"
                {
                    stringBit += "1"
                }
                else
                {
                    stringBit += "0"
                }
            }
            
            return BitWrapper(fromString: stringBit, alreadyBinary: true)
        }
        else
        {
            return BitWrapper(fromNum: -1)
        }
    }
    
    static func equals(lhs: BitWrapper, rhs: BitWrapper) -> Bool    // compares two BitWrappers for equality, leading zeros are not factored into equality, only their pure numerical value
    {
        return lhs.toInt() == rhs.toInt()
    }
} // class
