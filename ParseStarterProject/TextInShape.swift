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
            //rectangles don't need exlusion paths
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
    
    // makes a raindrop-shaped path
    // TODO: this is very hacky
    private func rainDropShape() -> UIBezierPath{
        let frm = self.frame
        let xCenter = frm.width/2
        var path = UIBezierPath()
        //draw two curves, composing the raindrop
        path.moveToPoint(CGPointMake(xCenter,0))
        path.addCurveToPoint(CGPointMake(xCenter, frm.width), controlPoint1: CGPointMake(xCenter, 30) , controlPoint2: CGPointMake(frm.width, frm.width-50))
        path.addCurveToPoint(CGPointMake(xCenter, 0), controlPoint1: CGPointMake(0, frm.width-50) , controlPoint2: CGPointMake(xCenter, 30))
        //scale the path to fit well
        path.applyTransform(CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5))
        path.applyTransform(CGAffineTransformMakeTranslation(-frm.width/4, 0))
        return path
    }
    
    private func sunShape() -> UIBezierPath{
        
        return UIBezierPath(ovalInRect: CGRectMake(0, 0, self.frame.width, self.frame.width)).bezierPathByReversingPath()
    }
    
}
