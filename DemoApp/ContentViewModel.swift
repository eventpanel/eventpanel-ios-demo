//
//  ContentView.swift
//  DemoApp
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    func onAppear() {
        print(AnalyticsEvents.onboardingScreenShown(origin: .facebook))
    }
}
