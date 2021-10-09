//
//  WebSocket.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import UIKit
import Starscream

class WebSocketLink: WebSocketDelegate{
    
    var isConnected:Bool = false
    
    func connect(){
        
        var request = URLRequest(url: URL(string: "\(WEBSOCKET_HOST)")!)
        request.timeoutInterval = 5
        request.setValue("sessionid=\(ACCESS_TOKEN)", forHTTPHeaderField: "Cookie")
        SOCKET = WebSocket(request: request)
        SOCKET?.delegate = self
        SOCKET?.connect()
        
    }
    
    func disconnect() {
        SOCKET?.disconnect()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        
        switch event{
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            print(error ?? "x")
        }
    }
    
}
