// swiftlint:disable all
// Generated using EventPanel — https://github.com/eventpanel/eventpanel-cli

import Foundation

internal enum AnalyticsEvents {
  /// Tracks user behavior on product detail screens
  internal enum ProductDetails {

    /// Triggered when a product detail screen is opened
    /// - Parameters:
    ///     - product_id: Unique product identifier
    internal static func productViewed(  
      productId: Predicate<String>,
      productPrice: Predicate<String>
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Product Viewed",
        parameters: [
          "product_id": productId,
          "product_price": productPrice
        ]
      )
    }
  }
}

private extension Dictionary where Value == Any? {
  /// Returns dictionary with filtered out `nil` and `NSNull` values
  func byExcludingNilValues() -> [Key: Any] {
    return compactMapValues { value -> Any? in
      value is NSNull ? nil : value
    }
  }
}

internal struct AnalyticsEvent {
  internal let name: String
  internal let parameters: [String: Any]

  internal init(name: String, parameters: [String: Any] = [:]) {
    self.name = name
    self.parameters = parameters
  }
}
// swiftlint:enable all