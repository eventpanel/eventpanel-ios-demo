@testable import DemoApp
import Foundation

struct AnalyticsComparisonError: Error, CustomStringConvertible {
    let failures: [ComparisonFailure]

    var description: String {
        """
        Analytics events did not match:

        \(failures.map(\.description).joined(separator: "\n"))
        """
    }
}

struct ComparisonFailure: CustomStringConvertible {
    let path: String
    let expected: String?
    let actual: String

    var description: String {
        if let expected = expected {
            return """
            ❌ \(path) did not satisfy predicate
               expected: \(expected)
               actual:   \(actual)
            """
        } else {
            return """
            ❌ \(path) did not satisfy predicate
               actual:   \(actual)
            """
        }
    }
}

extension DemoApp.AnalyticsEvent {

    func match(_ expected: AnalyticsEvent) throws -> Bool {
        var failures: [ComparisonFailure] = []

        if name != expected.name {
            failures.append(
                ComparisonFailure(
                    path: "name",
                    expected: expected.name,
                    actual: name
                )
            )
        }

        for (key, expectedValue) in expected.parameters {
            guard let actualValue = parameters[key] else {
                failures.append(
                    ComparisonFailure(
                        path: "parameters.\(key)",
                        expected: nil,
                        actual: "missing"
                    )
                )
                continue
            }

            let predicate = (expectedValue as? AnyPredicateConvertable)!.asAnyPredicate()
            if try !predicate.evaluate(actualValue) {
                failures.append(
                    ComparisonFailure(
                        path: key,
                        expected: predicate.description,
                        actual: "\(actualValue)"
                    )
                )
            }
        }

        if !failures.isEmpty {
            throw AnalyticsComparisonError(failures: failures)
        }

        return true
    }
}
