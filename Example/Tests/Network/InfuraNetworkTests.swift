//
// This source file is part of the Web3Swift.io open source project.
// Copyright 2018 The Web3Swift Authors.
// Licensed under Apache License v2.0
//
// InfuraNetworkTests.swift
//
// Created by Vadim Koleoshkin on 23/02/2018
//

import Nimble
import Quick
@testable import Web3Swift
import XCTest

class InfuraNetworkTests: XCTestCase {
    
    /// Assert network call does not throw an error on valid params
    func testValidCall() {
        expect{
            try InfuraNetwork(chain: "mainnet", apiKey: "metamask").call(
                method: "web3_sha3",
                params: [
                    BytesParameter(
                        bytes: UTF8StringBytes(
                            string: "web3swift"
                        )
                    )
                ]
            )
        }.notTo(
            throwError(),
            description: "Make sure network call executed succesfully"
        )
        
    }
    
    /// Assert network call throws an error on invalid method
    func testInValidCall() {
        expect{
            try InfuraNetwork(chain: "mainnet", apiKey: "metamask").call(
                method: "web4_sha4",
                params: [
                    BytesParameter(
                        bytes: UTF8StringBytes(
                            string: "web3swift"
                        )
                    )
                ]
            )
        }.to(
            throwError(),
            description: "Make sure network call execution fails"
        )
    }
    
}
