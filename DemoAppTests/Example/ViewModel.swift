@testable import DemoApp

struct ViewModel {
    private let analyticsService: AnalyticsService

    init(analyticsService: AnalyticsService) {
        self.analyticsService = analyticsService
    }

    func buttonDidTap() {
        let productionEvent = DemoApp.AnalyticsEvents.ProductDetails.productViewed(
            productId: "prod_123",
            productPrice: "$29.99"
        )

        analyticsService.track(productionEvent)
    }
}
