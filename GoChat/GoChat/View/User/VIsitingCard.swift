//
//  VIsitingCard.swift
//  GoChat
//
//  Created by 宫赫 on 2021/10/5.
//

import SwiftUI
import Kingfisher
import AlertToast

struct VIsitingCard: View {
    
    @Environment(\.presentationMode) private var presentationMode
    let user:NSDictionary
    @State var showSheet = false
    @State var json:NSDictionary = NSDictionary()
    
    var body: some View {
        
        VStack{
            
            VIsitingCardTopbar(user: user)
            
            if FRIENDLIST[user["pk"] as! String] == nil{
                Button(action: {
                    json = sendFriendRequest(id: user["pk"] as! String)
                    showSheet.toggle()
                }, label: {
                    HStack{
                        Text("添加到通讯录")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                            .padding()
                    }.frame(maxWidth: .infinity)
                    .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                })
            }
            
        }.frame(maxWidth: screen_width, maxHeight: .infinity, alignment: .top)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
            .edgesIgnoringSafeArea(.all)
            .toast(isPresenting: $showSheet, duration: 2, tapToDismiss: false, offsetY: 0, alert: {
                if json.count==0 {
                    return AlertToast(type: .loading,title: Optional("Loding"))
                }else{
                    if json["code"] as! Int == 200{
                        return AlertToast(type: .complete(Color(hex: 0x2EA043)),title: Optional(json["msg"] as! String))
                    }else{
                        return AlertToast(type: .error(Color(hex: 0xD30E0E)),title: Optional(json["msg"] as! String))
                    }
                }
            }, onTap: {}, completion: {
                presentationMode.wrappedValue.dismiss()
            })
            
        
    }
}

struct VIsitingCardTopbar: View{
    
    let user:NSDictionary
    
    var body: some View{
        VStack{
            
            backButton()
            
            HStack{
                
                let data = user["fields"] as! NSDictionary
                
                if data["icon"] as! String == ""{
                    Image(systemName: "person.fill")
                        .font(.system(size: 50))
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                        .foregroundColor(Color(hex: 0xECECEC))
                }else{
                    KFImage.url(URL(string: "\(HOST)/media/\(data["icon"] as! String)")!)
                        .placeholder({
                            Image(systemName: "person.fill")
                                .font(.system(size: 50))
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                                .foregroundColor(Color(hex: 0xECECEC))
                        })
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                }
                
                VStack(alignment: .leading){
                    
                    Text("\(data["username"] as! String)")
                        .foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                        .font(.system(size: 20))
                        .bold()
                        .lineLimit(1)
                    
                    Text("昵称：\(data["username"] as! String)")
                        .foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                        .font(.system(size: 15))
                        .lineLimit(1)
                    
                    Text("uuid：\(user["pk"] as! String)")
                        .foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                        .font(.system(size: 15))
                        .lineLimit(1)
                    
                }.padding()
                
                Spacer()
                
            }.padding()
            .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
            
        }.frame(width: screen_width)
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
        .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
    }
}
