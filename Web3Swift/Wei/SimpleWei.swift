//
// Created by Timofey on 2/27/18.
//

import Foundation

public final class SimpleWei: Wei {

    private let hex: Hex
    public init(hex: Hex) {
        self.hex = hex
    }

    public func hexValue() -> Hex {
        return hex
    }

}