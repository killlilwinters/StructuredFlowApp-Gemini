//
//  AppFlowCoordinatorView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct AppFlowCoordinatorView: View {
    // ViewModel is owned and instantiated here.
    // The instantiation of AppFlowCoordinatorViewModel and its factory parameters
    // happens on the MainActor because @State property wrappers initialize
    // their wrapped values on the MainActor when used in a View.
    @State private var viewModel = AppFlowCoordinatorViewModel(
        // initialState can have its default from AppFlowCoordinatorViewModel's init
        // Or be explicitly set: initialState: AppFlowCoordinatorViewModel.State(),
        appFactory: AppBusinessLogicFactory(),
        onboardingFactory: OnboardingFlowBusinessLogicFactory(),
        mainFactory: MainFlowBusinessLogicFactory()
    )

    var body: some View {
        Group {
            switch viewModel.state.currentAppFlow {
            case .launch:
                LaunchView(viewModel: viewModel.makeLaunchViewModel())
            case .onboarding:
                OnboardingCoordinatorView(viewModel: viewModel.makeOnboardingCoordinatorViewModel())
            case .login:
                LoginView(viewModel: viewModel.makeLoginViewModel())
            case .main:
                MainCoordinatorView(viewModel: viewModel.makeMainCoordinatorViewModel())
            }
        }
        .animation(.default, value: viewModel.state.currentAppFlow)
        .task {
            // This .task modifier runs when the view appears.
            // If you have async setup for the initial state:
            // Example: await viewModel.loadPersistedAppState()
            // After loading, you might re-evaluate the flow:
            // viewModel.determineInitialFlowAfterLaunch()
            // For this demo, LaunchView buttons usually drive the first significant flow change.
            print("AppFlowCoordinatorView appeared. Initial flow from VM state: \(viewModel.state.currentAppFlow)")
        }
    }
}

#Preview {
    AppFlowCoordinatorView()
}
