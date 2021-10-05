//
//  Search.swift
//  GoChat
//
//  Created by 宫赫 on 2021/10/5.
//

import Foundation
import UIKit
import Alamofire

func SearchUserByEmailOrUUID(key:String) -> NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/searchUser/"
    let headers: HTTPHeaders = [
        "Cookie": "sessionid=\(ACCESS_TOKEN)"
    ]
    
    AF.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append("\(key)".data(using: .utf8)!, withName: "key")
            
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
