@testable import DemoApp
import Foundation

func == (lhs: DemoApp.AnalyticsEvent, rhs: AnalyticsEvent) -> Bool {
    lhs.name == rhs.name && analyticsPropertiesEqual(
        lhs.parameters.mapValues {
            guard let analyticsProperty = $0 as? AnalyticsPropertyType else {
                fatalError("Type \(type(of: $0)) does not conform to AnalyticsPropertyType")
            }
            return analyticsProperty
        },
        rhs.parameters.mapValues { $0.asAnyPredicate() }
    )
}

func != (lhs: DemoApp.AnalyticsEvent, rhs: AnalyticsEvent) -> Bool {
    !(lhs == rhs)
}

func == (lhs: [DemoApp.AnalyticsEvent], rhs: [AnalyticsEvent]) -> Bool {
    guard lhs.count == rhs.count else { return false }

    for (leftEvent, rightEvent) in zip(lhs, rhs) {
        if leftEvent != rightEvent {
            return false
        }
    }
    return true
}

protocol AnalyticsPropertyType {}
extension Int: AnalyticsPropertyType {}
extension UInt: AnalyticsPropertyType {}
extension Int64: AnalyticsPropertyType {}
extension String: AnalyticsPropertyType {}
extension Bool: AnalyticsPropertyType {}
extension Double: AnalyticsPropertyType {}
extension Array: AnalyticsPropertyType where Element: AnalyticsPropertyType {}

private func analyticsPropertiesEqual(
    _ lhs: [String: AnalyticsPropertyType],
    _ rhs: [String: AnyPredicate]
) -> Bool {
    guard lhs.count == rhs.count else { return false }

    return try! lhs.allSatisfy { key, lValue in
        guard let predicate = rhs[key] else { return false }
        return try predicate.evaluate(lValue)
    }
}

private extension AnalyticsPropertyType {
    func isEqual(to other: any AnalyticsPropertyType) -> Bool {
        switch (self, other) {
        case let (lhs as Int, rhs as Int): return lhs == rhs
        case let (lhs as UInt, rhs as UInt): return lhs == rhs
        case let (lhs as Int64, rhs as Int64): return lhs == rhs
        case let (lhs as String, rhs as String): return lhs == rhs
        case let (lhs as Bool, rhs as Bool): return lhs == rhs
        case let (lhs as Double, rhs as Double): return lhs == rhs
        case let (lhs as [any AnalyticsPropertyType], rhs as [any AnalyticsPropertyType]):
            guard lhs.count == rhs.count else { return false }
            for (l, r) in zip(lhs, rhs) where !l.isEqual(to: r) {
                return false
            }
            return true
        default:
            return false
        }
    }
}
