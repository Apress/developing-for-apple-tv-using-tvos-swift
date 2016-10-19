//
//  Album.swift
//  Photo Gallery
//
//  Created by Stefan Kaczmarek on 10/20/15.
//  Copyright © 2015 The Zonie, LLC. All rights reserved.
//

import Foundation

struct Album {
    var name: String = ""
    var photos: [Photo] = []
    
    init(name: String, photoNames: [String]) {
        self.name = name
        for photoName in photoNames {
            self.photos += [Photo(name: photoName)]
        }
    }
}