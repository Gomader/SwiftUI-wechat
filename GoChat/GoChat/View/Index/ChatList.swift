//
//  ChatList.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import SwiftUI

struct ChatList: View {
    
    @ObservedObject var list:MessageList = MessageList.sharedInstance
    @Binding var newMessage:Int
    
    var body: some View {
        VStack{
            
            ChatListTopbar()
            
            ChatListScrollList()
            
            
        }.edgesIgnoringSafeArea(.top)
    }
}

struct ChatListTopbar: View{
    
    @State private var toSearchFriendPage = false
    
    var body: some View{
        ZStack{
            
            Text("GoChat").font(.system(size: 17)).fontWeight(.semibold)
            
            HStack{
                Spacer()
                
                Menu{
                    
                    Button(action: {
                        toSearchFriendPage.toggle()
                    }, label: {
                        Image(systemName: "person.fill.badge.plus")
                            .padding()
                        Text("添加朋友")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "qrcode.viewfinder")
                            .padding()
                        Text("扫一扫")
                    })
                    
                }label:{
                    
                    Image(systemName: "plus.circle")
                        .font(.system(size: 20))
                        .foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                        .padding()
                    
                }.background(
                    ZStack{
                        NavigationLink(destination: SearchFriend(), isActive: $toSearchFriendPage, label: {})
                    }
                )
            }
            
        }.padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
    }
}

struct ChatListScrollList: View{
    
    @ObservedObject var list:MessageList = MessageList.sharedInstance
    
    var body: some View{
        ScrollView(.vertical,showsIndicators: false){
                
            ForEach(list.list.indices, id:\.self){item in

                Text("\(list.list[list.list.count-item-1] as! Int)")

            }
            
        }.background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
    }
}
