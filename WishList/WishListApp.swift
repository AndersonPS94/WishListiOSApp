//
//  WishListApp.swift
//  WishList
//
//  Created by Anderson Pereira Dos Santos on 24/08/25.
//

import SwiftUI
import SwiftData


@main
struct WishListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
