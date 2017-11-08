//
//  Token.swift
//  Compiler
//
//  Created by Adam Jafer on 2017-11-07.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation

/*
     Our source string will be converted into a list of tokens,
     these tokens can take different types, holding values.
     e.g an operator, number etc..
 
     This enum represents a token which covers all the possible cases
     which may occur, together with a value held by each case.
*/
enum Token {
    case def, extern, comma, semicolon, ´if´, ´else´, then, leftParenthesis, rightParenthesis
    case identifier(String)
    case decimalNumber(Double)
    case ´operator´(BinaryOperator)
}
