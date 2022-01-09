//
//  Bundle+Mandala.swift
//  Mandala
//
//  Created by Abdulaziz Alfayaa on 08/01/2022.
//

import Foundation

extension Bundle {
    var displayName: String? {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    }
    var version: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
