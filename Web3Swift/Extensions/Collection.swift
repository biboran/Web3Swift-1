//
// Created by Timofey on 3/12/18.
//

import Foundation

internal final class IncorrectNumberOfElementsError: DescribedError {

    private let collection: AnyCollection<Any>
    init<T>(collection: AnyCollection<T>) {
        self.collection = AnyCollection<Any>(collection.map{ $0 as Any })
    }

    var description: String {
        return "Collection was expected to have 1 element but had \(collection.count)"
    }

}

extension Collection {

    /**
    - returns:
    a single element of a collection

    - throws:
    `DescribedError` when element of a collection is not single
    */
    public func single() throws -> Self.Element {
        if self.count == 1, let first = self.first {
            return first
        } else {
            throw IncorrectNumberOfElementsError(
                collection: AnyCollection(Array(self))
            )
        }
    }

}