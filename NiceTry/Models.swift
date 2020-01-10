//
//  Models.swift
//  NiceTry
//
//  Created by Abdykadyr Maksat on 25.11.2019.
//  Copyright © 2018 Abdykadyr Maksat. All rights reserved.
//

import Foundation
import UIKit

import Foundation
import UIKit

class Shape {
    let viewController: ViewController = ViewController()
    var first_point: CGPoint?
    var second_point: CGPoint?
    static var isPen: Bool = false
    var aPath = UIBezierPath()
    init(_ first: CGPoint, _ second: CGPoint) {
        first_point = first
        second_point = second
    }
    func getPath(_ key: Int) -> UIBezierPath {
        aPath = UIBezierPath()
        switch key {
        case 0:   //circle
            Shape.isPen = false
            aPath.addArc(withCenter: getCenter(first_point: first_point!, second_point: second_point!),
                         radius: getRadius(first_point: first_point!, second_point: second_point!),
                         startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
            break
        case 1:   //rectangle
            Shape.isPen = false
            let rect = CGRect(origin: first_point!, size: getSize(first_point!, second_point!))
            aPath = UIBezierPath(rect: rect)
            break
        case 2:   //line
            Shape.isPen = false
            aPath.move(to: first_point!)
            aPath.addLine(to: second_point!)
            break
        case 3:   //triangle
            Shape.isPen = false
            let path = UIBezierPath()
            path.move(to: first_point!)
            path.addLine(to: second_point!)
            path.addLine(to: CGPoint(x: first_point!.x, y: second_point!.y))
            path.close()
            
            /*aPath.move(to: first_point!)
            aPath.addLine(to: second_point!)
            aPath.move(to: first_point!)
            aPath.addLine(to: CGPoint(x: first_point!.x, y: second_point!.y))
            aPath.move(to: second_point!)
            aPath.addLine(to: CGPoint(x: first_point!.x, y: second_point!.y))*/
            aPath = path
            
            break
        case 4:   //pen
            Shape.isPen = true
            aPath.move(to: first_point!)
            aPath.addLine(to: second_point!)
            break
        default:
            break
        }
        aPath.stroke()
        //aPath.fill()
        return aPath
    }
}

class MyModels{
    var shape: Shape?
    var key: Int?
    var color: UIColor?
    var isFill: Bool?
    init(shape: Shape, key: Int, color: UIColor, isFill: Bool) {
        self.shape = shape
        self.key = key
        self.color = color
        self.isFill = isFill
    }
}











func getDouble(_ cgFloat: CGFloat) -> Double{
    return Double(cgFloat)
}

func getRadius(first_point: CGPoint, second_point: CGPoint) -> CGFloat {
    let distance = sqrt(Double(pow(getDouble(first_point.x - second_point.x), 2)) + Double(pow(first_point.y - second_point.y, 2)))
    return CGFloat(distance/2)
}
func getCenter(first_point: CGPoint, second_point: CGPoint) -> CGPoint {
    return CGPoint(x: CGFloat(((Double(first_point.x)) + Double(second_point.x))/2), y: CGFloat(((Double(first_point.y)) + Double(second_point.y))/2))
}
func getSize(_ first_point: CGPoint, _ second_point: CGPoint) -> CGSize {
    let width = second_point.x - first_point.x
    let height = second_point.y - first_point.y
    return CGSize(width: width, height: height)
}
