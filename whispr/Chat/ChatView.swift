//
//  ChatView.swift
//  whispr
//
//  Created by GØDØFIMØ on 5/8/25.
//

import SwiftUI
import MultipeerConnectivity

struct ChatView: View {
    
    @StateObject private var viewModel = ChatViewModel()
    @EnvironmentObject var mpcManager: MPCManager
    
    var body: some View {
        VStack {

            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(mpcManager.messages, id: \.self) { message in
                        Text(message)
                            .padding(.bottom, 1)
                    }

                    ConsoleTextFieldView()
                }
                .padding()
            }

            ChatToolbarView()
        }
        .onDisappear {
            if (mpcManager.isHost) {
                mpcManager.stop()
            }
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Chat")
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(viewModel)
    }
}

struct ChatToolbarView: View {

    @EnvironmentObject var router: Router

    var body: some View {
        HStack {
            Button("Exit") {
                router.popToRoot()
            }
            Spacer()
            Button("Help") {}
            Spacer()
            Button("Commands") {}
            Spacer()

            // TODO: Добавить иконку для показа/скрытия клавиатуры
            Button {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            } label: {
                Image(systemName: "chevron.down")
            }
        }
        .safeAreaPadding(.horizontal)
        .safeAreaPadding(.bottom)

    }
}

struct ConsoleTextFieldView: View {

    @EnvironmentObject var vmviewModel: ChatViewModel
    @State private var input: String = ""
    @EnvironmentObject var mpcManager: MPCManager

    var body: some View {
        HStack(alignment: .center) {
            Text("user >")
            TextField("Type something...", text: $input)
                .font(.system(.body, design: .monospaced))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .onSubmit {
                    mpcManager.send(message: input)
                    vmviewModel.sendMessage("user > \(input)")
                    input = ""
                }
        }
    }
}
