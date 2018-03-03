//
// This source file is part of the Web3Swift.io open source project
// Copyright 2018 The Web3Swift Authors
// Licensed under Apache License v2.0
//
// SimpleHex.swift
//
// Created by Vadim Koleoshkin on 21/02/2018
//

import Foundation

/// Error describes invalid hex character provided
public final class IncorrectHexCharacterError: DescribedError {
    
    private let hex: String
    
    public init(hex: String) {
        self.hex = hex
    }
    
    public var description: String {
        //TODO: Highlight incorrect characters here
        return "Incorrect hex string \"\(self.hex)\""
    }
    
}

/// An implementation of hex string wrapper
public final class SimpleHex: Hex {

    private let bytes: Data

    /**
    ctor that expects a `value` that is a valid (prefixed or unprefixed) hex string

    - throws:
    Throws `DescribedError` if something goes wrong
    */
    init(value: String) throws {
        
        var hexString = value
        
        if hexString.hasPrefix("0x") {
            hexString = hexString.removingHexPrefix()
        }
        
        guard hexString.range(
                of: "^[a-f0-9]+$",
                options: [.regularExpression, .caseInsensitive]
            ) != nil else {
            throw IncorrectHexCharacterError(hex: hexString)
        }

        bytes = try Data(hexValue: hexString)
    }
    
    /**
    Converts object to string
     
    - returns:
    A non prefixed hex string
    */
    public func toUnprefixedString() -> String {
        return bytes.toHexString()
    }
    
    /**
    Converts object to string
     
    - returns:
    A prefixed hex string
    */
    public func toPrefixedString() -> String {
        return "0x" + bytes.toHexString()
    }

    public func toBytes() -> Data {
        return bytes
    }
    
}
