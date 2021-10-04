//
//  WebSocket.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import UIKit
import Starscream

class ChatLink: WebSocketDelegate{
    
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        
    }
    
}
