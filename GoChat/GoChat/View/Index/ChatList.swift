//
//  ChatList.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import SwiftUI

struct ChatList: View {
    var body: some View {
        VStack{
            
            ChatListTopbar()
            
            ChatListScrollList()
            
        }
    }
}

struct ChatListTopbar: View{
    var body: some View{
        ZStack{
            
            Text("GoChat").font(.system(size: 17)).fontWeight(.semibold)
            
            HStack{
                Spacer()
                
                Button(action: {}){
                    Image(systemName: "plus.circle").font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                }.padding()
            }
            
        }.padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
            .edgesIgnoringSafeArea(.top)
    }
}

struct ChatListScrollList: View{
    var body: some View{
        ScrollView(.vertical,showsIndicators: false){
            Text("122")
        }.background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
    }
}
