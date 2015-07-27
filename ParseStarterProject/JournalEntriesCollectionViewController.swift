//
//  JournalEntriesCollectionViewController.swift
//  ParseStarterProject
//
//  Created by nook on 7/26/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

let reuseIdentifier = "journalEntryCell"
var savedStories:[PFObject]?

class JournalEntriesCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch stories for user from parse
        let query = PFQuery(className: "savedStory")
        query.addDescendingOrder("createdAt")
        query.whereKey("userID", equalTo: PFUser.currentUser()!.objectId!)
        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
            savedStories = objects as? [PFObject]
            self.collectionView?.reloadData()
        }
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println(savedStories?.count)
        return savedStories?.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! JournalEntryCollectionViewCell
        
        // restore cells from parse data
        let cellData:PFObject?
        if(savedStories != nil && savedStories?.count > indexPath.row){
            
            cellData = savedStories![indexPath.row]
            // change date of cells
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "d"
            cell.day.text = dateFormatter.stringFromDate(cellData!.createdAt!)
            dateFormatter.dateFormat = "MMMM"
            cell.month.text = dateFormatter.stringFromDate(cellData!.createdAt!)
            
            // keep track of cell position via tag
            cell.tag = indexPath.row
            cell.previewText.text = cellData!["text"] as! String
        }
        
        return cell
    }
    
    // MARK: - Navigation

    // set variables in destination reading view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! ReadingViewController
        let parseObjectForCell = savedStories?[(sender as! UICollectionViewCell).tag]
        destination.text = parseObjectForCell?["text"] as? String ?? ""
        destination.emotionValue = parseObjectForCell?["emotion"] as? Int ?? 2
        destination.isRainy = parseObjectForCell?["rainy"] as? Bool ?? false
    }
}
