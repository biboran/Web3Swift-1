//
// Created by Timofey on 3/5/18.
//

import CryptoSwift
import Foundation

public final class EthRawTransaction {

    private let value: Wei
    private let recipient: Address
    private let privateKey: Hex
    private let publicAddress: Address
    private let transactions: Transactions
    private let gasPrice: GasPrice
    private let gasEstimate: GasEstimate
    init(
        value: Wei,
        recipient: Address,
        privateKey: Hex,
        publicAddress: Address,
        transactions: Transactions,
        gasPrice: GasPrice,
        gasEstimate: GasEstimate
    ) throws {
        self.value = value
        self.recipient = recipient
        self.privateKey = privateKey
        self.publicAddress = publicAddress
        self.transactions = transactions
        self.gasPrice = gasPrice
        self.gasEstimate = gasEstimate
    }

    func hex() throws -> Hex {
        let transactionParameters: [RLP] = try [
            EthRLP(
                number: BigEndianHex(
                    int: UInt(
                        transactions.count()
                    )
                )
            ),
            EthRLP(number: gasPrice.value().hexValue()),
            EthRLP(number: gasEstimate.value().hexValue()),
            SimpleRLP(bytes: recipient.toData()),
            EthRLP(number: value.hexValue()),
            SimpleRLP(bytes: Data()) //data
        ]
        let signature = try SECP256k1Signature(
            privateKey: Array(privateKey.toBytes()),
            message: Array(
                SimpleRLP(
                    rlps: transactionParameters + [
                        EthRLP(number: BigEndianHex(int: 42)), // Assume kovan for now
                        SimpleRLP(bytes: Data()),
                        SimpleRLP(bytes: Data())
                    ]
                ).toData()
            ),
            hashFunction: SHA3(variant: .keccak256).calculate
        )
        return try SimpleHex(
            bytes: SimpleRLP(
                rlps: transactionParameters + [
                    EthRLP(number: BigEndianHex(int: 119 + UInt(signature.recoverID()))),
                    SimpleRLP(bytes: signature.r()),
                    SimpleRLP(bytes: signature.s())
                ]
            ).toData()
        )
    }

}