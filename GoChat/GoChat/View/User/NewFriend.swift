//
//  NewFriend.swift
//  GoChat
//
//  Created by 宫赫 on 2021/10/12.
//

import SwiftUI

struct NewFriend: View {
    init(){
        
    }
    var body: some View {
        VStack{
            
            NewFriendTopbar()
            
            NewFriendScrollList()
            
        }.frame(maxHeight: .infinity,alignment: .top)
            .edgesIgnoringSafeArea(.top)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
    }
}

struct NewFriendTopbar: View{
    
    @State private var toSearchFriendPage = false
    
    var body: some View{
        ZStack{
            
            backButton()
            
            Text("新的朋友").font(.system(size: 17)).fontWeight(.semibold)
            
            HStack{
                Spacer()
                
                Button{
                    toSearchFriendPage.toggle()
                }label:{
                    
                    Text("添加朋友")
                        .font(.system(size: 15)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                        .padding(.horizontal)
                    
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

struct NewFriendScrollList: View{
    
    @ObservedObject var list:FriendRequestList = FriendRequestList.sharedInstance
    
    var body: some View{
        
        ScrollView(.vertical,showsIndicators: false){
            
            ForEach(list.list.indices,id: \.self){item in
                
                let index = list.list.count-item-1
                
                HStack{
                    
                    
                    
                }
                
            }
            
        }
        
    }
    
}
