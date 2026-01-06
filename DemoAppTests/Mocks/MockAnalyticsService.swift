//
//  MockAnalyticsService.swift
//  DemoAppTests
//
//  Created by Auto on 16.12.2025.
//

import Foundation
@testable import DemoApp

class MockAnalyticsService: AnalyticsService {
    private(set) var events: [DemoApp.AnalyticsEvent] = []

    func track(_ event: DemoApp.AnalyticsEvent) {
        events.append(event)
    }
    
    func clearHistory() {
        events.removeAll()
    }
}

