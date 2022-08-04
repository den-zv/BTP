//
//  BTPApp.swift
//  BTP
//
//  Created by Denis on 03.08.2022.
//

import SwiftUI

@main
struct BTPApp: App {
    
    var body: some Scene {
        WindowGroup {
            CategoryListView(viewModel: .initial(
                environment: .init(
                    api: Self.Environment.live.api,
                    ads: Self.Environment.live.ads,
                    favorites: Self.Environment.live.favorites
                )
            ))
        }
    }
}
