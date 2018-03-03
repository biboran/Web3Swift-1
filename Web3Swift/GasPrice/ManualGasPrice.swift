//
// Created by Timofey on 2/27/18.
//

import Foundation

public final class ManualGasPrice: GasPrice {

    private let wei: Wei
    public init(wei: Wei) {
        self.wei = wei
    }

    public func value() throws -> Wei {
        return wei
    }

}