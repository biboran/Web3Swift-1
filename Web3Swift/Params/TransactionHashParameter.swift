import Foundation

/// Error describes invalid length of transaction hash provided
public final class IncorrectTxHashLengthError: DescribedError {
    
    private let length: Int
    
    public init(length: Int) {
        self.length = length
    }
    
    public var description: String {
        return "Hex returned \(self.length) characters string when 64 was expected"
    }
    
}

public final class TransactionHashParameter: GethParameter {
    
    private var transactionHash: Hex
    
    init(transactionHash: Hex) {
        self.transactionHash = transactionHash
    }

    public func value() throws -> Any {
        guard transactionHash.toUnprefixedString().count == 64 else {
            throw IncorrectTxHashLengthError(
                length: transactionHash.toUnprefixedString().count
            )
        }
        return transactionHash.toPrefixedString()
    }
    
}
