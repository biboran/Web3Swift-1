//
// Created by Timofey on 3/1/18.
//

import Foundation

// Hex that can represent big endian numbers
public final class BigEndianHex: Hex {

    private let origin: Hex
    /**

    */
    public convenience init(int: UInt) throws {
        try self.init(
            compactValue: String(
                format: "%X",
                int
            )
        )
    }

    /**
    ctor that resolves a length ambiguity by adding a leading zero

    - throws:
    `DescribedError` if something goes wrong
    */
    init(compactValue: String) throws {
        if compactValue.count.isEven() {
            self.origin = try SimpleHex(
                value: compactValue
            )
        } else {
            let hexValue = compactValue.removingHexPrefix()
            self.origin = try SimpleHex(
                value: "0" + hexValue
            )
        }
    }

    public func toPrefixedString() -> String {
        return origin.toPrefixedString()
    }

    public func toUnprefixedString() -> String {
        return origin.toUnprefixedString()
    }

    public func toBytes() -> Data {
        return origin.toBytes()
    }

}