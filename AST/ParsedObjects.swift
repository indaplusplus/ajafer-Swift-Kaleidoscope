//
//  ParsedObjects.swift
//  SwiftCompiler
//
//  Created by Adam Jafer on 2017-11-15.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation
// An object that will hold everything we have parsed.
// Initialized after parsing is done.
class ParsedObjects: CustomStringConvertible {
    fileprivate var externalCalls = [FuncDefinition]()
    fileprivate var functions = [Definition]()
    fileprivate var expressions = [Expression]()
    // Store definition of each function by it's name for easy access.
    fileprivate var funcDictionary = [String: FuncDefinition]()
    
    var description: String {
        return "Functions Called: \(funcDictionary)"
    }
    
    func funcDefinition(forName name: String) -> FuncDefinition? {
        return funcDictionary[name]
    }
    
    func addExternalCall(def: FuncDefinition) {
        externalCalls.append(def)
        funcDictionary[def.name] = def
    }
    
    func addExpression(exp: Expression) {
        expressions.append(exp)
    }
    
    func addFunction(function: Definition) {
        functions.append(function)
        funcDictionary[function.funcDefinition.name] = function.funcDefinition
    }
    
}

