//
//  CategoryDetailsView.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import SwiftUI

public struct CategoryDetailsView: View {
    
    // MARK: - Stored properties
    
    @StateObject private var viewModel: CategoryDetails.ViewModel
    
    // MARK: - Init
    
    public init(viewModel: @autoclosure @escaping () -> CategoryDetails.ViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack {
            tabView()
            buttonsView()
            Spacer(minLength: 50)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private func tabView() -> some View {
        TabView(selection: $viewModel.selection) {
            ForEach(Array(viewModel.facts.enumerated()), id: \.element) { offset, element in
                tab(tag: offset, model: element)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    @ViewBuilder
    private func tab(tag: Int, model: Fact) -> some View {
        VStack {
            AsyncImage(
                url: model.imageURL,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                },
                placeholder: {
                    Image(systemName: "camera.fill")
                }
            )
            .frame(height: 200)
            
            HStack {
                Spacer()
                Text(model.text)
                Spacer()
            }
            .padding()
        }
        .background(Color.cyan.opacity(0.3))
        .cornerRadius(12)
        .padding()
        .tag(tag)
    }
    
    @ViewBuilder
    private func buttonsView() -> some View {
        HStack {
            if viewModel.showsPreviousButton {
                Button {
                    withAnimation {
                        viewModel.showPrevious()
                    }
                } label: {
                    Image(systemName: "chevron.left.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            Spacer()
            if viewModel.showsNextButton {
                Button {
                    withAnimation {
                        viewModel.showNext()
                    }
                } label: {
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .frame(height: 40)
        .padding(.horizontal, 30)
    }
}

// MARK: - Previews

struct CategoryDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryDetailsView(viewModel: .preview)
    }
}
