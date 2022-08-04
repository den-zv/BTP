//
//  Category.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import Foundation

public struct Category: Hashable, Decodable {
    
    public enum Status: String, Decodable {
        case paid
        case free
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURL = "image"
        case order
        case status
        case content
    }
    
    public let title: String
    public let description: String
    public let imageURL: URL?
    public let order: Int
    public let status: Status
    public let content: [Fact]
    
    public var isComingSoon: Bool {
        content.isEmpty
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension Category {
    
    static func preview(_ index: Int) -> Self {
        .init(
            title: "Title \(index)",
            description: "Description \(index)",
            imageURL: nil,
            order: index,
            status: .free,
            content: .preview()
        )
    }
}

extension Array where Element == Category {
    
    static func preview(_ count: Int = 5) -> Self {
        (1...count).map(Category.preview)
    }
}
#endif
