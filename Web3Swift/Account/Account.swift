//
// Created by Timofey on 1/20/18.
//

import Foundation
import SwiftyJSON

public protocol Account {

    func send(value: Wei, to: Address) throws -> JSON

}
