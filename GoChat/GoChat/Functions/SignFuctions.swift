//
//  SignFuctions.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/26.
//

import Foundation
import UIKit
import Alamofire

func Login(Account:String,Password:String)->NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/signin/"
    
    AF.upload(
        multipartFormData: { multipartFormData in
            multipartFormData.append("\(Account)".data(using: .utf8)!, withName: "account")
            multipartFormData.append("\(Password)".data(using: .utf8)!, withName: "password")
        }, to: url, method: .post)
        .resume()
        .responseJSON(queue: DispatchQueue.global(qos: .default),completionHandler: {(response) in
            do{
                json = try JSONSerialization.jsonObject(with: response.data!, options: []) as! NSDictionary
            }catch{
 
            }
            semaphone.signal()
        })
    _ = semaphone.wait(timeout: .distantFuture)
    return json
    
}


func SignUp(Username:String,Email:String,Password:String,Icon:Data)->NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/signup/"
    
    AF.upload(
        multipartFormData: { multipartFormData in
            
            if Icon.count==0{}else{
                let usericon = UIImage(data: Icon)!.jpegData(compressionQuality: 10)
                multipartFormData.append(usericon!, withName: "icon", fileName: "icon.png", mimeType: "image/png")
            }
            multipartFormData.append("\(Username)".data(using: .utf8)!, withName: "username")
            multipartFormData.append("\(Email)".data(using: .utf8)!, withName: "email")
            multipartFormData.append("\(Password)".data(using: .utf8)!, withName: "password")
            
        }, to: url, method: .post)
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

func CheckToken(token:String)->NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/checkToken/"
    let headers: HTTPHeaders = [
        "Cookie": "sessionid=\(token)"
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

func SignOut() -> NSDictionary{
    
    var json:NSDictionary = ["code":400,"msg":"Local error"]
    let semaphone = DispatchSemaphore(value: 0)
    
    let url = "\(HOST)/account/signout/"
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
