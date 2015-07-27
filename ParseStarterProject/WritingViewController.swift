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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        //TODO: get weather
        //TODO: get location at some point
        //TODO: set shape based on weather

        // Do any additional setup after loading the view.
    }

    
    func textViewDidEndEditing(textView: UITextView) {

    }
    
    func keyboardWillShow(notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            println("kb show")
            let contentInsets = UIEdgeInsets(top: textInShape.contentInset.top, left: 0, bottom: keyboardSize.height, right: 0)
            self.textInShape.contentInset = contentInsets
            self.textInShape.scrollIndicatorInsets = contentInsets
        }
    }
    
    
    func keyboardWillHide(notification:NSNotification){
        self.textInShape.contentInset = UIEdgeInsets(top: textInShape.contentInset.top,left:0,bottom:0,right:0)
        self.textInShape.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
                textView.endEditing(false)
            textView.resignFirstResponder()
            return false
        }
        else{
            return true
        }
    }
//    
//    func textViewShouldEndEditing(textView: UITextView) -> Bool {
//        return true
//    }
    
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
