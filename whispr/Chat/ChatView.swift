//
//  ChatView.swift
//  whispr
//
//  Created by GØDØFIMØ on 5/8/25.
//

import SwiftUI

struct ChatView: View {

    @StateObject private var vm = ChatViewModel()

    var body: some View {
        NavigationStack {
            VStack {

                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(vm.messages, id: \.id) { message in
                            Text(message.text)
                                .padding(.bottom, 1)
                        }

                        ConsoleTextFieldView()
                    }
                    .padding()
                }

                ChatToolbarView()
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(vm)
    }
}

struct ChatToolbarView: View {
    var body: some View {
        HStack {
            Button("Chat") {}
            Spacer()
            Button("Help") {}
            Spacer()
            Button("Commands") {}
            Spacer()

            // TODO: Добавить иконку для показа/скрытия клавиатуры
            Button {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            } label: {
                Image(systemName: "chevron.down")
            }
        }
        .safeAreaPadding(.horizontal)
        .safeAreaPadding(.bottom)
        
    }
}

struct ConsoleTextFieldView: View {

    @EnvironmentObject var vm: ChatViewModel
    @State private var input: String = ""

    var body: some View {
        HStack(alignment: .center) {
            Text("user >")
            TextField("Type something...", text: $input)
                .font(.system(.body, design: .monospaced))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .onSubmit {
                    vm.sendMessage("user > \(input)")
                    input = ""
                }
        }
    }
}

#Preview {
    ChatView()
        .colorScheme(.dark)
        .foregroundStyle(.green)
        .font(.system(.body, design: .monospaced))
}
