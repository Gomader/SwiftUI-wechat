//
//  Book.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import SwiftUI

struct Book: View {
    
    @Binding var newMessage:Int
    
    init(newMessage: Binding<Int>){
        self._newMessage = newMessage
        FRIENDLIST = getFriendList()["data"] as! Dictionary<String, Any>
    }
    
    var body: some View {
        VStack{
            
            BookTopbar()
            
            BookListScrollList()
            
        }.frame(maxHeight: .infinity,alignment: .top)
            .edgesIgnoringSafeArea(.top)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
    }
}

struct BookTopbar: View{
    
    @State private var toSearchFriendPage = false
    
    var body: some View{
        ZStack{
            
            Text("通讯录").font(.system(size: 17)).fontWeight(.semibold)
            
            HStack{
                Spacer()
                
                Button{
                    toSearchFriendPage.toggle()
                }label:{
                    
                    Image(systemName: "person.badge.plus")
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

struct BookListScrollList: View{
    
    var body: some View{
        
        ScrollView(.vertical,showsIndicators: false){
            
            VStack(spacing:0){
                
                HStack{
                    
                    Image(systemName: "person.fill.badge.plus")
                        .font(.system(size: 25))
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(hex: 0xFFFFFF))
                        .background(Color(hex: 0xf39d4a))
                        .cornerRadius(4)
                        .padding()
                    
                    Text("新的朋友")
                    
                    Spacer()
                    
                }.frame(width: screen_width)
                    .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                
            }
            
            
        }
        
    }
    
}
