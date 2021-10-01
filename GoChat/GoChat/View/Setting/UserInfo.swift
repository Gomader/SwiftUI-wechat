//
//  UserInfo.swift
//  GoChat
//
//  Created by 宫赫 on 2021/10/2.
//

import SwiftUI

struct UserInfo: View {
    var body: some View {
        
        VStack{
            
            UserInfoTopbar()
            
            VStack(spacing:0){
                
                NavigationLink(destination: {}, label: {
                    
                    HStack{
                        
                        Text("头像")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                            .padding()
                        
                        Spacer()
                        
                        HStack{
                            
                            if USER_INFO["icon"] as! String == ""{
                                Image(systemName: "person.fill")
                                    .font(.system(size: 60))
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                    .foregroundColor(Color(hex: 0xECECEC))
                                    .padding()
                            }else{
                                Image(uiImage: UIImage(url: URL(string: "\(HOST)/media/\(USER_INFO["icon"] as! String)"))!)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                    .padding()
                            }
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(hex: 0x5f5f5f))
                                .padding()
                        }
                        
                    }.frame(width: screen_width)
                        .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                })
                
                Rectangle().fill(Color(hex: 0xffffff, alpha: 0)).frame(width: screen_width, height: 1, alignment: .trailing)
                
                NavigationLink(destination: {}, label: {
                    
                    HStack{
                        Text("名字")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                            .padding()
                        
                        Spacer()
                        
                        HStack{
                            
                            Text("\(USER_INFO["username"] as! String)")
                                .foregroundColor(Color(hex: 0x5f5f5f))
                                .lineLimit(1)
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(hex: 0x5f5f5f))
                                .padding()
                        }
                        
                    }.frame(width: screen_width)
                        .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                    
                })
                
                Rectangle().fill(Color(hex: 0xffffff, alpha: 0)).frame(width: screen_width, height: 1, alignment: .trailing)
                
                NavigationLink(destination: {}, label: {
                    
                    HStack{
                        Text("uuid")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                            .padding()
                        
                        Spacer()
                        
                        HStack{
                            
                            Text("\(USER_INFO["id"] as! String)")
                                .foregroundColor(Color(hex: 0x5f5f5f))
                                .lineLimit(1)
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(hex: 0x5f5f5f))
                                .padding()
                        }
                        
                    }.frame(width: screen_width)
                        .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                    
                })
                
                Rectangle().fill(Color(hex: 0xffffff, alpha: 0)).frame(width: screen_width, height: 1, alignment: .trailing)
                
                NavigationLink(destination: {}, label: {
                    
                    HStack{
                        Text("更多")
                            .font(.system(size: 20)).foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(hex: 0x5f5f5f))
                            .padding()
                        
                    }.frame(width: screen_width)
                        .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                    
                })
                
            }
            
        }.frame(maxHeight: .infinity,alignment: .top)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct UserInfoTopbar: View{
    var body: some View{
        ZStack{
            
            Text("个人信息").font(.system(size: 17)).fontWeight(.semibold)
                .padding()
            
            
        }.frame(width: screen_width)
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
    }
}
