//
//  ConnectRoom.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import SwiftUI

struct JoinRoomView: View {

    @EnvironmentObject var router: Router
    @EnvironmentObject var mpcManager: MPCManager

    var body: some View {
        VStack {

            List(mpcManager.foundPeers, id: \.self) { peer in
                HStack {
                    Text(peer.displayName)
                    Spacer()
                    Button("Join") {
                        router.push(.chat(peer: peer))
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                .scaleEffect(1.5)

        }
        .onAppear {
            mpcManager.searchPeers()
        }
        .onDisappear {
            mpcManager.stopSearchPeers()
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Connect Room")
        .tint(.red)
    }
}
