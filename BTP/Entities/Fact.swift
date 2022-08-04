//
//  Fact.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import Foundation

public struct Fact: Hashable, Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "image"
        case text = "fact"
    }
    
    public let imageURL: URL?
    public let text: String
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension Fact {
    
    static func preview(_ index: Int) -> Self {
        .init(imageURL: nil, text: "Fact \(index)")
    }
}

extension Array where Element == Fact {
    
    static func preview(_ count: Int = 3) -> Self {
        (1...count).map(Fact.preview)
    }
}
#endif
