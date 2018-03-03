//
// Created by Timofey on 2/27/18.
//

import Foundation

public final class SimpleGas: Gas {

    private let hex: Hex
    public init(hex: Hex) throws {
        self.hex = hex
    }

    public func hexValue() -> Hex {
        return hex
    }

}