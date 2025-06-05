//
//  MainPath.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

enum MainPath: Identifiable, Hashable, Codable {
    case coreFunctions
    case settings
    case account
    case nextFeature // For the "NextFlow" branching from CoreFunctions

    var id: Self { self }
}
