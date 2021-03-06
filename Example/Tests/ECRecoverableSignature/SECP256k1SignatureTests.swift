//
// Created by Timofey on 2/10/18.
// Copyright (c) 2018 CocoaPods. All rights reserved.
//

import Foundation

import CryptoSwift
import Nimble
import Quick
@testable import Web3Swift
import XCTest

//FIXME: SigningError case is not tested
//FIXME: SignatureSerializationError case is not tested
//FIXME: A lot of copy paste tests.
final class SECP256k1SignatureTests: XCTestCase {

    private let validPrivateKey: PrivateKey = {
        EthPrivateKey(
            bytes: BytesFromHexString(
                hex: "bdd61bcde5541ac8ad18c0ec53356419a0e62e8f147a1cc16ea36799e2cc64dd"
            )
        )
    }()

    func testIncorrectHashingFunction() {
        expect(
            try SECP256k1Signature(
                privateKey: self.validPrivateKey,
                message: UTF8StringBytes(string: "Hello world"),
                hashFunction: SHA3(variant: .keccak224).calculate
            ).r().hex().value()
        ).to(
            throwError(errorType: IncorrectHashLengthError.self),
            description: "Incorrect hash length must result in the IncorrectHashLengthError to be thrown"
        )
    }

    func testEqualSignatures() {
        let firstSignature = SECP256k1Signature(
            privateKey: self.validPrivateKey,
            message: UTF8StringBytes(string: "Hello world"),
            hashFunction: SHA3(variant: .keccak256).calculate
        )
        let secondSignature = SECP256k1Signature(
            privateKey: self.validPrivateKey,
            message: UTF8StringBytes(string: "Hello world"),
            hashFunction: SHA3(variant: .keccak256).calculate
        )
        expect{
            expect(
                try firstSignature.r().hex().value()
            ).to(
                equal(
                    try secondSignature.r().hex().value()
                ),
                description: "Two signatures with equal messages must have equal r values"
            )
            expect(
                try firstSignature.s().hex().value()
            ).to(
                equal(
                    try secondSignature.s().hex().value()
                ),
                description: "Two signatures with equal messages must have equal s values"
            )
            expect(
                try firstSignature.recoverID().uint()
            ).to(
                equal(
                    try secondSignature.recoverID().uint()
                ),
                description: "Two signatures with equal messages must have equal recovery id values"
            )
            return ()
        }.toNot(
            throwError(),
            description: "None of the above statements are expected to throw"
        )
    }

    func testDifferentMessages() {
        let firstSignature = SECP256k1Signature(
            privateKey: self.validPrivateKey,
            message: UTF8StringBytes(string: "Hello world"),
            hashFunction: SHA3(variant: .keccak256).calculate
        )
        let secondSignature = SECP256k1Signature(
            privateKey: self.validPrivateKey,
            message: UTF8StringBytes(string: "Hello worlds"),
            hashFunction: SHA3(variant: .keccak256).calculate
        )
        expect{
            try firstSignature.r().hex().value() == secondSignature.r().hex().value()
                && firstSignature.s().hex().value() == secondSignature.s().hex().value()
                && firstSignature.recoverID().uint() == secondSignature.recoverID().uint()
        }.to(
            equal(false),
            description: "Signatures with different messages must be different"
        )
    }

    /// Assert example from EIP-155 matches SECP256k1Signature implementation
    func testOneRawMessage() {
        let signature = SECP256k1Signature(
            privateKey: EthPrivateKey(
                bytes: BytesFromHexString(
                    hex: "0x4646464646464646464646464646464646464646464646464646464646464646"
                )
            ),
            message: BytesFromHexString(hex: "0xec098504a817c800825208943535353535353535353535353535353535353535880de0b6b3a764000080018080"),
            hashFunction: SHA3(variant: .keccak256).calculate
        )
        expect{
            try signature.r().hex().value()
        }.to(
            equal(
                Data(hex: "0x28ef61340bd939bc2195fe537567866003e1a15d3c71ff63e1590620aa636276")
            ),
            description: "Signature r is expected to match example r"
        )
        expect{
            try signature.s().hex().value()
        }.to(
            equal(
                Data(hex: "0x67cbe9d8997f761aecb703304b3800ccf555c9f3dc64214b297fb1966a3b6d83")
            ),
            description: "Signature s is expected to match example s"
        )
    }

    /// Assert example from EIP-155 matches SECP256k1Signature implementation dependent upon SimpleRLP implementation
    func testOneRLP() {
        let signature = SECP256k1Signature(
            privateKey: EthPrivateKey(
                bytes: BytesFromHexString(
                    hex: "0x4646464646464646464646464646464646464646464646464646464646464646"
                )
            ),
            message: SimpleRLP(
                rlps: [
                    SimpleRLP(
                        bytes: Data(
                            hex: "0x09" //nonce
                        )
                    ),
                    SimpleRLP(
                        bytes: Data(
                            hex: "0x04a817c800" //gas price
                        )
                    ),
                    SimpleRLP(
                        bytes: Data(
                            hex: "0x5208" //start gas
                        )
                    ),
                    SimpleRLP(
                        bytes: Data(
                            hex: "0x3535353535353535353535353535353535353535" //to
                        )
                    ),
                    SimpleRLP(
                        bytes: Data(
                            hex: "0x0de0b6b3a7640000" //value
                        )
                    ),
                    SimpleRLP(
                        bytes: Data() //data
                    ),
                    SimpleRLP(
                        bytes: Data(
                            hex: "0x01" //chain id (mainnet in this case)
                        )
                    ),
                    SimpleRLP(
                        bytes: Data() //stubbed r according to EIP-155
                    ),
                    SimpleRLP(
                        bytes: Data() //stubbed s according to EIP-155
                    ),
                ]
            ),
            hashFunction: SHA3(variant: .keccak256).calculate
        )
        expect{
            try signature.r().hex().value()
        }.to(
            equal(
                Data(hex: "0x28ef61340bd939bc2195fe537567866003e1a15d3c71ff63e1590620aa636276")
            ),
            description: "Signature r is expected to match example r"
        )
        expect{
            try signature.s().hex().value()
        }.to(
            equal(
                Data(hex: "0x67cbe9d8997f761aecb703304b3800ccf555c9f3dc64214b297fb1966a3b6d83")
            ),
            description: "Signature s is expected to match example s"
        )
    }

}
