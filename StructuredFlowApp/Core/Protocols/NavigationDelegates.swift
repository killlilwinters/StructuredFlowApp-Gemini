//
//  NavigationDelegates.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

// --- App Level Flow Delegates ---
@MainActor
protocol LaunchNavigationDelegate: AnyObject {
    func launchDidRequestOnboarding()
    func launchDidRequestLogin()
    func launchDidRequestMainApp()
}

@MainActor
protocol OnboardingCompletionDelegate: AnyObject {
    func onboardingDidComplete(navigateToLogin: Bool)
}

@MainActor
protocol LoginSuccessDelegate: AnyObject {
    func loginDidSucceed()
}

@MainActor
protocol MainFlowNavigationDelegate: AnyObject {
    func mainFlowDidRequestLogout()
}

// --- Onboarding Step Flow Delegate ---
// For communication from individual onboarding step VMs to OnboardingCoordinatorViewModel
@MainActor
protocol OnboardingStepFlowDelegate: AnyObject {
    func onboardingStepDidRequestNext()
    func onboardingStepDidRequestFinish() // For the final step
}

// --- Main Flow Screen Navigator Delegate ---
// For communication from individual main screens to MainCoordinatorViewModel
@MainActor
protocol MainFlowScreenNavigator: AnyObject {
    func screenDidRequestNavigationTo(path: MainPath)
    func screenDidRequestLogout()
}
