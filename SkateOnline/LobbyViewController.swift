//
//  LobbyViewController.swift
//  SkateOnline
//
//  Created by Kevin Shen on 9/28/16.
//  Copyright © 2016 Kevin Shen. All rights reserved.
//

import UIKit
import SocketIO

class LobbyViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var chatTableView: UITableView!
    
    var socket: SocketIOClient?
    
    var messages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        self.navigationItem.title = "Lobby"
    }
    
    override func viewDidAppear(animated: Bool) {
        
        #if (arch(i386) || arch(x86_64))
            socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:8080")!)
        #else
            socket = SocketIOClient(socketURL: NSURL(string: "http://[IP]:8080")!)
        #endif
        
        addHandlers()
        socket!.connect()
        
    }
    
    
    func addHandlers() {
        
        socket?.on("newMessage") { [weak self] data, ack in
            if let message = data[0] as? String {
                self?.messages.append(message)
                self?.chatTableView.reloadData()
            }
        }
        
    }
    
}

extension LobbyViewController: UITableViewDataSource {

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! ChatTableViewCell
        
        let message = messages[indexPath.row]
        cell.nameLabel.text = message
        
        return cell
    }
}
