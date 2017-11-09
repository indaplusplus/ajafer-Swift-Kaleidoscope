//
//  Prototype.swift
//  SwiftCompiler
//
//  Created by Adam Jafer on 2017-11-09.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation

/*
     This is one of the components we will use for our Abstract Syntax Tree
     It will represent function definitions with a func name and all of it's
     parameters.
 
     Note: This struct is required as functions in Kaleidoscope are defined
     with a Functype and an Expression.
*/
struct FuncDefinition {
    var name: String // Name of function
    var parameters: [String] // Parameters defined by function
}
/*
     Finally, the Expression Enum which allows us to define functions.
     Note that some cases are ´indirect´ as it holds the enum itself
     as an associated value to multiple cases.
     *We call this a 'Recursive' Enumeration.*
*/
enum Expression {
    case variable(String) // e.g var abc
    case decimalNumber(Double) // e.g 10.0
    indirect case binaryOp(Expression,BinaryOperator,Expression) // e.g 5 + 2
    indirect case functionCall(String, [String]) // Takes function name + parameters
    indirect case ternary(Expression, Expression, Expression) // all possible ternary ops
}
/*
     This is the struct that will represent a function definition
     (Definition consists of FuncDefinition & Expression)
 
     Simple way to look at this:
         - when we define a function, it has a name and parameters.
         - inside the function we have a bunch of expressions.
 */
struct Definition {
    var funcDefinition: FuncDefinition
    var expression: Expression
}