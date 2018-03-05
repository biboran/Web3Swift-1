//
// Created by Timofey on 3/3/18.
//

import Foundation
import SwiftyJSON

public class SendRawTransactionProcedure: RemoteProcedure {

    private let network: Network
    private let rawTransaction: Hex

    init(network: Network, rawTransaction: Hex) {
        self.network = network
        self.rawTransaction = rawTransaction
    }

    public func call() throws -> JSON {
        return try JSON(
            data: network.call(
                method: "eth_sendRawTransaction",
                params: [
                    StringParameter(value: rawTransaction.toPrefixedString())
                ]
            )
        )
    }

}