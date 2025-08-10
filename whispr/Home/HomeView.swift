//
//  HomeView.swift
//  whispr
//
//  Created by GØDØFIMØ on 10/8/25.
//

import SwiftUI

struct HomeView: View {

    private let appVersion =
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        ?? ""
    private let buildNumber =
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""

    var body: some View {

        NavigationStack {

            Spacer()

            VStack(alignment: .center, spacing: 16) {

                Text("WHISPR")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .monospaced))

                NavigationLink(destination: CreateRoomView()) {
                    Label("Create", systemImage: "plus.circle.fill")
                        .frame(maxWidth: 220, maxHeight: 36)
                }

                NavigationLink(destination: JoinRoomView()) {
                    Label("Join", systemImage: "link.circle.fill")
                        .frame(maxWidth: 220, maxHeight: 36)
                }

            }
            .buttonStyle(.bordered)
            .tint(.green)
            .padding()
            .navigationBarTitleDisplayMode(.inline)

            Spacer()

            Text("whispr \(appVersion)+\(buildNumber)")
                .foregroundStyle(.green.opacity(0.5))
                .font(.system(.footnote, design: .monospaced))
        }

    }

}

#Preview {
    HomeView()
        .colorScheme(.dark)
        .foregroundStyle(.green)
        .font(.system(.body, design: .monospaced))
}
