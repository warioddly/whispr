//
//  whisprApp.swift
//  whispr
//
//  Created by GØDØFIMØ on 5/8/25.
//

import SwiftUI

@main
struct whisprApp: App {

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.green,
            .font: UIFont.monospacedSystemFont(ofSize: 17, weight: .bold),
        ]
        UINavigationBar.appearance().standardAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            ChatView()
                .colorScheme(.dark)
                .foregroundStyle(.green)
                .font(.system(.body, design: .monospaced))
        }
    }
}
