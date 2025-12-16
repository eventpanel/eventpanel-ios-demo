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
                        onboardingCard
                        profileCard
                        loadingCard
                        parameterTypesCard
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 40)
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
    
    private var onboardingCard: some View {
        EventCardView(title: "Onboarding Events", icon: "🚀", variant: .cyan) {
            EventButtonView(label: "Screen Shown (Facebook)", badges: ["origin"], variant: .cyan) {
                analyticsService.track(AnalyticsEvents.onboardingScreenShown(origin: .facebook))
            }
            EventButtonView(label: "Screen Shown (Insta)", badges: ["origin"], variant: .cyan) {
                analyticsService.track(AnalyticsEvents.onboardingScreenShown(origin: .insta))
            }
            EventButtonView(label: "Screen Shown (No Origin)", badges: [], variant: .cyan) {
                analyticsService.track(AnalyticsEvents.onboardingScreenShown(origin: nil))
            }
        }
    }
    
    private var profileCard: some View {
        EventCardView(title: "Profile Events", icon: "👤", variant: .purple) {
            EventButtonView(label: "Profile Screen Shown", badges: [], variant: .purple) {
                analyticsService.track(AnalyticsEvents.ProfileScreen.profileScreenShown())
            }
            EventButtonView(label: "Profile Screen Closed", badges: [], variant: .purple) {
                analyticsService.track(AnalyticsEvents.ProfileScreen.profileScreenClosed())
            }
        }
    }
    
    private var loadingCard: some View {
        EventCardView(title: "Loading Events", icon: "⏳", variant: .green) {
            EventButtonView(label: "Loading (Moscow)", badges: ["city_id"], variant: .green) {
                analyticsService.track(AnalyticsEvents.loadingScreenShown(cityId: "Moscow-123"))
            }
            EventButtonView(label: "Loading (New York)", badges: ["city_id"], variant: .green) {
                analyticsService.track(AnalyticsEvents.loadingScreenShown(cityId: "NYC-456"))
            }
            EventButtonView(label: "Loading (No City)", badges: [], variant: .green) {
                analyticsService.track(AnalyticsEvents.loadingScreenShown(cityId: nil))
            }
        }
    }
    
    private var parameterTypesCard: some View {
        EventCardView(title: "Parameter Types", icon: "📋", variant: .orange) {
            VStack(alignment: .leading, spacing: 12) {
                ParameterTypeRow(icon: "🔹", type: "Enum", example: "Origin: Facebook, Insta")
                ParameterTypeRow(icon: "🔸", type: "Optional String", example: "cityId: String?")
                ParameterTypeRow(icon: "⚪", type: "No Parameters", example: "profileScreenShown()")
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    ContentView()
}
