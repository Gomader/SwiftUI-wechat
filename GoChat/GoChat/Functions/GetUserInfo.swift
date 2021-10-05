//
//  GetUserInfo.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/29.
//

import Foundation
import UIKit
import Alamofire

func getSelfUserInfo() -> NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/getUserInfo/"
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
    return json
    
}

func getFriendUserInfo(id: String) -> NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/getFriendInfo/"
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

func getFriendList() -> NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
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
    return json
    
}
