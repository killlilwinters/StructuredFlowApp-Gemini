//
//  SettingsViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI // Import SwiftUI for Binding

@MainActor
@Observable
class SettingsViewModel {
    struct State: Equatable {
        var notificationsEnabled = true
        var darkModeEnabled = false
        var appVersion: String = "1.0.2" // Example
        var buildNumber: String = "105"  // Example
        var privacyPolicyURL: URL? = URL(string: "https://www.example.com/privacy")
        var termsOfServiceURL: URL? = URL(string: "https://www.example.com/terms")
    }

    private(set) var state: State

    init(initialState: State = State()) {
        self.state = initialState
        // Load any persisted settings here and update state
        print("SettingsViewModel initialized.")
    }

    // --- Setters for UI-bound properties via custom Binding ---
    // These will be used by the custom Binding in the View

    func setNotificationsEnabled(_ enabled: Bool) {
        state.notificationsEnabled = enabled
        // TODO: Persist this setting
        print("Notifications enabled via ViewModel: \(enabled)")
    }

    func setDarkModeEnabled(_ enabled: Bool) {
        state.darkModeEnabled = enabled
        // TODO: Persist this setting and apply theme if needed
        print("Dark Mode enabled via ViewModel: \(enabled)")
    }

    // --- Actions ---
    func contactSupport() {
        print("Contact support action triggered in ViewModel")
        // TODO: Implement mail composer or navigation to support screen
        // For example, using mailto URL:
        // if let url = URL(string: "mailto:support@example.com?subject=App%20Support%20Request") {
        //     #if canImport(UIKit)
        //     UIApplication.shared.open(url)
        //     #endif
        // }
    }
}
