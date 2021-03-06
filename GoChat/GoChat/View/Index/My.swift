//
//  My.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import SwiftUI
import Kingfisher

struct My: View {
    
    @Binding var logined:Bool
    @Binding var newMessage:Int
    
    init(logined: Binding<Bool>, newMessage: Binding<Int>){
        
        self._logined = logined
        self._newMessage = newMessage
        
        let json:NSDictionary = getSelfUserInfo()
        if json["code"] as! Int == 200{
            
            USER_INFO["id"] = (json["data"] as! [NSDictionary])[0]["pk"]
            
            let data = (json["data"] as! [NSDictionary])[0]["fields"] as! NSDictionary
            USER_INFO["email"] = data["email"]
            USER_INFO["username"] = data["username"]
            USER_INFO["sex"] = data["sex"]
            USER_INFO["icon"] = data["icon"]
            
            SaveUserInfo()
            
        }
    }
    var body: some View {
            
            VStack{
                
                NavigationLink(destination: UserInfo(), label: {
                    MyTopbar()
                }).navigationTitle("")
                
                NavigationLink(destination: SettingMain(logined: $logined), label: {
                    
                    HStack{
                        Image(systemName: "gearshape")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                            .padding()
                        
                        Text("设置")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(hex: 0x5f5f5f))
                            .padding()
                        
                    }.frame(width: screen_width)
                        .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                    
                }).navigationTitle("")
                
                Spacer()
                
            }.frame(maxHeight: .infinity,alignment: .top)
            .edgesIgnoringSafeArea(.top)
                .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))

    }
}

struct MyTopbar: View{
    var body: some View{
        
        ZStack{
            
            HStack{
                            
                if USER_INFO["icon"] as! String == ""{
                    Image(systemName: "person.fill")
                        .font(.system(size: 50))
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                        .padding(.leading, screen_width*0.1)
                        .foregroundColor(Color(hex: 0xECECEC))
                }else{
                    KFImage.url(URL(string: "\(HOST)/media/\(USER_INFO["icon"] as! String)")!)
                        .placeholder({
                            Image(systemName: "person.fill")
                                .font(.system(size: 50))
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                                .padding(.leading, screen_width*0.1)
                                .foregroundColor(Color(hex: 0xECECEC))
                        })
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                        .padding(.leading, screen_width*0.1)
                }
                
                Spacer()
                
            }
            
            VStack(alignment: .leading){
                
                Text("\(USER_INFO["username"] as! String)")
                    .foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                    .font(.system(size: 20))
                    .bold()
                    .lineLimit(1)
                
                Text("uuid:\(USER_INFO["id"] as! String)")
                    .foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                    .font(.system(size: 15))
                    .lineLimit(1)
                
            }.frame(width: screen_width*0.4)
            
            HStack{
                
                Spacer()
                
                Button(action:{}){
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(hex: 0x5f5f5f))
                        .padding()
                }
                
            }
            
        }.frame(width: screen_width, height: 100,alignment: .leading)
            .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
    }
}
