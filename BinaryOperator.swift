//
//  BinaryOperator.swift
//  Compiler
//
//  Created by Adam Jafer on 2017-11-07.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation

/*
     This Enum will represent the basic arithmetic operations on two values.
     '+, -, *, /, %' are included.
 
     A binary operator will also be held as a token case, allowing us to
     recognize arithmetic operations.
*/

enum BinaryOperator: Character {
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
    case modulo = "%"
}
