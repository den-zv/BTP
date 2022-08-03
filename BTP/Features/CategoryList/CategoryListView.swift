//
//  CategoryListView.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import SwiftUI

public struct CategoryListView: View {
    
    // MARK: - Stored properties
    
    @StateObject private var viewModel: CategoryList.ViewModel
    
    // MARK: - Init
    
    public init(viewModel: @autoclosure @escaping () -> CategoryList.ViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            loader()
            retryView()
        }
        .padding()
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private func contentView() -> some View {}
    
    @ViewBuilder
    private func loader() -> some View {
        if viewModel.isLoadingShown {
            ProgressView()
        }
    }
    
    @ViewBuilder
    private func retryView() -> some View {
        if let retryText = viewModel.retryText {
            VStack(spacing: 300) {
                Text(retryText)
                Button("Retry") {
                    viewModel.loadData()
                }
            }
        }
    }
}

// MARK: - Previews

struct CategoryListView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryListView(viewModel: .preview)
    }
}
