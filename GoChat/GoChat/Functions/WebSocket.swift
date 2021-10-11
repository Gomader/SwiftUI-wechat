//
//  WebSocket.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import Foundation
import UIKit
import Starscream

func WebsocketConnect() -> Void{
    
    var request = URLRequest(url: URL(string: "\(WEBSOCKET_HOST)")!)
    request.timeoutInterval = 5
    request.setValue("sessionid=\(ACCESS_TOKEN)", forHTTPHeaderField: "Cookie")
    SOCKET = WebSocket(request: request)
    SOCKET?.connect()
    SOCKET?.onEvent = {event in
        
        switch event{
        case .connected(let headers):
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            WebsocketTextEvent(text: string)
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
            break
        case .error(let error):
            print(error ?? "x")
        }
        
    }
    
}

func WebsocketDisconnect() -> Void{
    
    SOCKET?.disconnect()
    
}

func WebsocketTextEvent(text:String) -> Void{
    
    let jsonData:Data = text.data(using: .utf8)!
    
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary
    
    if dict == nil{return}
    
    switch (dict?["type"] as! String){
        
    case "":
        print(1)
    default:
        break
    }
    
}
