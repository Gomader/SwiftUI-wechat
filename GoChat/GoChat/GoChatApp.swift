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
                print(ACCESS_TOKEN)
            }
            
            if UserDefaults.standard.dictionary(forKey: "USER_INFO") != nil{
                USER_INFO = UserDefaults.standard.dictionary(forKey: "USER_INFO")!
            }
            
            if UserDefaults.standard.array(forKey: "MessageBoxList") != nil{
                let list:MessageList = MessageList.sharedInstance
                list.list = UserDefaults.standard.array(forKey: "MessageBoxList")!
            }
            
            if UserDefaults.standard.dictionary(forKey: "FRIENDLIST") != nil{
                let list:FriendList = FriendList.sharedInstance
                list.list = UserDefaults.standard.dictionary(forKey: "FRIENDLIST")!
            }
            
            if UserDefaults.standard.array(forKey: "FriendRequestList") != nil{
                let list:FriendRequestList = FriendRequestList.sharedInstance
                list.list = UserDefaults.standard.array(forKey: "FriendRequestList") as! [Dictionary<String, Any>]
                list.unRead = UserDefaults.standard.integer(forKey: "FriendRequestListUnReadNumber")
            }
            
        }
        
        
    }
    var body: some Scene {
        WindowGroup {
            HomeView();
        }
    }
}
