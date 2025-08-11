//
//  ConnectRoom.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import SwiftUI

struct CreateRoomView: View {
    
    private var mpcManager = MPCManager()
    @EnvironmentObject private var router: Router
    
    var body: some View {
        VStack {
            Text("This is the Create Room Page")
            
            Button {
                router.push(.chat);
            } label: {
                Text("Create")
            }
            
        }
        .padding()
        .navigationTitle("Create Room")
    }
}


#Preview {
    CreateRoomView()
}
