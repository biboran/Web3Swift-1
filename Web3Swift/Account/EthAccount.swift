//
// Created by Timofey on 3/3/18.
//

import Foundation
import SwiftyJSON

public final class EthAccount: Account {

    private let transactions: Transactions
    private let network: Network
    private let privateKey: Hex
    private let publicAddress: Address

    //We can include strategies in the ctor
    init(network: Network, privateKey: Hex, publicAddress: Address) {
        self.network = network
        self.privateKey = privateKey
        self.publicAddress = publicAddress
        self.transactions = EthTransactions(
            transactionsCountProcedure: GetTransactionsCountProcedure(
                network: network,
                address: publicAddress,
                blockChainState: PendingBlockChainState()
            )
        )
    }

    //This should actually return Receipt
    public func send(value: Wei, to recipient: Address) throws -> JSON {
        return try SendRawTransactionProcedure(
            network: network,
            rawTransaction: EthRawTransaction(
                value: value,
                recipient: recipient,
                privateKey: privateKey,
                publicAddress: publicAddress,
                transactions: transactions,
                gasPrice: EthGasPrice(network: network),
                gasEstimate: EthGasEstimate(
                    network: network,
                    from: publicAddress,
                    to: recipient,
                    value: value
                )
            ).hex()
        ).call()
    }

}