//
//  Router.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import SwiftUI
import Combine
import MultipeerConnectivity

enum Route: Hashable {
    case home
    case joinRoom
    case chat(peer: MCPeerID?)
}

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}


struct RootView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .home:
                        HomeView()
                    case .chat(let peer):
                        ChatView(peer: peer)
                    case .joinRoom:
                        JoinRoomView()
                    }
                }
        }
    }
}
