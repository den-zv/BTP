//
//  CategoryList.Model.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import Foundation

public enum CategoryList {}

public extension CategoryList {
    
    typealias Model = Category
}

extension CategoryList.Model: Identifiable {
    
    public var id: Self { self }
}
