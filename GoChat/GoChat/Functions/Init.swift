//
//  Init.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/28.
//

import Foundation

func Init() -> Void{
    if UserDefaults.standard.string(forKey: "ACCESS_TOKEN") != nil{
        ACCESS_TOKEN = UserDefaults.standard.string(forKey: "ACCESS_TOKEN")!
    }
}
