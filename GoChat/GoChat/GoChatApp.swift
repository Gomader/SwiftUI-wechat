//
//  GoChatApp.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/25.
//

import SwiftUI

@main
struct GoChatApp: App {
    init(){
        
        if UserDefaults.standard.string(forKey: "ACCESS_TOKEN") != nil{
                
            let token:String = UserDefaults.standard.string(forKey: "ACCESS_TOKEN")!
            let json:NSDictionary = CheckToken(token: token)
            if json["code"] as! Int == 200{
                ACCESS_TOKEN = UserDefaults.standard.string(forKey: "ACCESS_TOKEN")!
            }
            
            if UserDefaults.standard.dictionary(forKey: "USER_INFO") != nil{
                
                USER_INFO = UserDefaults.standard.dictionary(forKey: "USER_INFO")!
                
            }
            
        }
        
        
    }
    var body: some Scene {
        WindowGroup {
            HomeView();
        }
    }
}
