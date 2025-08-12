//
//  WhisprButton.swift
//  whispr
//
//  Created by GØDØFIMØ on 12/8/25.
//

import SwiftUI

struct ActionButton: View {
    var title: String
    var systemImage: String? = nil
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if let systemImage = systemImage {
                Label(title, systemImage: systemImage)
                    .frame(maxWidth: 200, maxHeight: 36)
            } else {
                Text(title)
                    .frame(maxWidth: 200, maxHeight: 36)
            }
        }
        .buttonStyle(.bordered)
        .tint(.green)
    }
}
