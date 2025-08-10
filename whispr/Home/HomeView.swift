//
//  HomeView.swift
//  whispr
//
//  Created by GØDØFIMØ on 10/8/25.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var router: Router
    
    private let appVersion =
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        ?? ""
    private let buildNumber =
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""

    var body: some View {

        VStack {
            Spacer()

            VStack(alignment: .center, spacing: 16) {

                Text("WHISPR")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .monospaced))

                Button {
                    router.push(.createRoom)
                } label: {
                    Label("Create", systemImage: "plus.circle.fill")
                        .frame(maxWidth: 220, maxHeight: 36)
                }

                Button {
                    router.push(.joinRoom)
                } label: {
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
    RootView()
        .environmentObject(Router())
        .colorScheme(.dark)
        .foregroundStyle(.green)
        .font(.system(.body, design: .monospaced))
}
