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
    // start with neutral emotion
    var text:String = ""
    var emotionValue:Int = 2
    var weatherDescription:String = "sunny"
    
    override func viewDidLoad() {
        textInShape.text = text
        emotion.image = UIImage(named: "emotions\(emotionValue)")
    }
}
