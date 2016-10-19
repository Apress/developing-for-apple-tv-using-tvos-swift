//
//  PageContentViewController.swift
//  Photo Gallery
//
//  Created by Stefan Kaczmarek on 10/20/15.
//  Copyright © 2015 The Zonie, LLC. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    var index: Int = 0
    var photoName: String = ""
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let image = UIImage(named: self.photoName) {
            self.imageView.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}