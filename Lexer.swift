//
//  Lexer.swift
//  SwiftCompiler
//
//  Created by Adam Jafer on 2017-11-07.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation
/*
     This Lexer object will be responsible for holding a source string
     and converting it to a set of tokens.
*/
class Lexer {
    let input: String // Our input string should be constant, it shouldn't change once Lexer is initialized.
    var currentIndex: String.Index // index will keep track of which part of the input we are looking at
    
    init(input: String) {
        // Set input value and set index to beginning of string
        self.input = input
        currentIndex = input.startIndex
    }
    
    // Return character from current index.
    fileprivate func currentCharacter() -> Character? {
        if currentIndex < input.endIndex {
            return input[currentIndex]
        }
        return nil
    }
    
    func charsAsReadableValue() -> String {
        var str = ""
        while let char = currentCharacter(), char.isAlphanumeric || char == "." {
            str.characters.append(char)
            advanceIndex()
        }
        return str
    }
    // Replace current index with successor (go to next index)
    fileprivate func advanceIndex() {
        input.characters.formIndex(after: &currentIndex)
    }
    /*
         This function will go through every character of the input string
         and convert every non whitespace character into a token.
     
         Note: These are the tokens that will then be passed over to our
               parser.
     */
    func lex() -> [Token] {
        var tokens = [Token]()
        while let validToken = goToNextToken() {
            tokens.append(validToken)
        }
        return tokens
    }
     /*
         Don't let this func be accessed from outside this class.
     
         This function will keep skipping whitespaces until it finds
         something which can be translated into a token.
     
         If no token is found, it will return nil. Return type is
         therefore an optional value.
     */
    fileprivate func goToNextToken() -> Token? {
        // As long as character is whitespace, keep skipping.
        while let char = currentCharacter(), char.isSpace {
            advanceIndex()
        }
        
        guard let char = currentCharacter() else {
            // No non-space character found, return nil
            return nil
        }
         /*
              Now that we found a non-whitespace character, figure out
              which token should represent it.
         
                 1) Handle Single-Scalar tokens
                 2) Handle alphanumeric values
         */
        let singleScalars: [Character: Token] = [
            ",": Token.comma,
            "(": Token.leftParenthesis,
            ")": Token.rightParenthesis,
            ";": Token.semicolon,
            "+": Token.´operator´(BinaryOperator.plus),
            "-": Token.´operator´(BinaryOperator.minus),
            "*": Token.´operator´(BinaryOperator.multiply),
            "/": Token.´operator´(BinaryOperator.divide),
            "%": Token.´operator´(BinaryOperator.modulo)
        ]
        
        if let scalarToken = singleScalars[char] {
            return scalarToken
        }
        
        if char.isAlphanumeric {
            let compactedString = charsAsReadableValue()
            // If transmuatble into number, we know it's a number string.
            if let number = Double(compactedString) {
                return Token.decimalNumber(number)
            }
            // Otherwise check for language keywords:
            switch compactedString {
            case "def":
                return Token.def
            case "extern":
                return Token.extern
            case "comma":
                return Token.comma
            case "if":
                return Token.´if´
            case "else":
                return Token.´else´
            case "then":
                return Token.then
            default:
                // No lang. keyword was found, assume identifier
                return Token.identifier(compactedString)
            }
        }
        return nil
    }
}








