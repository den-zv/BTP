//
//  APIEnvironment.Stub.swift
//  BTP
//
//  Created by Denis on 04.08.2022.
//

import Combine
import Foundation

public extension APIEnvironment {
    
    static var stub: Self {
        .init { fetchCategories() }
    }
    
    private static func fetchCategories() -> AnyPublisher<[Category], Error> {
        Result<Data, Error>.Publisher(.success(Data(stubJSON.utf8)))
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .decode(type: [Category].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// swiftlint:disable all
private var stubJSON = """
[
  {
    "title": "Dogs",
    "description": "There we go, the best pet!",
    "image": "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/golden-retriever-royalty-free-image-506756303-1560962726.jpg?crop=0.672xw:1.00xh;0.166xw,0&resize=640:*",
    "order": 2,
    "status": "paid",
    "content": [
      {
        "fact": "Arrrgh",
        "image": "https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_4x3.jpg"
      },
      {
        "fact": "Bigger dog - better dog!",
        "image": "https://www.thesprucepets.com/thmb/k3NXIqobAKvxoQ2ozGcwPxzIkpI=/3300x1856/smart/filters:no_upscale()/most-obedient-dog-breeds-4796922-hero-4440a0ccec0e42c98c5e58821fc9f165.jpg"
      }
    ]
  },
  {
    "title": "Cats",
    "description": "Some people like cats",
    "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cat_November_2010-1a.jpg/1200px-Cat_November_2010-1a.jpg",
    "order": 1,
    "status": "free",
    "content": [
      {
        "fact": "Dogs are still better",
        "image": "http://images2.minutemediacdn.com/image/upload/c_crop,h_1193,w_2121,x_0,y_64/f_auto,q_auto,w_1100/v1565279671/shape/mentalfloss/578211-gettyimages-542930526.jpg"
      },
      {
        "fact": "There are a lot of cats in the world",
        "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg"
      },
      {
        "fact": "These are NOT cute",
        "image": "https://i.ytimg.com/vi/1Ne1hqOXKKI/maxresdefault.jpg"
      }
    ]
  },
  {
    "title": "Giraffes",
    "description": "Who are they?",
    "image": "https://play-lh.googleusercontent.com/YhNDu--BDZ1HuqI0cePotepNhcywVUE1mTFQ6vqCPIBvyb-YjWuIhzop163QVBNu4g0",
    "order": 3,
    "status": "free",
    "content": []
  }
]
"""
