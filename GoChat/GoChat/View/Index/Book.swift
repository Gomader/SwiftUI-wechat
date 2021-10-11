//
//  Book.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import SwiftUI

struct Book: View {
    
    init(){
        
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
    
    @ObservedObject var friendrequest:FriendRequestList = FriendRequestList.sharedInstance
    
    var body: some View{
        
        ScrollView(.vertical,showsIndicators: false){
            
            VStack(spacing:0){
                
                NavigationLink(destination: NewFriend(), label: {
                    HStack{
                        
                        Image(systemName: "person.fill.badge.plus")
                            .font(.system(size: 25))
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(hex: 0xFFFFFF))
                            .background(Color(hex: 0xf39d4a))
                            .cornerRadius(4)
                            .padding()
                        
                        Text("新的朋友")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                        
                        Spacer()
                        
                        ZStack{
                            Circle()
                                .foregroundColor(.red)

                            Text(self.friendrequest.unRead == -1 ? "" : self.friendrequest.unRead > 99 ? "99+" : "\(self.friendrequest.unRead)")
                                .foregroundColor(.white)
                                .font(Font.system(size: 12))
                        }
                        .frame(width: 25, height: 25)
                        .opacity(self.friendrequest.unRead == 0 ? 0 : 1)
                        .padding()
                        
                    }.frame(width: screen_width)
                        .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                }).navigationTitle("")
                
            }
            
            
        }
        
    }
    
}
