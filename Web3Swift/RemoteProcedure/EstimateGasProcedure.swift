//
// Created by Timofey on 2/27/18.
//

import Foundation
import SwiftyJSON

public final class EstimateGasProcedure: RemoteProcedure {

    private let network: Network

    private let from: Address
    private let to: Address
    private let gasPrice: GasPrice
    private let value: Wei

    public init(
        network: Network,
        from: Address,
        to: Address,
        gasPrice: GasPrice,
        value: Wei
    ) {
        self.network = network
        self.from = from
        self.to = to
        self.gasPrice = gasPrice
        self.value = value
    }

    public func call() throws -> JSON {
        return try JSON(
            data: network.call(
                method: "eth_estimateGas",
                params: [
                    ObjectParameter(
                        dictionary: [
                            "from" : StringParameter(
                                value: from.toString()
                            ),
                            "to" : StringParameter(
                                value: to.toString()
                            ),
                            "gasPrice" : QuantityParameter(
                                hex: gasPrice.value().hexValue()
                            ),
                            "value" : QuantityParameter(
                                hex: value.hexValue()
                            )
                        ]
                    )
                ]
            )
        )
    }

}