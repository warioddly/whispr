//
//  ChatView.swift
//  whispr
//
//  Created by GØDØFIMØ on 5/8/25.
//

import Combine
import SwiftUI

struct Message: Identifiable {
    var id: UUID = UUID()
    var text: String
    var timestampt: Date
}

class ChatViewModel: ObservableObject {

    @Published var messages: [Message] = []

    func sendMessage(_ message: String) {
        messages.append(contentsOf: [
            Message(text: message, timestampt: .now),
            Message(text: "Hello World!", timestampt: .now)
        ])
    }

}
