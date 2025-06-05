//
//  LoginViewModel.swift
//  StructuredFlowApp
//
//  Created by Maksym Horobets on 04.06.2025.
//

import Foundation

@MainActor
@Observable
class LoginViewModel {
    private weak var successDelegate: LoginSuccessDelegate?
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?

    init(successDelegate: LoginSuccessDelegate?) {
        self.successDelegate = successDelegate
    }

    func attemptLogin() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty."
            return
        }
        isLoading = true
        errorMessage = nil
        
        // Simulate network request
        try? await Task.sleep(for: .seconds(1.5))
        
        // Simulate success/failure
        // In a real app, use proper validation
        if email.lowercased() == "test@example.com" && password == "password" {
            print("Login successful.")
            successDelegate?.loginDidSucceed()
        } else {
            errorMessage = "Invalid email or password."
            print("Login failed.")
        }
        isLoading = false
    }
}
