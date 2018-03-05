//
// Created by Timofey on 3/5/18.
// Copyright (c) 2018 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import Web3Swift

final class AccountTests: XCTestCase {

    func testAccountSending() {
        expect{
            try EthAccount(
                network: InfuraNetwork(
                    chain: "kovan",
                    apiKey: "metamask"
                ),
                privateKey: SimpleHex(
                    value: "0xee963231891a9b0f5482ec129aacb65a1ab07af40e9e2284a260bc096d09df2d"
                ),
                publicAddress: SimpleAddress(
                    hex: SimpleHex(
                        value: "0x79d2c50Ba0cA4a2C6F8D65eBa1358bEfc1cFD403"
                    )
                )
            ).send(
                value: SimpleWei(
                    hex: BigEndianHex(
                        int: 1000
                    )
                ),
                to: SimpleAddress(
                    hex: SimpleHex(
                        value: "0x79d2c50Ba0cA4a2C6F8D65eBa1358bEfc1cFD403"
                    )
                )
            )["result"].string()
        }.toNot(
            beEmpty()
        )
    }

}