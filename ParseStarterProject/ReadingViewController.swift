//
//  ReadingViewController.swift
//  ParseStarterProject
//
//  Created by nook on 7/26/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ReadingViewController: UIViewController {
    
    @IBOutlet var textInShape: TextInShape!
    @IBOutlet var emotion: UIImageView!
    @IBOutlet var weatherImage: UIImageView!

    // start with neutral emotion
    var text:String = ""
    var emotionValue:Int = 2
    var isRainy:Bool = false
    
    override func viewDidLoad() {
        textInShape.text = text
        emotion.image = UIImage(named: "emotions\(emotionValue)")
        
        let imageName = self.isRainy ? "rainDropSmall" : "sunSmall"
        
        textInShape.shape = self.isRainy ? .Droplet : .Circle
        weatherImage.image = UIImage(named:imageName)
    }
}
