//
//  SearchFriend.swift
//  GoChat
//
//  Created by 宫赫 on 2021/10/5.
//

import SwiftUI
import Kingfisher

struct SearchFriend: View {
    
    @State var searching = false
    @State var searchText = ""
    @State var json:NSArray = NSArray()
    
    var body: some View {
        
        let binding = Binding<String>(
            
            get: {
                self.searchText
            }, set: {
                self.searchText = $0
                json = SearchUserByEmailOrUUID(key: self.searchText)["data"] as! NSArray
            })
        
        return VStack{
            
            if !searching{
                SearchFriendTopbar()
            }
            
            if searching{
                VStack{}
                    .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            }
            
            HStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 21))
                        .foregroundColor(Color(hex: 0x5f5f5f))
                    
                    TextField("UUID", text: binding)
                        .onTapGesture {
                            searching.toggle()
                        }
                    
                }.padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 0.5, dark: 0x181818, darkAlpha: 0.5)))
                    .cornerRadius(8)
                
                if searching{
                    Button(action: {
                        searching.toggle()
                        searchText = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("取消")
                            .foregroundColor(Color(hex: 0x0000FF, alpha: 0.6))
                            .padding(.horizontal)
                    })
                }
                
            }
            
            if searching{
                
                SearchResultScrollList(json: $json)
                
            }else{
                
                Text("我的uuid：\(USER_INFO["id"] as! String)")
                    .font(.system(size: 15))
                    .padding()
                
            }
            
            
        }.frame(maxWidth: screen_width, maxHeight: .infinity, alignment: .top)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct SearchFriendTopbar: View{
    
    var body: some View{
        ZStack{
            
            backButton()
            
            Text("添加朋友")
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .padding()
            
            
        }.frame(width: screen_width)
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
    }
}

struct SearchResultScrollList: View{
    
    @Binding var json:NSArray
    
    var body: some View{
        
        ScrollView(.vertical,showsIndicators: false){
            
            if json.count == 0{
                
                Text("无结果")
                
            }else{
                
                VStack(spacing:0){
                    
                    ForEach(0..<json.count, id: \.self){i in
                        
                        let item = json[i] as! NSDictionary
                        let data = item["fields"] as! NSDictionary
                        
                        NavigationLink {
                            VIsitingCard(user: item)
                        } label: {
                            HStack{
                                
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
                                    
                                    Text("uuid:\(item["pk"] as! String)")
                                        .foregroundColor(Color.init(UIColor(normal: 0x000000, normalAlpha: 1, dark: 0xFFFFFF, darkAlpha: 1)))
                                        .font(.system(size: 15))
                                        .lineLimit(1)
                                    
                                }.padding()
                                
                                Spacer()
                                
                            }.padding()
                            .background(Color.init(UIColor(normal: 0xFFFFFF, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
                        }

                        
                        Rectangle().fill(Color(hex: 0xffffff, alpha: 0)).frame(width: screen_width, height: 1, alignment: .trailing)
                        
                    }
                    
                }
                    
            }
                
        }
        
    }
    
}
