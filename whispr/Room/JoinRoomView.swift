//
//  ConnectRoom.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import MultipeerConnectivity
import SwiftUI

struct JoinRoomView: View {

    @EnvironmentObject var router: Router
    @StateObject private var mpcBrowser = MPCBrowser()

    var body: some View {
        VStack {

            Button {
                router.push(.chat)
            } label: {
                Label("Join", systemImage: "plus.circle.fill")
            }

            List(mpcBrowser.foundPeers, id: \.self) { peer in
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
        .navigationBarBackButtonHidden(true)
    }
}
