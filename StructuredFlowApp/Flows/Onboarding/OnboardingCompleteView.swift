//
//  OnboardingCompleteView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct OnboardingCompleteView: View {
    @State var viewModel: OnboardingCompleteViewModel

    var body: some View {
        VStack(spacing: 20) {
            // ... UI elements ...
            Image(systemName: "checkmark.circle.fill") // ...
            Text("All Set!").font(.largeTitle) // ...
            Text("You're ready to get started.") // ...
            Spacer()
            Button("Finish Onboarding") { viewModel.finishButtonTapped() } // ...
                .buttonStyle(.borderedProminent)
                .padding()
        }
        .padding()
    }
}
