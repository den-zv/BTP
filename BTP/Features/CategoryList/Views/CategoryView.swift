//
//  CategoryView.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import SwiftUI

public struct CategoryView: View {
    
    let viewState: ViewState
    
    // MARK: - Body
    
    public var body: some View {
        HStack(alignment: .center) {
            AsyncImage(
                url: viewState.imageURL,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                },
                placeholder: {
                    Image(systemName: "camera.fill")
                }
            )
            .frame(width: 70)
            
            VStack {
                Text(viewState.title)
                Text(viewState.subtitle)
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .background(Color.cyan.opacity(0.3))
        .cornerRadius(12)
    }
}

// MARK: - ViewState

public extension CategoryView {
    
    struct ViewState {
        
        let imageURL: URL?
        let title: String
        let subtitle: String
        
        init(model: CategoryList.Model) {
            imageURL = model.imageURL
            title = model.title
            subtitle = model.description
        }
    }
}

// MARK: - Previews

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryView(viewState: .init(
            model: .init(title: "Test 2", description: "Test 2", imageURL: nil, order: 2, content: [])
        ))
        .previewLayout(.fixed(width: 300, height: 120))
    }
}
