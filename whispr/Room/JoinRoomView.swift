//
//  ConnectRoom.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import SwiftUI

struct JoinRoomView: View {

    @EnvironmentObject var router: Router
    @StateObject private var mpcManager = MPCManager()

    var body: some View {
        VStack {

            Button {
                router.push(.chat)
            } label: {
                Label("Join", systemImage: "plus.circle.fill")
            }

            List(mpcManager.foundPeers, id: \.self) { peer in
                HStack {
                    Text(peer.displayName)
                    Spacer()
                    Button("Join") {
                        router.push(.chat)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }

        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Connect Room")
    }
}
