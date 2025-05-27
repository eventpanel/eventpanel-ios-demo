//
//  AnalyticsEvent.swift
//  DemoApp
//

protocol AnalyticsParameterValueConvertible {
    var analyticsValue: String { get }
}

struct AnalyticsEvent {
    let name: String
    let parameters: [String: Any]
}
