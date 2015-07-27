//
//  TextInShape.swift
//  ParseStarterProject
//
//  Created by nook on 7/25/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class TextInShape: UITextView {
    
    enum ShapeType:String{
        case Rectangle = ""
        case Circle = "sunny"
        case Droplet = "rainy"
    }
    
    var shape:ShapeType?
    
    override func layoutSubviews() {
        if let s = shape {
            //rectangle don't need exlusion paths
            if s != .Rectangle{
                let exclusionPath = pathForShape(s)
                let rectClip = UIBezierPath(rect: self.frame)
                exclusionPath.appendPath(rectClip)
                exclusionPath.usesEvenOddFillRule = true
                self.textContainer.exclusionPaths = [exclusionPath]
            }
        }
    }
    
    private func pathForShape(s:ShapeType) -> UIBezierPath{
        
        switch(s.rawValue){
        case "sunny":
            return sunShape()
        default:
            return rainDropShape()
        }
        
    }
    
    
    private func rainDropShape() -> UIBezierPath{
        
        return UIBezierPath()
        
    }
    
    private func sunShape() -> UIBezierPath{
        
        return UIBezierPath(ovalInRect: self.frame).bezierPathByReversingPath()
    }
    
    
    //    - (void)keyboardWillShow:(NSNotification *)notification
    //    {
    //    NSDictionary *info = [notification userInfo];
    //    CGSize kbSize = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    //
    //    self.textView.contentInset = contentInsets;
    //    self.textView.scrollIndicatorInsets = contentInsets;
    //    }
    //
    //    - (void)keyboardWillHide:(NSNotification *)aNotification
    //    {
    //    self.textView.contentInset = UIEdgeInsetsZero;
    //    self.textView.scrollIndicatorInsets = UIEdgeInsetsZero;
    //    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
