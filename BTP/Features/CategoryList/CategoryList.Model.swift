//
//  CategoryList.Model.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import Foundation

public enum CategoryList {}

public extension CategoryList {
    
    // TODO: mark as typealias to common entity when API fetching is ready
    struct Model: Hashable, Identifiable {
        
        public struct Fact: Hashable {
            
            public let imageURL: URL?
            public let text: String
        }
        
        public let title: String
        public let description: String
        public let imageURL: URL?
        public let order: Int
        public let content: [Fact]
        
        public var id: Self { self }
    }
}
