//
//  CategoryDetails.ViewModel.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import SwiftUI

public extension CategoryDetails {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        public typealias Fact = Model.Fact
        
        // MARK: - Stored properties
        
        @Published var title: String
        @Published var facts: [Fact]
        
        // MARK: - Init
        
        public init(model: Model) {
            title = model.title
            facts = model.content
        }
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension CategoryDetails.ViewModel {
    
    static var preview: Self {
        .init(model: .init(title: "Test 1", description: "Test 1", imageURL: nil, order: 1, content: [
            .init(imageURL: nil, text: "Fact 1"),
            .init(imageURL: nil, text: "Fact 2"),
            .init(imageURL: nil, text: "Fact 3")
        ]))
    }
}
#endif
