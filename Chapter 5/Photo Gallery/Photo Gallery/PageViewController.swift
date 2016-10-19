//
//  PageViewController.swift
//  Photo Gallery
//
//  Created by Stefan Kaczmarek on 10/20/15.
//  Copyright © 2015 The Zonie, LLC. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageIndex: Int = 0
    var album = Album(name: "Animals",
        photoNames: ["Cows", "Dog",
            "Horses", "Seagull", "Sheep"])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        if let pageContentViewController =
            self.pageContentViewController(self.pageIndex) {
            self.setViewControllers([pageContentViewController],
            direction: .Forward, animated: true, completion:
            nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let contentViewController = viewController as? PageContentViewController {
            return self.pageContentViewController(contentViewController.index - 1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let contentViewController = viewController as? PageContentViewController {
            return self.pageContentViewController(contentViewController.index + 1)
        }
        
        return nil
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return album.photos.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageIndex
    }
    
    func pageContentViewController(index: Int) -> PageContentViewController? {
        if let contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController where index >= 0 && index < album.photos.count {
            self.pageIndex = index
            contentViewController.index = index
            contentViewController.photoName = self.album.photos[index].name
            return contentViewController
        }
        
        return nil
    }
}