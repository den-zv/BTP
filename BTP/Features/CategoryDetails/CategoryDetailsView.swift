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
        Text("Hey")
    }
}

// MARK: - Previews

struct CategoryDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryDetailsView(viewModel: .preview)
    }
}
