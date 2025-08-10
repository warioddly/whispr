//
//  ConnectRoom.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import SwiftUI

struct JoinRoomView: View {
    var body: some View {
        VStack {

            NavigationLink(destination: ChatView()) {
                Label("Create", systemImage: "plus.circle.fill")
                    .frame(maxWidth: 220, maxHeight: 36)
            }

            Text("This is the Join Room Page")
                .font(.title)
                .navigationTitle("Connect Room")
                .navigationBarBackButtonHidden(true)
        }
    }
}
