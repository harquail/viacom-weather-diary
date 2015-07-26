//
//  WritingViewController.swift
//  ParseStarterProject
//
//  Created by nook on 7/26/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textInShape: TextInShape!
    @IBOutlet var emotion: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInShape.delegate = self
        
        //TODO: get weather
        //TODO: get location at some point
        //TODO: set shape based on weather

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
