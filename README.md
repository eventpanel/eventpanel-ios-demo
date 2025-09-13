# EventPanel iOS Demo

A demonstration iOS app showcasing EventPanel CLI integration for type-safe analytics event code generation.

## Overview

This demo app demonstrates how to integrate EventPanel CLI into an iOS project to generate type-safe analytics events from YAML configuration files.

## Features

- 🎯 **Type-Safe Analytics**: Generated analytics events with compile-time safety
- 📝 **YAML Configuration**: Event definitions managed through `EventPanel.yaml`
- 🔄 **Code Generation**: Automated Swift code generation from event schemas

## Project Structure

```
DemoApp/
├── Analytics/
│   ├── AnalyticsEvent.swift          # Base analytics event protocol
│   └── GeneratedAnalyticsEvents.swift # Generated event code
├── ContentView.swift                 # Main SwiftUI view
├── ContentViewModel.swift           # View model with analytics
└── DemoAppApp.swift                 # App entry point
```

## Generated Analytics Events

The app includes several example analytics events:

- **Profile Screen Events**: `profileScreenShown()`, `profileScreenClosed()`
- **Onboarding Events**: `onboardingScreenShown(origin:)` with custom `Origin` enum
- **Loading Events**: `loadingScreenShown(cityId:)` with optional parameters

## Usage

### Setup

1. **Install EventPanel CLI**:
   ```bash
   brew tap eventpanel/eventpanel
   brew install eventpanel
   ```

2. **Generate Analytics Code**:
   ```bash
   eventpanel generate
   ```
   
   **Note**: Code generation is automatically run during Xcode builds via the "GenerateAnalytics" build phase. The build script automatically detects the EventPanel CLI installation path (Homebrew or manual installation).

### Configuration

The app uses `EventPanel.yaml` to define analytics events:

```yaml
language: swift
plugin:
  swiftgen:
    documentation: true
    generatedEventsPath: DemoApp/Analytics/GeneratedAnalyticsEvents.swift
    eventTypeName: AnalyticsEvent
    namespace: AnalyticsEvents
events:
  - id: 7MJ5DRg_a7xrf8ZzeKmDb  # Onboarding Screen Shown
    version: 3
  - id: iarZdDsKOfAmxMN3rfTtd  # Loading Screen Shown
    version: 4
  - id: akn-KX7E0Of8d2L_PLBbW  # Profile Screen Shown
    version: 1
  - id: Z0EhrWP91qyabKCziBJBQ  # Profile Screen Closed
    version: 1
```

## Example Usage

```swift
// Track a profile screen view
let event = AnalyticsEvents.ProfileScreen.profileScreenShown()
analytics.track(event)

// Track onboarding with origin
let onboardingEvent = AnalyticsEvents.onboardingScreenShown(origin: .facebook)
analytics.track(onboardingEvent)

// Track loading with city ID
let loadingEvent = AnalyticsEvents.loadingScreenShown(cityId: "NYC")
analytics.track(loadingEvent)
```

## Learn More

- 🚀 [EventPanel CLI](https://github.com/eventpanel/eventpanel-cli)
- 🌐 [EventPanel Website](https://eventpanel.net)
