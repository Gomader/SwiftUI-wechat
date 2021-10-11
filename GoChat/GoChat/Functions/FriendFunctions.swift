//
//  FriendFunctions.swift
//  GoChat
//
//  Created by 宫赫 on 2021/10/10.
//

import Foundation
import UIKit
import Alamofire
import SwiftUI

func getFriendList() -> Void{
    
    var json:NSDictionary = [:]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/getFriendList/"
    let headers: HTTPHeaders = [
        "Cookie": "sessionid=\(ACCESS_TOKEN)"
    ]
    
    AF.request(url,method: .post, headers: headers)
        .responseJSON(queue: DispatchQueue.global(qos: .default),completionHandler: { (response) in
            
            do{
                json = try JSONSerialization.jsonObject(with: response.data!, options: []) as! NSDictionary
            }catch{
 
            }
            semaphone.signal()
            
        })
    _ = semaphone.wait(timeout: .distantFuture)
    
    let list:FriendList = FriendList.sharedInstance
    list.list = json as! Dictionary
    SaveFriendList()
    
}

func sendFriendRequest(id:String) -> NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/sendFriendRequest/"
    let headers: HTTPHeaders = [
        "Cookie": "sessionid=\(ACCESS_TOKEN)"
    ]
    
    AF.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append("\(id)".data(using: .utf8)!, withName: "id")
            
        }, to: url, method: .post, headers: headers)
        .responseJSON(queue: DispatchQueue.global(qos: .default), completionHandler: { (response) in
            
            do{
                json = try JSONSerialization.jsonObject(with: response.data!, options: []) as! NSDictionary
            }catch{
 
            }
            semaphone.signal()
            
        })
    
    _ = semaphone.wait(timeout: .distantFuture)
    return json
    
}

func getFriendRequestList() -> Void{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/getFriendRequestList/"
    let headers: HTTPHeaders = [
        "Cookie": "sessionid=\(ACCESS_TOKEN)"
    ]
    
    AF.request(url,method: .post, headers: headers)
        .responseJSON(queue: DispatchQueue.global(qos: .default),completionHandler: { (response) in
            
            do{
                json = try JSONSerialization.jsonObject(with: response.data!, options: []) as! NSDictionary
            }catch{
 
            }
            semaphone.signal()
            
        })
    _ = semaphone.wait(timeout: .distantFuture)
    
    let list:FriendRequestList = FriendRequestList.sharedInstance
    let data:[NSDictionary] = json["data"] as! [NSDictionary]
    
    for i in 0...data.count{
        
        let id = (data[i]["fields"] as! NSDictionary)["applicant"] as! String
        
        var count = 0
        
        for j in 0...(list.list.count) {
            if (list.list[j]["applicant"] as! String) == id{
                if list.list[j]["state"] as! Int == 2{
                    list.list.remove(at: j)
                }else{
                    count += 1
                }
                break
            }
        }
        
        if count == 0{
            var dict = Dictionary<String, Any>()
            dict["applicant"] = id
            dict["state"] = 0
            list.list.append(dict)
            list.unRead += 1
        }
        
    }
    
    for i in 0...(list.list.count){
        
        var count = 0
        
        for j in 0...(data.count){
            
            if (data[j]["fields"] as! NSDictionary)["applicant"] as! String == list.list[i]["applicant"] as! String{
                
                count += 1
                
            }
            
        }
        
        if count == 0{
            
            list.list[i]["state"] = 2
            
        }
        
    }
    SaveFriendRequestList()
    
}


