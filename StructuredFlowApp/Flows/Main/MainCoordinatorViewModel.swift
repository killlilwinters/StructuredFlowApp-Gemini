//
//  MainCoordinatorViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

@MainActor // This ViewModel manages UI state (navigationPath) and creates other UI ViewModels
@Observable
class MainCoordinatorViewModel {
    // State struct to hold UI-related properties for this coordinator
    struct State { // Not directly Equatable because NavigationPath can be complex to compare for equality efficiently
        var navigationPath = NavigationPath()
    }

    private(set) var state: State
    private weak var navigationDelegate: MainFlowNavigationDelegate? // To communicate "logout" upwards
    private let factory: MainFlowBusinessLogicFactory // To create ViewModels for the screens in this flow

    init(
        initialState: State = State(), // Allows injecting initial state, defaults to empty path
        navigationDelegate: MainFlowNavigationDelegate?,
        factory: MainFlowBusinessLogicFactory
    ) {
        self.state = initialState
        self.navigationDelegate = navigationDelegate
        self.factory = factory
        print("MainCoordinatorViewModel initialized.")
    }

    // Method to update navigationPath.
    // This is essential for the NavigationStack's two-way binding (`$viewModel.state.navigationPath`
    // would not work directly with private(set) state without a custom binding or a setter like this).
    func setNavigationPath(_ path: NavigationPath) {
        // You could add checks here if path updates are frequent and potentially redundant,
        // but NavigationPath itself has some internal optimizations.
        state.navigationPath = path
    }

    // --- Factory methods for screen ViewModels using the injected factory ---
    func makeDashboardViewModel() -> MainDashboardViewModel {
        // The navigator for MainDashboardViewModel is self (MainCoordinatorViewModel)
        factory.makeMainDashboardViewModel(navigator: self)
    }

    func makeCoreFunctionsViewModel() -> CoreFunctionsViewModel {
        factory.makeCoreFunctionsViewModel(navigator: self)
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        // SettingsViewModel might not need a navigator if it doesn't trigger main flow navigation
        factory.makeSettingsViewModel()
    }
    
    func makeAccountViewModel() -> AccountViewModel {
        // AccountViewModel might not need a navigator
        factory.makeAccountViewModel()
    }

    func makeNextFeatureViewModel() -> NextFeatureViewModel {
        // NextFeatureViewModel might not need a navigator
        factory.makeNextFeatureViewModel()
    }
}

// Conformance to MainFlowScreenNavigator for child screens to communicate navigation/logout requests
extension MainCoordinatorViewModel: MainFlowScreenNavigator {
    func screenDidRequestNavigationTo(path: MainPath) {
        // All programmatic navigation changes within this flow append to the state's path
        print("MainCoordinatorViewModel: Navigating to \(path)")
        state.navigationPath.append(path)
    }

    func screenDidRequestLogout() {
        // Delegate the logout request to the higher-level app flow coordinator
        print("MainCoordinatorViewModel: Logout requested, delegating up.")
        navigationDelegate?.mainFlowDidRequestLogout()
    }
}
