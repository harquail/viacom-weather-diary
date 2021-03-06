//
//  JournalEntryCollectionViewCell.swift
//  ParseStarterProject
//
//  Created by nook on 7/26/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class JournalEntryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var day: UILabel!
    @IBOutlet var month: UILabel!
    @IBOutlet var previewText: UITextView!
    
    override func layoutSubviews() {
        //rotate month label 90º
        month.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 2.0))
    }
}
