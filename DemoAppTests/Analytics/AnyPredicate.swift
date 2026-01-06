import Foundation

struct AnyPredicate {
    let description: String?
    let evaluate: (Any) throws -> Bool

    init<T>(_ predicate: Predicate<T>) {
        self.description = predicate.description
        self.evaluate = {
            guard let value = $0 as? T else { return false }
            return try predicate.evaluate(value)
        }
    }
}

protocol AnyPredicateConvertable {
    func asAnyPredicate() -> AnyPredicate
}

extension Predicate: AnyPredicateConvertable {
    func asAnyPredicate() -> AnyPredicate {
        AnyPredicate(self)
    }
}
