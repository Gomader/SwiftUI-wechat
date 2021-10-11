import SwiftUI

struct Index: View {
    
    @Binding var logined:Bool
    @State var ChatListNewMessage:Int = 0
    @ObservedObject var BookNewMessage:FriendRequestList = FriendRequestList.sharedInstance
    @State var FindNewMessage:Int = 0
    @State var MyNewMessage:Int = 0
    
    private var tabsCount: CGFloat = 4
    
    init(logined: Binding<Bool>){
        self._logined = logined
        UITabBar.appearance().backgroundColor = UIColor(normal: 0xf8f8f8, normalAlpha: 0.9, dark: 0x181818, darkAlpha: 0.9)
        WebsocketConnect()
    }
    
    var body: some View {
        
        GeometryReader{ geometry in
            
            ZStack(alignment: .bottomLeading){
                TabView{
                    ChatList(newMessage: $ChatListNewMessage)
                        .tabItem({
                            Image(systemName: "message")
                            Text("GoChat")
                        })
                    
                    Book()
                        .tabItem({

                            Image(systemName: "person.crop.circle")
                                
                            Text("通讯录")
                        })
                    
                    Find(newMessage: $FindNewMessage)
                        .tabItem({
                            Image(systemName: "safari")
                            Text("发现")
                        })
                    My(logined:$logined,newMessage: $MyNewMessage)
                        .tabItem({
                            Image(systemName: "person")
                            Text("我")
                        })
                }.accentColor(Color(hex: 0xD30E0E))
            
                ZStack {
                    Circle()
                        .foregroundColor(.red)

                    Text(self.ChatListNewMessage == -1 ? "" : self.ChatListNewMessage > 99 ? "99+" : "\(self.ChatListNewMessage)")
                        .foregroundColor(.white)
                        .font(Font.system(size: 12))
                    }
                    .frame(width: 20, height: 20)
                    .offset(x: ( ( 2 * 1) - 1 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
                    .opacity(self.ChatListNewMessage == 0 ? 0 : 1)
                
                ZStack {
                    Circle()
                        .foregroundColor(.red)

                    Text(self.BookNewMessage.unRead == -1 ? "" : self.BookNewMessage.unRead > 99 ? "99+" : "\(self.BookNewMessage.unRead)")
                        .foregroundColor(.white)
                        .font(Font.system(size: 12))
                    }
                    .frame(width: 20, height: 20)
                    .offset(x: ( ( 2 * 2) - 1 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
                    .opacity(self.BookNewMessage.unRead == 0 ? 0 : 1)
                
                ZStack {
                    Circle()
                        .foregroundColor(.red)

                    Text(self.FindNewMessage == -1 ? "" : self.FindNewMessage > 99 ? "99+" : "\(self.FindNewMessage)")
                        .foregroundColor(.white)
                        .font(Font.system(size: 12))
                    }
                    .frame(width: 20, height: 20)
                    .offset(x: ( ( 2 * 3) - 1 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
                    .opacity(self.FindNewMessage == 0 ? 0 : 1)
                
                ZStack {
                    Circle()
                        .foregroundColor(.red)

                    Text(self.MyNewMessage == -1 ? "" : self.MyNewMessage > 99 ? "99+" : "\(self.MyNewMessage)")
                        .foregroundColor(.white)
                        .font(Font.system(size: 12))
                    }
                    .frame(width: 20, height: 20)
                    .offset(x: ( ( 2 * 4) - 1 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
                    .opacity(self.MyNewMessage == 0 ? 0 : 1)
                
            }
            
        }
        
        
    }
}

struct IndexNavigationView: UIViewControllerRepresentable{
    
    
    var view: Index
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let childView = UIHostingController(rootView: view)
        let controller = UINavigationController(rootViewController: childView)
        
        controller.navigationBar.isHidden = true
        
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

struct backButton: View{
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View{
        
        HStack{
            
            Button(action: {
                
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20))
                    .foregroundColor((Color(hex: 0x5f5f5f)))
                    .padding()
            })
            
            Spacer()
            
        }
        
    }
}
