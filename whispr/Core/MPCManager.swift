//
//  MPCManager.swift
//  whispr
//
//  Created by GØDØFIMØ on 11/8/25.
//

import Combine
import Foundation
import MultipeerConnectivity

class MPCManager: NSObject, ObservableObject {
    private let serviceType = "my-chat"

    let myPeerId = MCPeerID(displayName: UIDevice.current.name)

    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    private let serviceBrowser: MCNearbyServiceBrowser

    @Published var foundPeers: [MCPeerID] = []
    @Published var connectedPeers: [MCPeerID] = []
    @Published var messages: [String] = []

    public var isHost: Bool = false

    private var session: MCSession

    override init() {
        session = MCSession(
            peer: myPeerId,
            securityIdentity: nil,
            encryptionPreference: .required
        )
        serviceAdvertiser = MCNearbyServiceAdvertiser(
            peer: myPeerId,
            discoveryInfo: nil,
            serviceType: serviceType
        )
        serviceBrowser = MCNearbyServiceBrowser(
            peer: myPeerId,
            serviceType: serviceType
        )

        super.init()

        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
    }

    func startHosting() {
        isHost = true
        messages.removeAll()
        serviceAdvertiser.startAdvertisingPeer()
    }

    func searchPeers() {
        serviceBrowser.startBrowsingForPeers()
    }

    func stopSearchPeers() {
        serviceBrowser.stopBrowsingForPeers()
    }

    func stopHosting() {
        isHost = false
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
        session.disconnect()
    }

    func invite(peer: MCPeerID) {
        serviceBrowser.invitePeer(
            peer,
            to: session,
            withContext: nil,
            timeout: 10
        )
    }

    func send(message: String) {
        guard !session.connectedPeers.isEmpty else { return }
        if let data = message.data(using: .utf8) {
            do {
                try session.send(
                    data,
                    toPeers: session.connectedPeers,
                    with: .reliable
                )
                DispatchQueue.main.async {
                    self.messages.append("Me: \(message)")
                }
            } catch {
                print("Ошибка при отправке сообщения: \(error)")
            }
        }
    }

}

extension MPCManager: MCSessionDelegate {
    func session(
        _ session: MCSession,
        peer peerID: MCPeerID,
        didChange state: MCSessionState
    ) {
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
            let stateString: String
            switch state {
            case .connected: stateString = "connected"
            case .connecting: stateString = "connecting"
            case .notConnected: stateString = "not connected"
            @unknown default: stateString = "unknown"
            }
            print("\(peerID.displayName) is \(stateString)")
        }
    }

    func session(
        _ session: MCSession,
        didReceive data: Data,
        fromPeer peerID: MCPeerID
    ) {
        if let message = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.messages.append("\(peerID.displayName): \(message)")
            }
        }
    }

    func session(
        _ session: MCSession,
        didReceive stream: InputStream,
        withName streamName: String,
        fromPeer peerID: MCPeerID
    ) {}
    func session(
        _ session: MCSession,
        didStartReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        with progress: Progress
    ) {}
    func session(
        _ session: MCSession,
        didFinishReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        at localURL: URL?,
        withError error: Error?
    ) {}
}

extension MPCManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        invitationHandler(true, session)
    }
}

extension MPCManager: MCNearbyServiceBrowserDelegate {
    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID,
        withDiscoveryInfo info: [String: String]?
    ) {
        DispatchQueue.main.async {
            if !self.foundPeers.contains(peerID) && peerID != self.myPeerId {
                self.foundPeers.append(peerID)
            }
        }
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.foundPeers.removeAll(where: { $0 == peerID })
        }
    }
}
