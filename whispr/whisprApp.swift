//
//  whisprApp.swift
//  whispr
//
//  Created by GØDØFIMØ on 5/8/25.
//

import SwiftUI

@main
struct whisprApp: App {

    @StateObject private var router = Router()
    @StateObject private var mpcManager = MPCManager()

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.green,
            .font: UIFont.monospacedSystemFont(ofSize: 17, weight: .bold),
        ]

        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.green,
            .font: UIFont.monospacedSystemFont(ofSize: 17, weight: .bold),
        ]

        appearance.backButtonAppearance.highlighted.titleTextAttributes = [
            .foregroundColor: UIColor.green,
            .font: UIFont.monospacedSystemFont(ofSize: 17, weight: .bold),
        ]

        UINavigationBar.appearance().standardAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .colorScheme(.dark)
                .foregroundStyle(.green)
                .font(.system(.body, design: .monospaced))
                .environmentObject(router)
                .environmentObject(mpcManager)
        }
    }
}
