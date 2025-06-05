//
//  AppBusinessLogicFactory.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

@MainActor // Ensure this is present
class AppBusinessLogicFactory {
    // Default initializer is fine here as the class itself is @MainActor
    init() {}

    func makeLaunchViewModel(navigationDelegate: LaunchNavigationDelegate) -> LaunchViewModel {
        LaunchViewModel(navigationDelegate: navigationDelegate)
    }

    func makeOnboardingCoordinatorViewModel(
        completionDelegate: OnboardingCompletionDelegate,
        onboardingFactory: OnboardingFlowBusinessLogicFactory
    ) -> OnboardingCoordinatorViewModel {
        OnboardingCoordinatorViewModel(completionDelegate: completionDelegate, factory: onboardingFactory)
    }

    func makeLoginViewModel(successDelegate: LoginSuccessDelegate) -> LoginViewModel {
        LoginViewModel(successDelegate: successDelegate)
    }

    func makeMainCoordinatorViewModel(
        navigationDelegate: MainFlowNavigationDelegate,
        mainFactory: MainFlowBusinessLogicFactory
    ) -> MainCoordinatorViewModel {
        MainCoordinatorViewModel(navigationDelegate: navigationDelegate, factory: mainFactory)
    }
}
