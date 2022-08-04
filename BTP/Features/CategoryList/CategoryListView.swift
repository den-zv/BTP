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
            contentView()
            loader()
            retryView()
        }
        .onAppear {
            viewModel.loadData()
        }
        .alert(item: $viewModel.alert) { alert($0) }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private func contentView() -> some View {
        NavigationView {
            List(viewModel.results) { model in
                NavigationLink(
                    destination: CategoryDetailsView(
                        viewModel: viewModel.categoryDetailsViewModel(for: model)
                    ),
                    tag: model,
                    selection: .init(
                        get: { viewModel.selection },
                        set: { viewModel.update(selection: $0) }
                    )
                ) {
                    CategoryView(viewState: .init(model: model))
                        .frame(minHeight: 100)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Categories")
        }
    }
    
    @ViewBuilder
    private func loader() -> some View {
        if viewModel.isLoadingShown {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .green))
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
    
    private func alert(_ alert: CategoryList.ViewModel.Alert) -> Alert {
        switch alert {
        case .comingSoon:
            return .init(
                title: Text("Coming soon"),
                message: Text("There are no any content yet")
            )
        case .advertisement:
            return .init(
                title: Text("Show Ad?"),
                primaryButton: .default(Text("Sure!"), action: { viewModel.showAd() }),
                secondaryButton: .cancel()
            )
        }
    }
}

// MARK: - Previews

struct CategoryListView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryListView(viewModel: .preview)
    }
}
