//
//  ParsingError.swift
//  SwiftCompiler
//
//  Created by Adam Jafer on 2017-11-09.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation

enum ParsingError {
    case UnexpectedToken(Token)
    case somethingFuckedUp
}
