//
//  CategoryList.ViewModel.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import SwiftUI
import Combine

public extension CategoryList {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        public enum Mode {
            case idle
            case loading
            case loaded([Model])
            case error(Error)
        }
        
        public enum Alert: Hashable, Identifiable {
            case comingSoon
            case advertisement(Model)
            
            public var id: Self { self }
        }
        
        // MARK: - Stored properties
        
        @Published private var mode: Mode
        @Published private(set) var selection: Model?
        @Published var alert: Alert?
        @Published private var isShowingAd = false
        
        private let environment: Environment
        
        private var cancellables: Set<AnyCancellable> = []
        
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
            if isShowingAd {
                return true
            }
            
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
        
        public init(mode: Mode, environment: Environment) {
            self.mode = mode
            self.environment = environment
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
            
            var result: [Model] = []
            environment
                .api
                .fetchCategories()
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard let self = self else {
                            return
                        }
                        switch completion {
                        case .finished:
                            self.mode = .loaded(result)
                        case .failure(let error):
                            self.mode = .error(error)
                        }
                    },
                    receiveValue: { value in
                        result = value
                    }
                )
                .store(in: &cancellables)
        }
        
        func update(selection: Model?) {
            guard let selection = selection else {
                self.selection = nil
                return
            }

            guard !selection.isComingSoon else {
                self.selection = nil
                self.alert = .comingSoon
                return
            }
            
            switch selection.status {
            case .free:
                self.selection = selection
            case .paid:
                self.selection = nil
                self.alert = .advertisement(selection)
            }
        }
        
        func showAd(_ model: Model) {
            guard !isShowingAd else {
                return
            }
            
            isShowingAd = true
            
            environment
                .ads
                .showAd()
                .sink { [weak self] isWatched in
                    guard let self = self else {
                        return
                    }
                    
                    guard isWatched else {
                        self.isShowingAd = false
                        return
                    }
                    
                    self.isShowingAd = false
                    self.selection = model
                }
                .store(in: &cancellables)
        }
        
        func categoryDetailsViewModel(for model: Model) -> CategoryDetails.ViewModel {
            // we can pass services between view models here if needed
            .init(model: model, environment: .init())
        }
    }
}

// MARK: - Initial

public extension CategoryList.ViewModel {
    
    static func initial(environment: CategoryList.Environment) -> Self {
        .init(mode: .idle, environment: environment)
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension CategoryList.ViewModel {
    
    static var preview: Self {
        .init(mode: .idle, environment: .init(api: .preview, ads: .preview))
    }
}
#endif
