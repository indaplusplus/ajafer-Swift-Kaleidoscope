//
//  ExtendCharacter.swift
//  SwiftCompiler
//
//  Created by Adam Jafer on 2017-11-07.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation

/*
     Extend character object to make it easier to create tokens from characters
     Adding helper values to determine how to represent character as token.
*/

extension Character {
    /*
         return Int32 representation of character value
         we need this to check if whitespace is space
         or alphanumeric value
    */
    var int32Value: Int32 {
        return Int32(String(self).unicodeScalars.first!.value)
    }
     /*
         check if the current character is a whitespace.
         value 0 is whitespace
     */
    var isSpace: Bool {
        return isspace(int32Value) != 0
    }
     /*
         check if currentValue is an alphanumeric value
     */
    var isAlphanumeric: Bool {
        return isalnum(int32Value) != 0 
    }
}
