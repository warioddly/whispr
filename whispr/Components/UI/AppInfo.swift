//
//  VSpace.swift
//  whispr
//
//  Created by GØDØFIMØ on 10/8/25.
//

import SwiftUI

struct AppInfo: View {

    var body: some View {
        Text("whispr \(Bundle.main.appVersion)+\(Bundle.main.buildNumber)")
            .foregroundStyle(.green.opacity(0.8))
            .font(.system(.footnote, design: .monospaced))
    }

}
