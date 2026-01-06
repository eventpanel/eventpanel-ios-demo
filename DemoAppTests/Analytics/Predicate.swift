struct Predicate<Target> {
    let description: String?
    let evaluate: (Target) throws -> Bool
}

extension Predicate where Target: Equatable {
    init(evaluate: @escaping (Target) throws -> Bool) {
        self.init(description: nil, evaluate: evaluate)
    }
}

extension Predicate where Target: Equatable {
    init(_ value: Target) {
        self.init(description: "\(value)") {
            $0 == value
        }
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
