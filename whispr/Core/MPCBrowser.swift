//
//  Router.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import MultipeerConnectivity

class MPCBrowser: NSObject, ObservableObject {
    private let serviceType = "whispr"
    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
    private var browser: MCNearbyServiceBrowser!

    @Published var foundPeers: [MCPeerID] = []

    override init() {
        super.init()
        browser = MCNearbyServiceBrowser(
            peer: myPeerID,
            serviceType: serviceType
        )
        browser.delegate = self
        browser.startBrowsingForPeers()
    }

    deinit {
        browser.stopBrowsingForPeers()
    }
}

extension MPCBrowser: MCNearbyServiceBrowserDelegate {
    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID,
        withDiscoveryInfo info: [String: String]?
    ) {
        DispatchQueue.main.async {
            if !self.foundPeers.contains(peerID) {
                self.foundPeers.append(peerID)
            }
        }
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.foundPeers.removeAll { $0 == peerID }
        }
    }

    // Обязательно реализуй этот метод, даже если пусто
    func browser(
        _ browser: MCNearbyServiceBrowser,
        didNotStartBrowsingForPeers error: Error
    ) {
        print("Ошибка браузера: \(error.localizedDescription)")
    }
}
