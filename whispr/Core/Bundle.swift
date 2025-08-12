//
//  Bundle.swift
//  whispr
//
//  Created by GØDØFIMØ on 12/8/25.
//

import Foundation

extension Bundle {

    var appVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

}
