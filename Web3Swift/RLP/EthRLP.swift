//
// Created by Timofey on 3/5/18.
//

import Foundation

public final class EthRLP: RLP {

    private let number: Hex
    init(number: Hex) {
        self.number = number
    }

    public func toData() throws -> Data {
        if number.toBytes() == Data(bytes: [0x00]) {
            return try SimpleRLP(
                bytes: Data()
            ).toData()
        } else {
            return try SimpleRLP(
                bytes: number.toBytes()
            ).toData()
        }
    }

}