//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Abdulaziz Alfayaa on 07/01/2022.
//

import UIKit

enum ImageResource: String {
    case angry
    case happy
    case sad
    case normal
    case fun
}

extension UIImage {
    convenience init(resource: ImageResource) {
        self.init(named: resource.rawValue)!
    }
}
