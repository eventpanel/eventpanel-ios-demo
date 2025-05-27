// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable identifier_name line_length number_separator type_body_length
internal enum AnalyticsEvents {
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
// swiftlint:enable identifier_name line_length number_separator type_body_length

private extension Dictionary where Value == Any? {
    /// Returns dictionary with filtered out `nil` and `NSNull` values
    func byExcludingNilValues() -> [Key: Any] {
        return compactMapValues { value -> Any? in
            value is NSNull ? nil : value
        }
    }
}
