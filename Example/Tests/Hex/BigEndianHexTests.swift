//
// Created by Timofey on 3/1/18.
// Copyright (c) 2018 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import Web3Swift

final class BigEndianHexTests: XCTestCase {

    func testCorrectlyAlignedHexFor1() {
        expect{
            let hex = try BigEndianHex(compactValue: "0x1")
            expect{
                hex.toBytes()
            }.to(
                equal(Data(bytes: [0x01])),
                description: "Hex data is expected to match its representative Data"
            )
            expect{
                hex.toUnprefixedString()
            }.to(
                equal("01"),
                description: "Hex string is expected to be unambiguously aligned and unprefixed string it represents"
            )
            expect{
                hex.toPrefixedString()
            }.to(
                equal("0x01"),
                description: "Hex string is expected to be unambiguously aligned and prefixed string it represents"
            )
            return ()
        }.toNot(
            throwError(),
            description: "Above statements are not expected to throw"
        )
    }

    func testCorrectlyAlignedHexFor1023() {
        expect{
            let hex = try BigEndianHex(compactValue: "0x3ff")
            expect{
                hex.toBytes()
            }.to(
                equal(Data(bytes: [0x03, 0xff])),
                description: "Hex data is expected to match its representative Data"
            )
            expect{
                hex.toUnprefixedString()
            }.to(
                equal("03ff"),
                description: "Hex string is expected to be unambiguously aligned and unprefixed string it represents"
            )
            expect{
                hex.toPrefixedString()
            }.to(
                equal("0x03ff"),
                description: "Hex string is expected to be unambiguously aligned and prefixed string it represents"
            )
            return ()
        }.toNot(
            throwError(),
            description: "Above statements are not expected to throw"
        )
    }

    func testCorrectlyAlignedFor16() {
        expect{
            let hex = try BigEndianHex(compactValue: "0xff")
            expect{
                hex.toBytes()
            }.to(
                equal(Data(bytes: [0xff])),
                description: "Hex data is expected to match its representative Data"
            )
            expect{
                hex.toUnprefixedString()
            }.to(
                equal("ff"),
                description: "Hex string is expected to be unambiguously aligned and unprefixed string it represents"
            )
            expect{
                hex.toPrefixedString()
            }.to(
                equal("0xff"),
                description: "Hex string is expected to be unambiguously aligned and prefixed string it represents"
            )
            return ()
        }.toNot(
            throwError(),
            description: "Above statements are not expected to throw"
        )
    }

}