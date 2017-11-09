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

struct KaleidoParser {
    let tokens: [Token] // Hold all tokens passed from lexer
    var index: Int // rep. current index of token we're looking at.
    
    init(tokens: [Token]) {
        self.tokens = tokens
        index = 0
    }
    
    // MARK:- Some helper funcs.
    fileprivate mutating func nextIndex() {
        self.index += 1
    }
    
    fileprivate func currentToken() -> Token? {
        if index < tokens.count {
            return tokens[index]
        }
        return nil
    }
    
    // MARK:- Parse func, where the real magic happens.
    mutating func parse(token: Token, completion: Completed) {
        guard let currentToken = currentToken() else {
            completion(false, ParsingError.somethingFuckedUp)
            return
        }
        if currentToken != token {
            completion(false, ParsingError.UnexpectedToken(token))
            return // gtfo this func bish
        }
        completion(true, nil)
        nextIndex()
    }
    
    // Parse an identifier by giving us it's string representation
    mutating func parseIdentifiers() -> String? {
        guard let currentToken = currentToken() else {
            return nil
        }
        if case .identifier(let name) = currentToken {
            nextIndex()
            return name
        }
        return nil
    }
    
}
