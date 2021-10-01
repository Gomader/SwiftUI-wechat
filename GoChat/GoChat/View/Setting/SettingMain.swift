//
//  SettingMain.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/30.
//

import SwiftUI
import AlertToast

struct SettingMain: View {
    
    @State var showToast = false
    @State var json:NSDictionary = NSDictionary()
    @Binding var logined:Bool
    
    var body: some View {
        VStack{
            
            SettingMainTopbar()
            
            VStack(spacing: 0){
                    
                NavigationLink(destination: General(),label: {
                    
                    HStack{
                        
                        Text("通用")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(hex: 0x5f5f5f))
                            .padding()
                        
                    }.frame(width: screen_width)
                        .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                
                }).navigationTitle("")
                
            }
            
            HStack{
                
                Button(action: {
                    json = SignOut()
                    showToast.toggle()
                }){
                    Text("退出登录")
                        .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                        .padding()
                }
                
            }.frame(width: screen_width)
                .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
            
            
        }.frame(maxHeight: .infinity,alignment: .top)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
            .edgesIgnoringSafeArea(.all)
            .toast(isPresenting: $showToast, duration: 2, tapToDismiss: false, offsetY: 0, alert: {
                if json.count==0 {
                    return AlertToast(type: .loading,title: Optional(""))
                }else{
                    if json["code"] as! Int == 200{
                        return AlertToast(type: .complete(Color(hex: 0x2EA043)),title: Optional(json["msg"] as! String))
                    }else{
                        return AlertToast(type: .error(Color(hex: 0xD30E0E)),title: Optional(json["msg"] as! String))
                    }
                }
            }, onTap: {}, completion: {
                if json["code"] as! Int == 200{
                    DeleteLocalData()
                    logined = false
                }
            })
    }
}

struct SettingMainTopbar: View{
    var body: some View{
        ZStack{
            
            Text("设置").font(.system(size: 17)).fontWeight(.semibold)
                .padding()
            
            
        }.frame(width: screen_width)
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
    }
}
