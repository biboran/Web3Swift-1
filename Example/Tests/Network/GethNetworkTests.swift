//
// This source file is part of the Web3Swift.io open source project
// Copyright 2018 The Web3Swift Authors
// Licensed under Apache License v2.0
//
// GethNetworkTests.swift
//
// Created by Vadim Koleoshkin on 23/02/2018
//

import Nimble
import Quick
@testable import Web3Swift
import XCTest

class GethNetworkTests: XCTestCase {
    
    /// Assert network initialisation with correct url
    func testValidUrl()
    {
        expect{
            try GethNetwork(url: "https://mainnet.infura.io/metamask")
        }.notTo(
            throwError(),
            description: "Make sure network can be initialised with correct url"
        )
    }
    
    /// Assert network initialisation with correct url
    func testInValidUrl()
    {
        expect{
            try GethNetwork(url: "fdasdf@@fodksafjm($^^8fdsf")
        }.to(
            throwError(errorType: IncorrectUrlStringError.self),
            description: "Make sure network can not be initialised with correct url"
        )
    }
    
    /// Assert network initialisation with correct IP and port
    func testValidIpPort()
    {
        expect{
            try GethNetwork(ip: "127.0.0.1", port: "8545", isSecureConnection: false)
        }.notTo(
            throwError(),
            description: "Make sure network can be initialised with correct IP, port and security scheme"
        )
        
        expect{
            try GethNetwork(ip: "127.0.0.1", port: "8545", isSecureConnection: true)
        }.notTo(
            throwError(),
            description: "Make sure network can be initialised with correct IP, port and security scheme"
        )
    }
    
    /// Assert network initialisation with correct url
    func testInValidIpPort()
    {
        expect{
            try GethNetwork(ip: "99.99.99.99.99", port: "8545", isSecureConnection: false)
        }.to(
            throwError(errorType: IncorrectIpStringError.self),
            description: "Make sure network can not be initialised with correct IP, port and security scheme"
        )
    }
    
}
