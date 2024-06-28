//
//  weatherApp.swift
//  weather
//
//  Created by Scholar on 6/21/24.
//

import SwiftUI

@main
struct weatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: TripItem.self)
        }
    }
}
