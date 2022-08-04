//
//  CategoryDetails.ViewModel.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import SwiftUI
import Combine

public extension CategoryDetails {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        // MARK: - Stored properties
        
        @Published var title: String
        @Published var facts: [Fact]
        @Published private var favorites: Model!
        
        @Published var selection = 0
        
        private let environment: Environment
        
        private var cancellables: Set<AnyCancellable> = []
        
        // MARK: - Computed properties
        
        var showsPreviousButton: Bool {
            selection > 0
        }
        
        var showsNextButton: Bool {
            selection < facts.count - 1
        }
        
        var isFavorited: Bool {
            guard !facts.isEmpty else {
                return false
            }
            return favorites.content.contains(facts[selection])
        }
        
        // MARK: - Init
        
        public init(model: Model, environment: Environment) {
            title = model.title
            facts = model.content
            self.environment = environment
            
            environment
                .favorites
                .favorites()
                .sink { [weak self] category in
                    self?.favorites = category
                }
                .store(in: &cancellables)
        }
        
        // MARK: - Public methods
        
        func showPrevious() {
            selection = max(selection - 1, 0)
        }
        
        func showNext() {
            selection = min(selection + 1, facts.count - 1)
        }
        
        func toggleFavorites() {
            guard !facts.isEmpty else {
                return
            }
            
            let fact = facts[selection]
            
            if favorites.content.contains(fact) {
                environment.favorites.removeFact(fact)
            } else {
                environment.favorites.addFact(fact)
            }
        }
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension CategoryDetails.ViewModel {
    
    static var preview: Self {
        .init(model: .preview(1), environment: .init(favorites: .preview))
    }
}
#endif
