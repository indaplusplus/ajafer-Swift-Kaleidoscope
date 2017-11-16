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
enum Token: Equatable {
    case def, extern, comma, semicolon, ´if´, ´else´, then, leftParenthesis, rightParenthesis
    case identifier(String)
    case decimalNumber(Double)
    case ´operator´(BinaryOperator)
    
    // We need a way of comparing tokens for when we parse
    static func ==(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
            // Check Language keywords first. If both are same we know they're equal
        case (.leftParenthesis, .leftParenthesis), (.rightParenthesis, .rightParenthesis), (.def, .def), (.extern, .extern), (.comma, .comma),
             (.semicolon, .semicolon), (.´if´, .´if´), (.then, .then),
             (.´else´, .´else´):
            return true
            // Then do identifiers, operators, numbers.
        case let (.identifier(first), .identifier(second)):
            return first == second
        case let (.´operator´(first), .´operator´(second)):
            return first == second
        case let (.decimalNumber(first), .decimalNumber(second)):
            return first == second
        default:
            return false
        }
    }
}
