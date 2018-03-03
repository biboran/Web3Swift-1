//
// Created by Timofey on 2/27/18.
//

import Foundation

// TODO: We might want to get rid of this interface and use Wei instead. EthGasPrice and ManualGasPrice will be Wei in this case.
public final class EthGasPrice: GasPrice {

    private let fetchGasPriceProcedure: RemoteProcedure
    public init(network: Network) {
        self.fetchGasPriceProcedure = GetGasPriceProcedure(
            network: network
        )
    }

    public func value() throws -> Wei {
        return try SimpleWei(
            hex: BigEndianHex(
                compactValue: fetchGasPriceProcedure.call()["result"].string()
            )
        )
    }

}