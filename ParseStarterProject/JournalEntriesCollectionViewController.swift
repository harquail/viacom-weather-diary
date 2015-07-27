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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
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
        }
        
        return cell
    }
    
    
    // set variables in destination reading view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! ReadingViewController
        let parseObjectForCell = savedStories?[(sender as! UICollectionViewCell).tag]
        destination.text = parseObjectForCell?["text"] as? String ?? ""
        destination.emotionValue = parseObjectForCell?["emotion"] as? Int ?? 2
        destination.weatherDescription = parseObjectForCell?["weather"] as? String ?? "sunny"
        
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
