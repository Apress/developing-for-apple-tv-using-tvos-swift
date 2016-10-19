//
//  TableViewController.swift
//  Photo Gallery
//
//  Created by Stefan Kaczmarek on 10/21/15.
//  Copyright © 2015 The Zonie, LLC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let gallery = Gallery()
    
    var selectedTopShelfItem: (albumIndex: Int?, photoIndex: Int?) = (nil, nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.checkSelectedTopShelfItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View Data Source Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.gallery.albums.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.gallery.albums[indexPath.row].name
        
        var names = ""
        for photo in self.gallery.albums[indexPath.row].photos {
            names += photo.name + ", "
        }
        names = String(names.characters.dropLast(2))    // remove the last two characters of the string
        cell.detailTextLabel?.text = names
        
        cell.imageView?.image = UIImage(named: self.gallery.albums[indexPath.row].photos[0].name)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SelectAlbumSegue" {
            if let pageViewController = segue.destinationViewController as? PageViewController, row = self.tableView.indexPathForSelectedRow?.row {
                pageViewController.album = self.gallery.albums[row]
                
                // if there is a selected photo index set it as well and then reset it
                if let photoIndex = self.selectedTopShelfItem.photoIndex {
                    pageViewController.pageIndex = photoIndex
                    self.selectedTopShelfItem = (nil, nil)
                }
            }
        }
    }
    
    // MARK: -
    
    func viewSelectedTopShelfPhoto(photo: Int, inAlbum album: Int)
    {
        // save the selected top shelf album photo index values
        self.selectedTopShelfItem = (album, photo)
        
        // if I am not the presented view controller, pop back
        if let presentedViewController = self.presentedViewController {
            presentedViewController.dismissViewControllerAnimated(false, completion: nil)
        }
        else {
            self.checkSelectedTopShelfItem()
        }
    }
    
    func checkSelectedTopShelfItem()
    {
        if let albumIndex = self.selectedTopShelfItem.albumIndex {
            self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: albumIndex, inSection: 0), animated: false, scrollPosition: .None)
            self.performSegueWithIdentifier("SelectAlbumSegue", sender: nil)
        }
    }
}
