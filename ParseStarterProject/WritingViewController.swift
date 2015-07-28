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
    @IBOutlet var weatherImage: UIImageView!
    
    // start with neutral emotion
    var emotionValue:Int = 2
    var isRainy:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // no shape cutout while writing
        textInShape.shape = .Rectangle
        
        
        // observe keyboard show/hide
        textInShape.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        // start in editing mode
        textInShape.becomeFirstResponder()
        
        self.updateWeather()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        // save the object to parse
        let savedObject = PFObject(className: "savedStory")
        savedObject["text"] = textInShape.text
        savedObject["userID"] = PFUser.currentUser()?.objectId
        savedObject["emotion"] = emotionValue
        savedObject["rainy"] = isRainy
        
        savedObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            PFUser.currentUser()
        }
        
    }
    
    
    //--------------------------------------
    // MARK: - UITextView Delegate Methods
    //--------------------------------------
    
    /**
    When the text view ends editing, update the emotion
    :param: textView the text view
    */
    func textViewDidEndEditing(textView: UITextView) {
        
        let analysis = SKPolygraph.sharedInstance().analyseSentiment(textInShape.text)
        self.updateEmotion(Int(analysis))
    }
    
    /**
    Changes the textbox size on keyboard show so text is not hidden by keyboard
    :param: notification a notification object
    */
    func keyboardWillShow(notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            let contentInsets = UIEdgeInsets(top: textInShape.contentInset.top, left: 0, bottom: keyboardSize.height, right: 0)
            self.textInShape.contentInset = contentInsets
            self.textInShape.scrollIndicatorInsets = contentInsets
        }
    }
    
    /**
    Restores textbox size to original size
    :param: notification a notification object
    */
    func keyboardWillHide(notification:NSNotification){
        self.textInShape.contentInset = UIEdgeInsets(top: textInShape.contentInset.top,left:0,bottom:0,right:0)
        self.textInShape.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    /**
    Detects "done" key presses and ends editing when button is pressed
    :param: notification a notification object
    */
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
    
    //--------------------------------------
    // MARK: - Private Methods
    //--------------------------------------
    
    /**
    Update the emotion image
    :param: sentimentValue a signed float representing the sentiment of the text
    */
    private func updateEmotion(sentimentValue:Int){
        
        if(sentimentValue < -4){
            // crying face
            emotionValue = 0
        }
        else if(sentimentValue < 0){
            // sad face
            emotionValue = 1
        }
        else if(sentimentValue > 2  && sentimentValue <= 4){
            // happy face
            emotionValue = 3
        }
        else if(sentimentValue > 4){
            // very happy face
            emotionValue = 4
        }
        else{
            // neutral face
            emotionValue = 2
            
        }
        emotion.image = UIImage(named:"emotions\(emotionValue)")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    Update the weather conditions
    */
    private func updateWeather(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // API Request to Forecast.io
        let request = CZForecastioRequest.newForecastRequest()
        if let location = appDelegate.currentLocation{
            request.location = CZWeatherLocation(fromLocation: location)
            request.key = kForecastAPIKey
            request.sendWithCompletion { (data, error) -> Void in
                if let weather = data {
                    self.isRainy = self.weatherIsWet(weather.current.summary)
                    
                    // set image based on weather at location
                    let imageName = self.isRainy ? "rainDropSmall" : "sunSmall"
                    self.weatherImage.image = UIImage(named: imageName)
                    
                }
            }
        }
    }
    
    /**
    Determines whether a string represents wet weather
    :param: description a string representing the weather condition
    :returns: true if the description contains "rain" or "drizzle", otherwise false
    */
    private func weatherIsWet(description:String) -> Bool{
        
        let drizzle = description.lowercaseString.rangeOfString("drizzle")
        let rain = description.lowercaseString.rangeOfString("rain")
        
        return drizzle != nil || rain != nil
    }
    
    
    
}
