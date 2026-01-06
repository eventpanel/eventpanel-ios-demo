// swiftlint:disable all
// Generated using EventPanel — https://github.com/eventpanel/eventpanel-cli

import Foundation

internal enum AnalyticsEvents {
  /// Tracks user behavior on product detail screens
  internal enum ProductDetails {

    /// Triggered when a user adds a product to the cart
    /// - Parameters:
    ///     - product_id: Unique product identifier
    internal static func addToCartTapped(  
      productId: Predicate<String>,
      productPrice: Predicate<String>,
      selectedOptions: Predicate<[Int]>
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Add To Cart Tapped",
        parameters: [
          "product_id": productId,
          "product_price": productPrice,
          "selected_options": selectedOptions
        ]
      )
    }

    /// riggered when a user enters the checkout flow
    internal static func checkoutStarted(  
      cartId: Predicate<String>?,
      cartValue: Predicate<Float>?,
      cartItems: Predicate<[[String: Any]]>?
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Checkout Started",
        parameters: [
          "cart_id": cartId,
          "cart_value": cartValue,
          "cart_items": cartItems
        ].byExcludingNilValues()
      )
    }

    /// Triggered when a user swipes through product images
    internal static func imageGallerySwiped(  
      imageIndex: Predicate<Int>
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Image Gallery Swiped",
        parameters: [
          "image_index": imageIndex
        ]
      )
    }

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
  /// Monitors user progress and completion of checkout
  internal enum Checkout {

    /// Triggered when the purchase is successfully completed
    internal static func checkoutCompleted(  
      totalAmount: Predicate<Int>?,
      orderSummary: Predicate<String>?,
      orderId: Predicate<String>?
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Checkout Completed",
        parameters: [
          "total_amount": totalAmount,
          "order_summary": orderSummary,
          "order_id": orderId
        ].byExcludingNilValues()
      )
    }

    /// Triggered when a user selects a payment method
    internal static func paymentMethodSelected(  
      paymentMetadata: Predicate<[[String: Any]]>,
      paymentMethod: Predicate<PaymentMethod>,
      supportedMethods: Predicate<[String]>
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Payment Method Selected",
        parameters: [
          "payment_metadata": paymentMetadata,
          "payment_method": paymentMethod,
          "supported_methods": supportedMethods
        ]
      )
    }
  }
  /// Measures user interaction with the home screen
  internal enum Home {

    /// Triggered when a user taps a promotional banner
    /// - Parameters:
    ///     - banner_metadata: Additional banner details (campaign, variant)
    ///     - banner_position: Position of the banner on the screen
    ///     - banner_id: Unique identifier of the banner
    internal static func homeBannerTapped(  
      bannerMetadata: Predicate<[String: Any]>,
      bannerPosition: Predicate<Int>,
      bannerId: Predicate<String>?
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Home Banner Tapped",
        parameters: [
          "banner_metadata": bannerMetadata,
          "banner_position": bannerPosition,
          "banner_id": bannerId
        ].byExcludingNilValues()
      )
    }

    /// Triggered when the home screen is displayed
    /// - Parameters:
    ///     - screen_load_time_ms: Time taken to load the home screen
    ///     - entry_source: Source the user came from
    internal static func homeScreenViewed(  
      activeExperiments: Predicate<String>?,
      screenLoadTimeMs: Predicate<Float>?,
      entrySource: Predicate<EntrySource>?
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Home Screen Viewed",
        parameters: [
          "active_experiments": activeExperiments,
          "screen_load_time_ms": screenLoadTimeMs,
          "entry_source": entrySource
        ].byExcludingNilValues()
      )
    }

    /// Triggered when a user taps a quick action shortcut
    /// - Parameters:
    ///     - available_actions: List of visible quick actions
    ///     - is_customized: Whether the action was user-customized
    internal static func quickActionTapped(  
      availableActions: Predicate<[String]>,
      actionType: Predicate<String>,
      isCustomized: Predicate<Bool>?
    ) -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Quick Action Tapped",
        parameters: [
          "available_actions": availableActions,
          "action_type": actionType,
          "is_customized": isCustomized
        ].byExcludingNilValues()
      )
    }
  }
}

extension AnalyticsEvents {
    internal enum PaymentMethod: String {
      case cash = "cash"
      case card = "card"
    }
    internal enum EntrySource: String {
      case google = "google"
      case facebook = "facebook"
    }
}

private extension Dictionary where Value == AnyPredicateConvertable? {
  /// Returns dictionary with filtered out `nil` and `NSNull` values
  func byExcludingNilValues() -> [Key: AnyPredicateConvertable] {
    return compactMapValues { value -> AnyPredicateConvertable? in
      value is NSNull ? nil : value
    }
  }
}

internal struct AnalyticsEvent {
  internal let name: String
  internal let parameters: [String: AnyPredicateConvertable]

  internal init(name: String, parameters: [String: AnyPredicateConvertable] = [:]) {
    self.name = name
    self.parameters = parameters
  }
}
// swiftlint:enable all
