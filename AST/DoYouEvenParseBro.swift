//
//  DoYouEvenParseBro.swift
//  SwiftCompiler
//
//  Created by Adam Jafer on 2017-11-09.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation
/*
     This will be our Top-Down Parser.
*/

typealias Completed = (_ success: Bool,_ error: ParsingError?) -> ()

class KaleidoParser {
    let tokens: [Token] // Hold all tokens passed from lexer
    var index: Int // rep. current index of token we're looking at.
    
    init(tokens: [Token]) {
        self.tokens = tokens
        index = 0
    }
    
    // MARK:- Some helper funcs.
    fileprivate func nextIndex() {
        self.index += 1
    }
    
    fileprivate func currentToken() -> Token? {
        if index < tokens.count {
            return tokens[index]
        }
        return nil
    }
    
    // Where the magic happens, parse all tokens.
    func parse() throws -> ParsedObjects {
        let objects = ParsedObjects()
        while let token = currentToken() {
            switch token {
            case .def:
                objects.addFunction(function: try parseFunction())
            case .extern:
                objects.addExternalCall(def: try parseExterns())
            default:
                // Assume expression if not function call or external func call.
                let expression = try parseExpressions()
                try next(.semicolon)
                objects.addExpression(exp: expression)
            }
        }
        return objects
    }
    
    // Parse something which is comma-separated (a function definition's parameters)
    // We know this consists of a left paraenthesis, list of pararms, right parenthesis
    // Generic because we will use this pattern in multiple places.
    fileprivate func parseParameters<T>(_ parsefunc: () throws -> T) throws -> [T] {
        // The pattern is: "(" "a,b,c,d" ")". We parse in this order.
        try next(.leftParenthesis)
        var params = [T]()
        while let token = currentToken(), token != .rightParenthesis {
            // Basically keep parsing parameter tokens until we reach right parenthesis.
            let param = try parsefunc()
            if token == .comma {
                try next(token)
            }
            params.append(param)
        }
        // Done with all parameters.
        try next(.rightParenthesis)
        return params
    }
    
    // Parse an identifier by giving us it's string representation
    // We'll use this extensively throughout our parsing.
    fileprivate func parseIdentifiers() throws -> String {
        guard let currentToken = currentToken() else {
            throw ParsingError.somethingFuckedUp
        }
        if case .identifier(let name) = currentToken {
            nextTokenBy(1)
            return name
        }
        throw ParsingError.UnexpectedToken(currentToken)
    }
    
    // Parsing a function definition (name + parameters)
    fileprivate func parseFuncDef() throws -> FuncDefinition {
        let funcName = try parseIdentifiers()
        let funcParams = try parseParameters(parseIdentifiers)
        return FuncDefinition(name: funcName, parameters: funcParams)
    }
    
    // In Kaleidoscope we can call: extern somefunc(a,b,c);
    // This will parse all extern calls.
    // which follows pattern: "extern" "FuncDef" ";"
    fileprivate func parseExterns() throws -> FuncDefinition {
        try next(.extern)
        let funcDef = try parseFuncDef()
        try next(.semicolon)
        return funcDef
    }
    
    // Finally, we parse the actual function.
    // Which consists of "def" "FuncDef(expressions)" ";"
    fileprivate func parseFunction() throws -> Definition {
        try next(.def)
        let definition = try parseFuncDef()
        let expressions = try parseExpressions()
        let function = Definition(funcDefinition: definition, expression: expressions)
        try next(.semicolon)
        return function
    }
    
    fileprivate func nextTokenBy(_ incr: Int) {
        index += incr
    }
    
    fileprivate func next(_ token: Token) throws {
        guard let currentToken = currentToken() else {
            throw ParsingError.somethingFuckedUp
        }
        guard token == currentToken else {
            throw ParsingError.UnexpectedToken(token)
        }
        nextTokenBy(1)
    }
    
    fileprivate func parseExpressions() throws -> Expression {
        guard let token = currentToken() else {
            throw ParsingError.somethingFuckedUp
        }
        var expression: Expression
        switch token {
        case .leftParenthesis:
            nextTokenBy(1)
            expression = try parseExpressions()
            try next(.rightParenthesis)
        case .decimalNumber(let value):
            nextTokenBy(1)
            expression = .decimalNumber(value)
        case .identifier(let value):
            nextTokenBy(1)
            if case .leftParenthesis = token {
                let params = try parseParameters(parseExpressions)
                expression = .functionCall(value, params)
            } else {
                expression = .variable(value)
            }
        default:
            throw ParsingError.UnexpectedToken(token)
        }
        return expression
    }
}
