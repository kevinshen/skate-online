//
//  ViewController.swift
//  SkateOnline
//
//  Created by Kevin Shen on 7/19/16.
//  Copyright © 2016 Kevin Shen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var validNameLabel: UILabel!
    @IBOutlet var screenNameTextField: UITextField!
    @IBOutlet var playNowButton: UIButton!
    
    var userData: UserModel!
    var resourceURI: String! = Config.findUserURI
    var deviceId: String! = UIDevice.currentDevice().identifierForVendor!.UUIDString
    var newUser: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        validNameLabel.text = ""
        
        screenNameTextField.delegate = self;
        screenNameTextField.text = "Screen Name"
        screenNameTextField.textColor = UIColor.lightGrayColor()
        
        self.navigationItem.title = "Home"
        
        playNowButton.userInteractionEnabled = false
        
        print(deviceId)
        
        fetchScreenName(resourceURI, deviceId: self.deviceId) { () -> Void in
            self.screenNameTextField.text = self.userData.screenName
            self.screenNameTextField.textColor = UIColor.blackColor()
            self.playNowButton.userInteractionEnabled = true
        }
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
        if textField.text!.isEmpty {
            validNameLabel.text = ""
            textField.text = "Screen Name"
            textField.textColor = UIColor.lightGrayColor()
            playNowButton.userInteractionEnabled = false
        } else {
            validNameLabel.text = "Welcome mate"
            playNowButton.userInteractionEnabled = true
        }
    }
    
    func fetchScreenName(requestURI: String, deviceId: String, completion: () -> Void) {
        
        let url = requestURI + deviceId
        
        Alamofire.request(.GET, url, encoding: .JSON).responseData { response in
            switch response.result {
            case .Success(_):
                let responseData: JSON = JSON(data: response.data!)
                print(responseData)
                if responseData.count == 0 {
                    self.newUser = true
                    print("User doesn't exist!")
                } else if responseData.count > 1 {
                    self.newUser = true
                    print("Multiple MongoDB documents with deviceId" + deviceId)
                } else {
                    self.newUser = false
                    self.userData = UserModel(deviceId: responseData[0]["device_id"].string!, screenName: responseData[0]["screen_name"].string!)
                    completion()
                }
                print("Success")
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func addNewUser(requestURI: String, deviceId: String, screenName: String, completion: () -> Void) {
        
        let params = ["device_id": deviceId, "screen_name": screenName]
        
        Alamofire.request(.POST, requestURI, parameters: params, encoding: .JSON).responseData { response in
            switch response.result {
            case .Success(_):
                print("Success")
            case .Failure(let error):
                print(error)
            }
        }
    }



}

