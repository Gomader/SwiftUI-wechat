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