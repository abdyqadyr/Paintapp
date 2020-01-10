//
//  ColorPicker.swift
//  NiceTry
//
//  Created by Abdykadyr Maksat on 25.11.2019.
//  Copyright © 2018 Abdykadyr Maksat. All rights reserved.
//

import UIKit
@objc protocol colorDelegate{
    @objc optional func pickedColor(color:UIColor)
}


class ColorPicker: UIView {
    var currentSelectionX: CGFloat = 0;
    var selectedColor: UIColor!
    var delegate: colorDelegate!
    var first_point: CGPoint?
    var second_point: CGPoint?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        /*let aPath = UIBezierPath()
        if let point = first_point{
            //print("something")
            UIColor.black.set()
            aPath.addArc(withCenter: point, radius: CGFloat(100.0), startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        }*/
        
        UIColor.black.set()
        var tempYPlace = self.currentSelectionX;
        if (tempYPlace < CGFloat (0.0)) {
            tempYPlace = CGFloat (0.0);
        } else if (tempYPlace >= self.frame.size.width) {
            tempYPlace = self.frame.size.width - 1.0;
        }
        let h = self.frame.size.height
        //let temp = CGRect(x: CGFloat(100.0), y: tempYPlace, width: CGFloat(1.0), height: h)
        //let temp = CGRect(0.0, tempYPlace, 1.0, self.frame.size.height);
        //let temp = CGRect(origin: CGPoint.init(x: CGFloat(0), y: tempYPlace), size: self.frame.size.height)
        //UIRectFill(temp);
        
        //draw central bar over it
        let width = Int(self.frame.size.width)
        for i in 0 ..< width {
            UIColor(hue:CGFloat (i)/self.frame.size.width, saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
            
            //let temp = CGRectMake(CGFloat (i), 0, 1.0, self.frame.size.height);
            let temp = CGRect(x: CGFloat(i), y: CGFloat(0), width: CGFloat(1), height: h)
            UIRectFill(temp);
        }
        
    }
    
    
    //Changes the selected color, updates the UI, and notifies the delegate.
    func selectedColor(sColor: UIColor){
        if (sColor != selectedColor)
        {
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            var alpha: CGFloat = 0
            
            if sColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
                //currentSelectionX = CGFloat (hue * self.frame.size.height);
                self.setNeedsDisplay();
                
            }
            selectedColor = sColor
            self.delegate.pickedColor!(color: selectedColor)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch =  touches.first
        updateColor(touch: touch!)
        first_point = touches.first?.location(in: self)
        setNeedsDisplay()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch =  touches.first
        updateColor(touch: touch!)
        first_point = touches.first?.location(in: self)
        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch =  touches.first
        updateColor(touch: touch!)
        first_point = touches.first?.location(in: self)
        setNeedsDisplay()
    }
    
    func updateColor(touch: UITouch){
        currentSelectionX = (touch.location(in: self).x)
        selectedColor = UIColor(hue: (currentSelectionX / self.frame.size.width), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        self.delegate.pickedColor!(color: selectedColor)
        self.setNeedsDisplay()
    }
}

