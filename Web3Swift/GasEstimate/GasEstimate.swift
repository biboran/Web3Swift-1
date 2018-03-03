//
// Created by Timofey on 2/26/18.
//

import Foundation

// TODO: We might want to get rid of this interface and use Gas instead. EthGasEstimate and ManualGasEstimage will be Gas in this case.
// GasEstimate is the estimate of a fee paid to the miner for the mined transaction
public protocol GasEstimate {

    /**
        Value of the estimate in wei

        - returns:
        `Wei` object

        - throws:
        `DescribedError` if something went wrong
    */
    func value() throws -> Gas

}