//
//  BTPApp.Environment.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import Foundation

extension BTPApp {
    
    struct Environment {
        
        public let api: APIEnvironment
        public let ads: AdsEnvironment
    }
}

// MARK: - Live

extension BTPApp.Environment {
    
    static var live: Self {
        .init(api: .live, ads: .live)
    }
}
