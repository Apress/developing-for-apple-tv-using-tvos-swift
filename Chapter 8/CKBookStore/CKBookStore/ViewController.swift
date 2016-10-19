//
//  ViewController.swift
//  CKBookStore
//
//  Created by Brad Lees on 11/19/15.
//  Copyright © 2015 innovativeware. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let myPredicate: NSPredicate = NSPredicate(value: true)
        let myQuery: CKQuery = CKQuery(recordType: "Books", predicate: myPredicate)
        
        CKContainer.defaultContainer().publicCloudDatabase.performQuery(myQuery, inZoneWithID: nil) {
            results, error in
            if error != nil {
                print("Error")
                print(error.debugDescription)
            } else {
                print(results)
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBooks() {
        
        let newBook = CKRecord(recordType: "Books")
        newBook["title"] = "The Hobbit"
        newBook["author"] = "J. R. R. Tolkien"
        
        CKContainer.defaultContainer().publicCloudDatabase.saveRecord(newBook) { (record, error) -> Void in
            print("Done")
            if(error != nil) {
                print("error")
                print(error.debugDescription)
            }
        }
    }
}




