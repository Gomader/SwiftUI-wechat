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
        Init()
    }
    var body: some Scene {
        WindowGroup {
            HomeView();
        }
    }
}
