import Foundation
import Combine

protocol AnalyticsService {
    func track(_ event: AnalyticsEvent)
}

class ConsoleAnalyticsService: ObservableObject, AnalyticsService {
    static let shared = ConsoleAnalyticsService()
    
    @Published private(set) var eventHistory: [TrackedEvent] = []
    
    init() {}
    
    func track(_ event: AnalyticsEvent) {
        let trackedEvent = TrackedEvent(
            timestamp: Date(),
            name: event.name,
            parameters: event.parameters
        )
        eventHistory.append(trackedEvent)
        print("📊 \(event.name): \(event.parameters)")
    }
    
    func clearHistory() {
        eventHistory.removeAll()
    }
}
