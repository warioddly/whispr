//
//  HomeView.swift
//  whispr
//
//  Created by GØDØFIMØ on 10/8/25.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var router: Router
    @EnvironmentObject var mpcManager: MPCManager
    
    var body: some View {

        VStack {
            Spacer()

            VStack(alignment: .center, spacing: 16) {

                Text("WHISPR")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .monospaced))
               
                ActionButton(title: "Create", systemImage: "plus.circle.fill") {
                    mpcManager.create()
                    router.push(.chat)
                }
                
                ActionButton(title: "Join", systemImage: "link.circle.fill") {
                    router.push(.joinRoom)
                }

            }

            Spacer()

            AppInfo()
            
            VSpace(height: 16)
        }
    }

}

#Preview {
    RootView()
        .environmentObject(Router())
        .environmentObject(MPCManager())
        .colorScheme(.dark)
        .foregroundStyle(.green)
        .font(.system(.body, design: .monospaced))
}
