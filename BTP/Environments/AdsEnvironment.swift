//
//  AdsEnvironment.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import Combine
import Foundation

public struct AdsEnvironment {
    
    public var showAd: () -> AnyPublisher<Bool, Never>
}

// MARK: - Live

public extension AdsEnvironment {
    
    static var live: Self {
        .init { showAd() }
    }
    
    private static func showAd() -> AnyPublisher<Bool, Never> {
        Future { promise in
            promise(.success(true))
        }
        .delay(for: 2.0, scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension AdsEnvironment {
    
    static var preview: Self {
        .live
    }
}

#endif
