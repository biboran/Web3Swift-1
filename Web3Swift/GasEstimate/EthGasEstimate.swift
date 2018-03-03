//
// Created by Timofey on 2/26/18.
//

import Foundation

public final class EthGasEstimate: GasEstimate {

    private let estimationProcedure: RemoteProcedure
    public init(
        network: Network,
        from: Address,
        to: Address,
        gasPrice: GasPrice,
        value: Wei
    ) {
        self.estimationProcedure = EstimateGasProcedure(
            network: network,
            from: from,
            to: to,
            gasPrice: gasPrice,
            value: value
        )
    }

    public convenience init(
        network: Network,
        from: Address,
        to: Address,
        value: Wei
    ) {
        self.init(
            network: network,
            from: from,
            to: to,
            gasPrice: EthGasPrice(
                network: network
            ),
            value: value
        )
    }

    public func value() throws -> Gas {
        return try SimpleGas(
            hex: BigEndianHex(
                compactValue: estimationProcedure.call()["result"].string()
            )
        )
    }

}