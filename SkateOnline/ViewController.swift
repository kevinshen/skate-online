//
//  ViewController.swift
//  SkateOnline
//
//  Created by Kevin Shen on 7/19/16.
//  Copyright © 2016 Kevin Shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var validNameLabel: UILabel!
    @IBOutlet var screenNameTextField: UITextField!
    @IBOutlet var playNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        validNameLabel.text = ""
        
        screenNameTextField.delegate = self;
        screenNameTextField.text = "Screen Name"
        screenNameTextField.textColor = UIColor.lightGrayColor()
        
        playNowButton.userInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.textColor == UIColor.lightGrayColor() {
            textField.text = nil
            textField.textColor = UIColor.blackColor()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if textField.text == "Kevin" {
            validNameLabel.text = "Welcome mate"
            playNowButton.userInteractionEnabled = true
        } else if textField.text!.isEmpty {
            validNameLabel.text = ""
            textField.text = "Screen Name"
            textField.textColor = UIColor.lightGrayColor()
            playNowButton.userInteractionEnabled = false
        } else {
            validNameLabel.text = "Nice scooter n00b"
            playNowButton.userInteractionEnabled = false
        }
        
    }



}

