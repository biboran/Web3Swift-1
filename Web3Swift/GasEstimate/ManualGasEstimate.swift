//
// Created by Timofey on 2/27/18.
//

import Foundation

public final class ManualGasEstimate: GasEstimate {

    private let gas: Gas
    public init(gas: Gas) {
        self.gas = gas
    }

    public func value() throws -> Gas {
        return gas
    }

}