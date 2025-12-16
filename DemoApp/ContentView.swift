import SwiftUI

struct ContentView: View {
    @StateObject private var analyticsService = AnalyticsService.shared
    @State private var showConsole = false
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            ScrollView {
                VStack(spacing: 24) {
                    HeaderView()
                    
                    VStack(spacing: 16) {
                        homeCard
                        productDetailsCard
                        checkoutCard
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 60)
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FloatingConsoleButton(eventCount: analyticsService.eventHistory.count) {
                        showConsole = true
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                }
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showConsole) {
            ConsoleModalView(
                events: analyticsService.eventHistory,
                onClear: { withAnimation { analyticsService.clearHistory() } },
                onClose: { showConsole = false }
            )
        }
    }
    
    private var homeCard: some View {
        EventCardView(title: "Home Events", icon: "🏠", variant: .cyan) {
            EventButtonView(label: "Screen Viewed (Google)", badges: ["entry_source"], variant: .cyan) {
                analyticsService.track(AnalyticsEvents.Home.homeScreenViewed(
                    activeExperiments: "exp_123",
                    screenLoadTimeMs: 245.5,
                    entrySource: .google
                ))
            }
            EventButtonView(label: "Screen Viewed (Facebook)", badges: ["entry_source"], variant: .cyan) {
                analyticsService.track(AnalyticsEvents.Home.homeScreenViewed(
                    activeExperiments: nil,
                    screenLoadTimeMs: 180.0,
                    entrySource: .facebook
                ))
            }
            EventButtonView(label: "Banner Tapped", badges: ["banner_id", "position"], variant: .cyan) {
                analyticsService.track(AnalyticsEvents.Home.homeBannerTapped(
                    bannerMetadata: ["campaign": "summer_sale", "variant": "A"],
                    bannerPosition: 1,
                    bannerId: "banner_001"
                ))
            }
            EventButtonView(label: "Quick Action", badges: ["actions[]"], variant: .cyan) {
                analyticsService.track(AnalyticsEvents.Home.quickActionTapped(
                    availableActions: ["search", "cart", "profile"],
                    actionType: "search",
                    isCustomized: true
                ))
            }
        }
    }
    
    private var productDetailsCard: some View {
        EventCardView(title: "Product Details", icon: "📦", variant: .purple) {
            EventButtonView(label: "Product Viewed", badges: ["product_id", "price"], variant: .purple) {
                analyticsService.track(AnalyticsEvents.ProductDetails.productViewed(
                    productId: "SKU-12345",
                    productPrice: "$99.99"
                ))
            }
            EventButtonView(label: "Add to Cart", badges: ["options[]"], variant: .purple) {
                analyticsService.track(AnalyticsEvents.ProductDetails.addToCartTapped(
                    productId: "SKU-12345",
                    productPrice: "$99.99",
                    selectedOptions: [1, 3, 5]
                ))
            }
            EventButtonView(label: "Gallery Swiped", badges: ["index"], variant: .purple) {
                analyticsService.track(AnalyticsEvents.ProductDetails.imageGallerySwiped(
                    imageIndex: 2
                ))
            }
            EventButtonView(label: "Checkout Started", badges: ["cart_items[]"], variant: .purple) {
                analyticsService.track(AnalyticsEvents.ProductDetails.checkoutStarted(
                    cartId: "cart_abc",
                    cartValue: 199.98,
                    cartItems: [
                        ["id": "SKU-12345", "qty": 2],
                        ["id": "SKU-67890", "qty": 1]
                    ]
                ))
            }
        }
    }
    
    private var checkoutCard: some View {
        EventCardView(title: "Checkout Events", icon: "💳", variant: .green) {
            EventButtonView(label: "Payment (Card)", badges: ["payment_method"], variant: .green) {
                analyticsService.track(AnalyticsEvents.Checkout.paymentMethodSelected(
                    paymentMetadata: [["type": "visa", "last4": "4242"]],
                    paymentMethod: .card,
                    supportedMethods: ["card", "cash", "apple_pay"]
                ))
            }
            EventButtonView(label: "Payment (Cash)", badges: ["payment_method"], variant: .green) {
                analyticsService.track(AnalyticsEvents.Checkout.paymentMethodSelected(
                    paymentMetadata: [],
                    paymentMethod: .cash,
                    supportedMethods: ["card", "cash"]
                ))
            }
            EventButtonView(label: "Checkout Completed", badges: ["order_id"], variant: .green) {
                analyticsService.track(AnalyticsEvents.Checkout.checkoutCompleted(
                    totalAmount: 19998,
                    orderSummary: "2 items",
                    orderId: "ORD-2024-001"
                ))
            }
        }
    }
}

#Preview {
    ContentView()
}
