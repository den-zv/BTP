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
        .background(Color.cyan)
        .cornerRadius(12)
    }
}

// MARK: - ViewState

public extension CategoryView {
    
    struct ViewState: Hashable {
        
        let imageURL: URL?
        let title: String
        let subtitle: String
    }
}

// MARK: - Previews

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryView(viewState: .init(imageURL: nil, title: "Title", subtitle: "Subtitle"))
            .previewLayout(.fixed(width: 300, height: 120))
    }
}
