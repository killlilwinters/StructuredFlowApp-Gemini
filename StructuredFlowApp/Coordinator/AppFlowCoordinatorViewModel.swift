//
//  AppFlowCoordinatorViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

@MainActor // ViewModel for UI should be on MainActor
@Observable
class AppFlowCoordinatorViewModel {
    struct State: Equatable {
        var currentAppFlow: AppFlow = .launch
        var isAuthenticated: Bool = false
        var hasCompletedOnboarding: Bool = false
    }

    private(set) var state: State
    // These factories are @MainActor isolated, so their usage within this @MainActor VM is fine.
    private let appFactory: AppBusinessLogicFactory
    private let onboardingFactory: OnboardingFlowBusinessLogicFactory
    private let mainFactory: MainFlowBusinessLogicFactory

    // REMOVED default initializers for factories from the signature
    init(
        initialState: State = State(),
        appFactory: AppBusinessLogicFactory,
        onboardingFactory: OnboardingFlowBusinessLogicFactory,
        mainFactory: MainFlowBusinessLogicFactory
    ) {
        self.state = initialState
        self.appFactory = appFactory
        self.onboardingFactory = onboardingFactory
        self.mainFactory = mainFactory
        // Commented out for clarity, as per your image.
        // In a real app, you'd load persisted state here and update self.state
        // For example:
        // Task {
        //     await loadPersistedAppState() // This method would be async
        //     determineInitialFlowAfterLaunch() // Then determine the flow
        // }
        print("AppFlowCoordinatorViewModel initialized. Current flow: \(self.state.currentAppFlow)")
    }
    
    // Example async state loading (if needed)
    // private func loadPersistedAppState() async {
    //     // Replace with actual async calls to Keychain/UserDefaults etc.
    //     // try? await Task.sleep(for: .milliseconds(100)) // Simulate delay
    //     // self.state.isAuthenticated = await AuthService.shared.getAuthStatus()
    //     // self.state.hasCompletedOnboarding = await UserProgressService.shared.getOnboardingStatus()
    //     print("AppFlowCoordinatorViewModel: Simulated loading of persisted app state.")
    // }


    // --- ViewModel Factory Methods ---
    func makeLaunchViewModel() -> LaunchViewModel {
        appFactory.makeLaunchViewModel(navigationDelegate: self)
    }

    func makeOnboardingCoordinatorViewModel() -> OnboardingCoordinatorViewModel {
        appFactory.makeOnboardingCoordinatorViewModel(
            completionDelegate: self,
            onboardingFactory: self.onboardingFactory
        )
    }

    func makeLoginViewModel() -> LoginViewModel {
        appFactory.makeLoginViewModel(successDelegate: self)
    }

    func makeMainCoordinatorViewModel() -> MainCoordinatorViewModel {
        appFactory.makeMainCoordinatorViewModel(
            navigationDelegate: self,
            mainFactory: self.mainFactory
        )
    }
    
    // --- State Mutation for Flow ---
    private func updateCurrentAppFlow(_ newFlow: AppFlow) {
        state.currentAppFlow = newFlow
        print("AppFlow changed to: \(newFlow)")
    }

    private func setUserAuthenticated(_ authenticated: Bool) {
        state.isAuthenticated = authenticated
        print("User authenticated: \(authenticated)")
    }

    private func setOnboardingCompleted(_ completed: Bool) {
        state.hasCompletedOnboarding = completed
        print("Onboarding completed: \(completed)")
    }

    // --- Logic to determine flow (example) ---
    func determineInitialFlowAfterLaunch() {
        // This logic would typically be called after any async state loading finishes
        if !state.isAuthenticated {
            if !state.hasCompletedOnboarding {
                updateCurrentAppFlow(.onboarding)
            } else {
                updateCurrentAppFlow(.login)
            }
        } else {
             if !state.hasCompletedOnboarding {
                updateCurrentAppFlow(.onboarding)
            } else {
                updateCurrentAppFlow(.main)
            }
        }
    }
}

// --- Delegate Conformance (updates state via methods) ---
extension AppFlowCoordinatorViewModel: LaunchNavigationDelegate {
    func launchDidRequestOnboarding() {
        updateCurrentAppFlow(.onboarding)
    }
    func launchDidRequestLogin() {
        updateCurrentAppFlow(.login)
    }
    func launchDidRequestMainApp() {
        setUserAuthenticated(true)
        setOnboardingCompleted(true)
        updateCurrentAppFlow(.main)
    }
}

extension AppFlowCoordinatorViewModel: OnboardingCompletionDelegate {
    func onboardingDidComplete(navigateToLogin: Bool) {
        setOnboardingCompleted(true)
        if navigateToLogin {
            updateCurrentAppFlow(.login)
        } else {
            if state.isAuthenticated {
                updateCurrentAppFlow(.main)
            } else {
                 updateCurrentAppFlow(.login)
            }
        }
    }
}

extension AppFlowCoordinatorViewModel: LoginSuccessDelegate {
    func loginDidSucceed() {
        setUserAuthenticated(true)
        if state.hasCompletedOnboarding {
            updateCurrentAppFlow(.main)
        } else {
            updateCurrentAppFlow(.onboarding)
        }
    }
}

extension AppFlowCoordinatorViewModel: MainFlowNavigationDelegate {
    func mainFlowDidRequestLogout() {
        setUserAuthenticated(false)
        updateCurrentAppFlow(.login)
    }
}
