//
//  CategoryList.ViewModel.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import SwiftUI

public extension CategoryList {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        public enum Mode {
            case idle
            case loading
            case loaded([Model])
            case error(Error)
        }
        
        // MARK: - Stored properties
        
        @Published var mode: Mode
        
        // MARK: - Computed properties
        
        var results: [Model] {
            switch mode {
            case .idle, .loading, .error:
                return []
            case .loaded(let results):
                return results
                    .sorted { $0.order < $1.order }
            }
        }
        
        var isLoadingShown: Bool {
            switch mode {
            case .idle, .loaded, .error:
                return false
            case .loading:
                return true
            }
        }
        
        var retryText: String? {
            // TODO: move texts to strings files
            switch mode {
            case .loaded(let results) where results.isEmpty:
                return "No results"
            case .error:
                return "Error occured"
            case .idle, .loading, .loaded:
                return nil
            }
        }
        
        // MARK: - Init
        
        public init(mode: Mode) {
            self.mode = mode
        }
        
        // MARK: - Public methods
        
        func loadData() {
            switch mode {
            case .idle, .error:
                break
            case .loading, .loaded:
                return
            }
            
            mode = .loading
            
            // TODO: pass proper call here
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.mode = .loaded(.preview(5).shuffled())
            }
        }
        
        func categoryDetailsViewModel(for model: Model) -> CategoryDetails.ViewModel {
            .init(model: model)
        }
    }
}

// MARK: - Initial

public extension CategoryList.ViewModel {
    
    static var initial: Self {
        .init(mode: .idle)
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension CategoryList.ViewModel {
    
    static var preview: Self {
        .init(mode: .loaded(.preview(3)))
    }
}
#endif
