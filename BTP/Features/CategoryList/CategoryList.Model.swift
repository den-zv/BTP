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
    struct Model {
        
        let title: String
        let description: String
        let imageURL: URL?
        let order: Int
    }
}
