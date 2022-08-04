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
        
        // MARK: - Stored properties
        
        @Published var title: String
        @Published var facts: [Fact]
        
        @Published var selection = 0
        
        private let environment: Environment
        
        // MARK: - Computed properties
        
        var showsPreviousButton: Bool {
            selection > 0
        }
        
        var showsNextButton: Bool {
            selection < facts.count - 1
        }
        
        // MARK: - Init
        
        public init(model: Model, environment: Environment) {
            title = model.title
            facts = model.content
            self.environment = environment
        }
        
        // MARK: - Public methods
        
        func showPrevious() {
            selection = max(selection - 1, 0)
        }
        
        func showNext() {
            selection = min(selection + 1, facts.count - 1)
        }
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension CategoryDetails.ViewModel {
    
    static var preview: Self {
        .init(model: .preview(1), environment: .init())
    }
}
#endif
