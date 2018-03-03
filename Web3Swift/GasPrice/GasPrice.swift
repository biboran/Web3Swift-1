//
// Created by Timofey on 2/27/18.
//

import Foundation

public protocol GasPrice {

    func value() throws -> Wei

}