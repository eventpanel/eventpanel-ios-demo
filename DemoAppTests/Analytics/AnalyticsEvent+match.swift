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
    let actual: String

    var description: String {
        "❌ \(path) did not satisfy predicate\n   actual: \(actual)"
    }
}

extension DemoApp.AnalyticsEvent {

    func match(_ expected: AnalyticsEvent) throws -> Bool {
        var failures: [ComparisonFailure] = []

        // Name
        if name != expected.name {
            failures.append(
                ComparisonFailure(
                    path: "name",
                    actual: name
                )
            )
        }

        for (key, expectedValue) in expected.parameters {
            guard let actualValue = parameters[key] else {
                failures.append(
                    ComparisonFailure(
                        path: "parameters.\(key)",
                        actual: "missing"
                    )
                )
                continue
            }

            let predicate = expectedValue.asAnyPredicate()
            if try !predicate.evaluate(actualValue) {
                failures.append(
                    ComparisonFailure(
                        path: key,
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
