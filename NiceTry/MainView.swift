//
//  MainView.swift
//  NiceTry
//
//  Created by Abdykadyr Maksat on 25.11.2019.
//  Copyright © 2018 Abdykadyr Maksat. All rights reserved.
//
import UIKit

class MainView: UIView {
    var shapes: [MyModels] = []
    var tempShape: [MyModels] = []
    //var shapeModel: Shape = Shape()
    
    var first_point: CGPoint!
    var second_point: CGPoint!
    
    var path: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        for shape in shapes {
            path = shape.shape?.getPath(shape.key!)
        
            shape.color!.set()
            if shape.isFill!{
                path?.fill()
            }
            path?.stroke()
        }
        if !Shape.isPen {
            for shape in tempShape{
                let path = shape.shape?.getPath(shape.key!)
                
                shape.color!.set()
                if shape.isFill!{
                    path?.fill()
                }
                path?.stroke()
            }
            tempShape = []
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let viewController: ViewController = ViewController()
        if Shape.isPen{
            second_point = touches.first?.location(in: self)
            shapes.append(MyModels(shape: Shape(first_point, second_point),
                                   key: ViewController.key,
                                   color: ViewController.color, isFill: ViewController.isFill))
            first_point = second_point
            setNeedsDisplay()
        } else {
            second_point = touches.first?.location(in: self)
            tempShape.append(MyModels(shape: Shape(first_point, second_point), key: ViewController.key,
                                color: ViewController.color, isFill: ViewController.isFill))
            setNeedsDisplay()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        first_point = touches.first?.location(in: self)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let viewController: ViewController = ViewController()
        second_point = touches.first?.location(in: self)
        shapes.append(MyModels(shape: Shape(first_point, second_point), key: ViewController.key,
                               color: ViewController.color, isFill: ViewController.isFill))
        setNeedsDisplay()
    }
    
    func deleteLast(){
        if !shapes.isEmpty {
            shapes.removeLast()
            setNeedsDisplay()
        }
    }
    func createTriangle() {
        path = UIBezierPath()
        path?.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path?.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path?.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path?.close()
    }
}
