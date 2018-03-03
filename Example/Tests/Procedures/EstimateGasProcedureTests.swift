//
// Created by Timofey on 2/27/18.
// Copyright (c) 2018 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import Web3Swift

final class EstimateGasProcedureTests: XCTestCase {

    func testNonNegativeEstimation() {
        expect{
            let network = try FakeEthereumNetwork()
            return try BigEndianHex(
                compactValue: EstimateGasProcedure(
                    network: network,
                    from: SimpleAddress(
                        hex: SimpleHex(
                            value: "0x79d2c50Ba0cA4a2C6F8D65eBa1358bEfc1cFD403"
                        )
                    ),
                    to: SimpleAddress(
                        hex: SimpleHex(
                            value: "0xcD8aC90d9cc7e4c03430d58d2f3e87Dae70b807e"
                        )
                    ),
                    gasPrice: EthGasPrice(network: network),
                    value: SimpleWei(
                        hex: SimpleHex(
                            value: "0x01"
                        )
                    )
                ).call()["result"].string()
            ).toBytes().count
        }.to(
            beGreaterThan(0),
            description: "Gas estimation represented as its data length is expected to be greater than 0"
        )
    }

}