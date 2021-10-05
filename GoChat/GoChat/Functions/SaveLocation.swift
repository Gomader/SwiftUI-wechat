//
//  SaveLocation.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/28.
//

import Foundation

func SaveAccessToken() -> Void{
    UserDefaults.standard.setValue(ACCESS_TOKEN, forKey: "ACCESS_TOKEN")
}

func SaveUserInfo() -> Void{
    UserDefaults.standard.setValue(USER_INFO, forKey: "USER_INFO")
}

func SaveMessageBoxList() -> Void{
    let list:MessageList = MessageList.sharedInstance
    UserDefaults.standard.setValue(list, forKey: "MessageBoxList")
}

func SaveFriendList() -> Void{
    UserDefaults.standard.setValue(FRIENDLIST, forKey: "FRIENDLIST")
}

func DeleteLocalData() -> Void{
    let userDefaults = UserDefaults.standard
    let dics = userDefaults.dictionaryRepresentation()
    for key in dics {
        userDefaults.removeObject(forKey: key.key)
    }
    userDefaults.synchronize()
}
