//
//  CategoryListView.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import SwiftUI

public struct CategoryListView: View {
    
    @StateObject private var viewModel: ViewModel
    
    public init(viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
    }
    
    public var body: some View {
        Text("List goes here")
            .padding()
    }
}
