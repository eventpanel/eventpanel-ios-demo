import Foundation
import Combine

class AnalyticsService: ObservableObject {
    static let shared = AnalyticsService()
    
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
