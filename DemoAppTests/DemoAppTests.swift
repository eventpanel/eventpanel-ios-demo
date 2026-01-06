import Foundation
import Testing
@testable import DemoApp

struct DemoAppTests {

    @Test func testProductViewedEvent() async throws {
        let analyticsService = MockAnalyticsService()
        let viewModel = ViewModel(analyticsService: analyticsService)

        viewModel.buttonDidTap()

        let expectedEvent = AnalyticsEvents.ProductDetails.productViewed(
            productId: "prod_123",
            productPrice: Predicate {
                Decimal(string: String($0.dropFirst()))! > 10
            }
        )

        #expect(try analyticsService.events[0].match(expectedEvent))
    }
}
