struct Predicate<Target> {
    let evaluate: (Target) throws -> Bool
}

extension Predicate where Target: Equatable {
    init(_ value: Target) {
        evaluate = { $0 == value }
    }
}

extension Predicate: ExpressibleByIntegerLiteral where Target == Int {
    init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension Predicate: ExpressibleByExtendedGraphemeClusterLiteral where Target == String {
    init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

extension Predicate: ExpressibleByUnicodeScalarLiteral where Target == String {
    init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
}

extension Predicate: ExpressibleByStringLiteral where Target == String {
    init(stringLiteral value: String) {
        self.init(value)
    }
}
