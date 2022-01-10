//
//  Mood.swift
//  Mandala
//
//  Created by Abdulaziz Alfayaa on 07/01/2022.
//

import UIKit

struct Mood {
    var name: String
    var image: UIImage
    var color: UIColor
}

extension Mood {
    static let angry    = Mood(
                            name: "angry",
                            image: UIImage(resource: .angry),
                            color: UIColor.angry)
    
    static let happy    = Mood(
                            name: "happy",
                            image: UIImage(resource: .happy),
                            color: UIColor.happy)
    
    static let sad      = Mood(
                            name: "sad",
                            image: UIImage(resource: .sad),
                            color: UIColor.sad)
    
    static let normal   = Mood(
                            name: "normal",
                            image: UIImage(resource: .normal),
                            color: UIColor.normal)
    
    static let fun      = Mood(
                            name: "fun",
                            image: UIImage(resource: .fun),
                            color: UIColor.fun)
}
