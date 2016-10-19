//
//  Gallery.swift
//  Photo Gallery
//
//  Created by Stefan Kaczmarek on 10/22/15.
//  Copyright © 2015 The Zonie, LLC. All rights reserved.
//

import Foundation

struct Gallery {
    var albums: [Album] {
        return [
            Album(name: "Animals", photoNames: ["Cows", "Dog", "Horses", "Seagull", "Sheep"]),
            Album(name: "Cities", photoNames: ["Bridge", "Fireworks", "Traffic", "Village", "Windows"]),
            Album(name: "Landscapes", photoNames: ["Coast", "Field", "Lake", "Lighthouse", "Road"])
        ]
    }
}