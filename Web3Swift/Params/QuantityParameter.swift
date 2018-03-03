import Foundation

public final class QuantityParameter: GethParameter {

    private let hex: Hex

    /**
    ctor that accepts a `Hex`
    */
    public init(hex: Hex) {
        self.hex = hex
    }

    /**
    ctor that accepts an `UInt`

    - throws:
    `DescribedError` if something went wrong
    */
    public convenience init(quantity: UInt) throws {
        try self.init(
            hex: BigEndianHex(
                int: quantity
            )
        )
    }

    /**
    Converts an ethereum `Quantity` to `String` dropping leading zeroes

    - returns:
    `Any` which should be a `String`
    */
    public func value() throws -> Any {
        return "0x" + hex.toUnprefixedString().drop(while: { $0 == "0" })
    }

}
