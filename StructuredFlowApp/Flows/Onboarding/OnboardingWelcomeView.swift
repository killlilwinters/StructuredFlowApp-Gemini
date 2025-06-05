//
//  OnboardingWelcomeView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    @State var viewModel: OnboardingWelcomeViewModel // Changed from @Bindable

    var body: some View {
        VStack(spacing: 20) {
            // ... UI elements ...
            Image(systemName: "figure.wave") // ...
            Text("Welcome!").font(.largeTitle) // ...
            Text("Let's get you set up.") // ...
            Spacer()
            Button("Next") { viewModel.nextButtonTapped() } // ...
                .buttonStyle(.borderedProminent)
                .padding()
        }
        .padding()
    }
}
