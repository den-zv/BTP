//
//  CategoryListView.ViewModel.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import SwiftUI

public extension CategoryListView {
    
    @MainActor
    final class ViewModel: ObservableObject {}
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension CategoryListView.ViewModel {
    
    static var preview: Self {
        .init()
    }
}
#endif
