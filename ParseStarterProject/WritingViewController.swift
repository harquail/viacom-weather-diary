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
    // start with neutral emotion
    var emotionValue:Int = 2
    var weatherDescription:String = "sunny"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInShape.delegate = self
        textInShape.shape = .Rectangle
        
        
        self.getForecast()
        
        
        
        
        
        //        let forecastr =
        
        //        appDelegate.currentLocation
        //        FIOAPI.requestWeatherForLocation()
        
        
        // observe keyboard show/hide
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        // start in editing mode
        textInShape.becomeFirstResponder()
    }
    
    
    private func getForecast(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let request = CZForecastioRequest.newForecastRequest()
        if let location = appDelegate.currentLocation{
            request.location = CZWeatherLocation(fromLocation: location)
            request.key = kForecastAPIKey
            request.sendWithCompletion { (data, error) -> Void in
                if let weather = data {
                    println(weather.current.summary)
                    println(self.isWetWeather(weather.current.summary))
                }
            }
        }
    }
    
    
    private func isWetWeather(description:String) -> Bool{
        
        let drizzle = description.lowercaseString.rangeOfString("drizzle")
        let rain = description.lowercaseString.rangeOfString("rain")
        
        return drizzle != nil || rain != nil
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        let savedObject = PFObject(className: "savedStory")
        savedObject["text"] = textInShape.text
        savedObject["userID"] = PFUser.currentUser()?.objectId
        savedObject["emotion"] = emotionValue
        savedObject["weather"] = weatherDescription
        
        println(textInShape.text)
        savedObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved.")
            PFUser.currentUser()
        }
        
    }
    
    
    
    // MARK: - UITextView Delegate Methods
    
    /**
    When the text view ends editing, update the emotion
    :param: textView the text view
    */
    func textViewDidEndEditing(textView: UITextView) {
        
        let analysis = SKPolygraph.sharedInstance().analyseSentiment(textInShape.text)
        self.updateEmotion(analysis)
    }
    
    /**
    Changes the textbox size on keyboard show so text is not hidden by keyboard
    :param: notification a notification object
    */
    func keyboardWillShow(notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            println("kb show")
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
    
    // MARK: - Private Method
    
    /**
    Update the emotion image
    :param: sentimentValue a signed float representing the sentiment of the text
    */
    private func updateEmotion(sentimentValue:Float){
        if(sentimentValue < -5){
            // crying face
            emotionValue = 0
        }
        else if(sentimentValue < 0){
            // sad face
            emotionValue = 1
        }
        else if(sentimentValue > 5){
            // very happy face
            emotionValue = 4
        }
        else if(sentimentValue > 3){
            // happy face
            emotionValue = 3
        }
        else{
            // neutral face
            emotionValue = 2
            
        }
        emotion.image = UIImage(named:"emotion\(emotionValue)")
        
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
