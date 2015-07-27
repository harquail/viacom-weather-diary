//
//  TextInShape.swift
//  ParseStarterProject
//
//  Created by nook on 7/25/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class TextInShape: UITextView {

    
//    http://lepetit-prince.net/ios/?p=1403
//    - (UIView*)createRaindrop:(UIColor*)color
//    {
//    UIView *raindrop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [self.view addSubview:raindrop];
//    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(10, 0)];
//    [path addCurveToPoint:CGPointMake(10, 20) controlPoint1:CGPointMake(10, 3) controlPoint2:CGPointMake(20, 15)];
//    [path addCurveToPoint:CGPointMake(10, 0) controlPoint1:CGPointMake(0, 15) controlPoint2:CGPointMake(10, 3)];
//    
//    CAShapeLayer *sl = [[CAShapeLayer alloc] init];
//    sl.fillColor = color.CGColor;
//    sl.path = path.CGPath;
//    
//    [raindrop.layer addSublayer:sl];
//    return raindrop;
//    }
    
    
    private func rainDropShape() -> UIBezierPath{
        
        return UIBezierPath()
    
    }
    
    private func sunShape() -> UIBezierPath{
        
        return UIBezierPath()
        
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
