//
//  ConnectRoom.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import MultipeerConnectivity
import SwiftUI

struct CreateRoomView: View {

    @EnvironmentObject private var router: Router
    @EnvironmentObject private var mpcManager: MPCManager

    var body: some View {
        VStack {
            Text("This is the Create Room Page")

            Button {
//                mpcManager.stopHosting()
//                mpcManager.startHosting(serviceType: "my-chat")
                router.push(.chat(peer: mpcManager.myPeerId))
            } label: {
                Text("Create")
            }

        }
        .padding()
        .navigationTitle("Create Room")
        .onDisappear {
//            mpcManager.stopHosting()
        }
    }
}

#Preview {
    CreateRoomView()
}
