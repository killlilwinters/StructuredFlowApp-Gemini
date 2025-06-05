//
//  CoreFunctionsView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct CoreFunctionsView: View {
    @State var viewModel: CoreFunctionsViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Core Functions").font(.title) // ...
            Image(systemName: "puzzlepiece.extension.fill") // ...
            Text("This is where the main features ...") // ...

            // NavigationLink for declarative navigation
            NavigationLink("Go to Next Feature", value: MainPath.nextFeature)
                .buttonStyle(.borderedProminent)
            
            Button("Navigate to Settings (Programmatic)") {
                viewModel.navigateToSettingsProgrammatically()
            }
            .buttonStyle(.bordered)
            Spacer()
        }
        .padding().navigationTitle("Core Functions")
    }
}
