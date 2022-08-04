//
//  FavoritesEnvironment.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import Combine
import Foundation

public struct FavoritesEnvironment {
    
    public var favorites: () -> AnyPublisher<Category, Never>
    public var addFact: (Fact) -> Void
    public var removeFact: (Fact) -> Void
}

// MARK: - Live

public extension FavoritesEnvironment {
    
    static var live: Self {
        let environment: Self = .init(
            favorites: { favorites() },
            addFact: { addFact($0) },
            removeFact: { removeFact($0) }
        )
        return environment
    }
    
    private static func favorites() -> AnyPublisher<Category, Never> {
        favoritesSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    private static func addFact(_ fact: Fact) {
        let value = favoritesSubject.value
        var facts = value.content
        facts.append(fact)
        
        favoritesSubject.value = .init(
            title: value.title,
            description: value.description,
            imageURL: value.imageURL,
            order: value.order,
            status: value.status,
            content: facts
        )
    }
    
    private static func removeFact(_ fact: Fact) {
        let value = favoritesSubject.value
        var facts = value.content
        
        guard let index = facts.firstIndex(of: fact) else {
            return
        }
        
        facts.remove(at: index)
        
        favoritesSubject.value = .init(
            title: value.title,
            description: value.description,
            imageURL: value.imageURL,
            order: value.order,
            status: value.status,
            content: facts
        )
    }
    
    private static let favoritesSubject: CurrentValueSubject<Category, Never> = .init(.init(
        title: "Favorites",
        description: "Store your favorite facts within this category",
        imageURL: nil,
        order: -1,
        status: .free,
        content: []
    ))
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension FavoritesEnvironment {
    
    static var preview: Self {
        .init(
            favorites: {
                Future { promise in
                    promise(.success(.preview(-1)))
                }
                .eraseToAnyPublisher()
            },
            addFact: { _ in },
            removeFact: { _ in }
        )
    }
}

#endif
