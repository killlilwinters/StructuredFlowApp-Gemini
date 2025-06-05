//
//  LaunchView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct LaunchView: View {
    // ViewModel is provided by the AppFlowCoordinatorViewModel via its factory
    @State var viewModel: LaunchViewModel

    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome to AppName")
                .font(.largeTitle)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)


            Button("Start Onboarding") {
                viewModel.goToOnboarding()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)


            Button("I already have an account (Login)") {
                viewModel.goToLogin()
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity)

            Spacer().frame(height: 50) // Add some space
            
            Button("Skip to Main (Dev Only)") {
                viewModel.goToMainApp()
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(40) // Add more padding to the VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Make VStack take full space
        .background(Color(uiColor: .systemGroupedBackground)) // Example background
    }
}


#Preview {
    // 1. Dummy delegate for LaunchNavigationDelegate
    class DummyLaunchNavDelegate: LaunchNavigationDelegate {
        func launchDidRequestOnboarding() { print("Preview: Launch requesting Onboarding") }
        func launchDidRequestLogin() { print("Preview: Launch requesting Login") }
        func launchDidRequestMainApp() { print("Preview: Launch requesting Main App") }
    }

    // 2. Create an instance of LaunchViewModel for the preview
    // If LaunchViewModel had an initialState parameter, it would be:
    // let previewViewModel = LaunchViewModel(initialState: .init(), navigationDelegate: DummyLaunchNavDelegate())
    // Assuming the LaunchViewModel's init signature matches the one shown in comments above:
    let previewViewModel = LaunchViewModel(navigationDelegate: DummyLaunchNavDelegate())

    return LaunchView(viewModel: previewViewModel)
}
