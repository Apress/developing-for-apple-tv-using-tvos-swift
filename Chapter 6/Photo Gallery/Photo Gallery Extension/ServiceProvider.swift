//
//  ServiceProvider.swift
//  Photo Gallery Extension
//
//  Created by Stefan Kaczmarek on 10/31/15.
//  Copyright © 2015 The Zonie, LLC. All rights reserved.
//

import Foundation
import TVServices

class ServiceProvider: NSObject, TVTopShelfProvider {

    override init() {
        super.init()
    }

    // MARK: - TVTopShelfProvider protocol

    var topShelfStyle: TVTopShelfContentStyle {
        // Return desired Top Shelf style.
        return .Sectioned
    }

    var topShelfItems: [TVContentItem] {
        let gallery = Gallery()
        
        var albums: [TVContentItem] = []
        
        // create a TVContentItem for each album in the gallery
        for albumIndex in 0..<gallery.albums.count {
            let album = gallery.albums[albumIndex]
            
            var photos: [TVContentItem] = []
            
            // create a TVContentItem for each photo in the album
            for photoIndex in 0..<album.photos.count {
                let photo = album.photos[photoIndex]
                
                guard let photoIdentifier = TVContentIdentifier(identifier: photo.name, container: nil) else { return [] }
                guard let photoItem = TVContentItem(contentIdentifier: photoIdentifier) else { return [] }
                
                photoItem.title = photo.name
                photoItem.imageURL = NSBundle.mainBundle().URLForResource(photo.name, withExtension: ".jpg")
                photoItem.displayURL = NSURL(string: "photogallery:viewTopShelfItem?album=\(albumIndex)&photo=\(photoIndex)")
                
                photos.append(photoItem)
            }
            
            guard let albumIdentifier = TVContentIdentifier(identifier: album.name, container: nil) else { return [] }
            guard let albumItem = TVContentItem(contentIdentifier: albumIdentifier) else { return [] }
            
            albumItem.title = album.name
            albumItem.topShelfItems = photos
            
            albums.append(albumItem)
        }
        
        return albums
    }
}