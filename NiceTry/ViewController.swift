//
//  ViewController.swift
//  NiceTry
//
//  Created by Abdykadyr Maksat on 25.11.2019.
//  Copyright © 2018 Abdykadyr Maksat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, colorDelegate {
    
    static var color: UIColor = UIColor.black
    static var isFill: Bool = false
    
    @IBAction func switchFill(_ sender: UISwitch) {
        if sender.isOn {
            ViewController.isFill = true
        } else {
            ViewController.isFill = false
        }
    }
    @IBOutlet weak var fillSwitch: UISwitch!
    @IBOutlet weak var currentColor: UIButton!
    static var key = 0
    static var operations: Dictionary<UIImage, Int> = [
        #imageLiteral(resourceName: "circle"): 0,
        #imageLiteral(resourceName: "rectangle"): 1,
        #imageLiteral(resourceName: "line"): 2,
        #imageLiteral(resourceName: "triangle"): 3,
        #imageLiteral(resourceName: "pen"): 4
    ]
    
    @IBOutlet weak var pickerView: ColorPicker!
    //let mainView = MainView(frame: UIScreen.main.bounds)
    @IBOutlet weak var mainView: MainView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self;
    
    }
    func pickedColor(color: UIColor) {
        currentColor.backgroundColor = color
        ViewController.color = color
        //mainView.backgroundColor = color;
    }
    @IBAction func shapePressed(_ sender: UIButton) {
        ViewController.key = ViewController.operations[sender.currentImage!]!
    }
    
    @IBAction func undoPressed(_ sender: UIButton) {
        mainView.deleteLast()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
