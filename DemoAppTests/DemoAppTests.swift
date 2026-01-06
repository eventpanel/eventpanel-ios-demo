import Foundation
import Testing
@testable import DemoApp

struct DemoAppTests {

    @Test func testProductViewedEvent() async throws {
        // Arrange
        let analyticsService = MockAnalyticsService()
        let viewModel = ViewModel(analyticsService: analyticsService)

        viewModel.buttonDidTap()

        let expectedEvent = AnalyticsEvents.ProductDetails.productViewed(
            productId: Predicate { $0 == "prod_123" },
            productPrice: Predicate { $0.contains("sdaads") }
        )

        #expect(analyticsService.events == [expectedEvent])
    }
}
