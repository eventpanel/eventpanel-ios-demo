struct Predicate<Target> {
    let description: String?
    let evaluate: (Target) throws -> Bool

    init(
        _ description: String? = nil,
        evaluate: @escaping (Target) throws -> Bool
    ) {
        self.description = description
        self.evaluate = evaluate
    }
}

extension Predicate where Target: Equatable {
    init(_ value: Target) {
        self.init("\(value)") {
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
