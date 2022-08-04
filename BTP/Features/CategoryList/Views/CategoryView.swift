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
        ZStack {
            content()
            comingSoon()
        }
        .cornerRadius(12)
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private func content() -> some View {
        HStack(alignment: .center) {
            AsyncImage(
                url: viewState.imageURL,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipped()
                },
                placeholder: {
                    Image(systemName: "camera.fill")
                }
            )
            .frame(width: 70)
            
            VStack(alignment: .leading) {
                Text(viewState.title)
                    .bold()
                Text(viewState.subtitle)
                Spacer()
                if viewState.isPaid {
                    Text("🔒 Paid Content")
                        .foregroundColor(.accentColor)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.cyan.opacity(0.3))
    }
    
    @ViewBuilder
    private func comingSoon() -> some View {
        if viewState.isComingSoonShown {
            Color.black.opacity(0.6)
            Text("Coming soon")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .semibold))
                .rotationEffect(.degrees(7))
        }
    }
}

// MARK: - ViewState

public extension CategoryView {
    
    struct ViewState {
        
        let imageURL: URL?
        let title: String
        let subtitle: String
        let isPaid: Bool
        let isComingSoonShown: Bool
        
        init(model: CategoryList.Model) {
            imageURL = model.imageURL
            title = model.title
            subtitle = model.description
            switch model.status {
            case .free:
                isPaid = false
            case .paid:
                isPaid = true
            }
            isComingSoonShown = model.isComingSoon
        }
    }
}

// MARK: - Previews

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryView(viewState: .init(
            model: .preview(2)
        ))
        .previewLayout(.fixed(width: 300, height: 120))
    }
}
