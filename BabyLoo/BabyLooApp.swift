//
//  BabyLooApp.swift
//  BabyLoo
//
//  Created by Selvarajan on 01/01/22.
//

import SwiftUI

@main
struct BabyLooApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.colorScheme, .light)
        }
    }
}
