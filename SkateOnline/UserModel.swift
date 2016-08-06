//
//  UserModel.swift
//  SkateOnline
//
//  Created by Kevin Shen on 8/5/16.
//  Copyright © 2016 Kevin Shen. All rights reserved.
//

class UserModel {
    
    var deviceId: String!
    var screenName: String!
    
    init(deviceId: String, screenName: String) {
        self.deviceId = deviceId
        self.screenName = screenName
    }
}