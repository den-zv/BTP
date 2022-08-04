//
//  APIEnvironment.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import Combine
import Foundation

public struct APIEnvironment {
    
    public var fetchCategories: () -> AnyPublisher<[Category], Error>
}

// MARK: - Private methods

private extension APIEnvironment {
    
    static func process<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard
                    let httpResponse = element.response as? HTTPURLResponse,
                    (200..<400).contains(httpResponse.statusCode)
                else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Live

public extension APIEnvironment {
    
    static var live: Self {
        .init { fetchCategories() }
    }
    
    private static func fetchCategories() -> AnyPublisher<[Category], Error> {
        guard let url = URL(
            string: "https://drive.google.com/uc?export=download&id=12L7OflAsIxPOF47ssRdKyjXoWbUrq4V5"
        ) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return process(request: .init(url: url))
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
extension APIEnvironment {
    
    static var preview: Self {
        .init {
            Future { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    promise(.success(.preview(5)))
                }
            }
            .eraseToAnyPublisher()
        }
    }
}

#endif
