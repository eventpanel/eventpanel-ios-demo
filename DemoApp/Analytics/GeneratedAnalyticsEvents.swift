// swiftlint:disable all
// Generated using EventPanel — https://github.com/eventpanel/eventpanel-cli

import Foundation

internal enum AnalyticsEvents {
  /// A screen with user data
  internal enum ProfileScreen {

    internal static func profileScreenShown() -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Profile Screen Shown",
        parameters: [:]
      )
    }

    /// Screen is fully closed
    internal static func profileScreenClosed() -> AnalyticsEvent {
      AnalyticsEvent(
        name: "Profile Screen Closed",
        parameters: [:]
      )
    }
  }
  internal static func onboardingScreenShown(  
    origin: Origin?
  ) -> AnalyticsEvent {
    AnalyticsEvent(
      name: "Onboarding Screen Shown",
      parameters: [
        "origin": origin
      ].byExcludingNilValues()
    )
  }
  /// The user sees the full screen loading indicator
  /// - Parameters:
  ///     - city_id: The id of the city
  internal static func loadingScreenShown(  
    cityId: String?
  ) -> AnalyticsEvent {
    AnalyticsEvent(
      name: "Loading Screen Shown",
      parameters: [
        "city_id": cityId
      ].byExcludingNilValues()
    )
  }
}

extension AnalyticsEvents {
    internal enum Origin: String {
      case facebook = "Facebook"
      case insta = "Insta"
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
// swiftlint:enable all