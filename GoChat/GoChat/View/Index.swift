import SwiftUI

struct Index: View {
    var body: some View {
        TabView{
            ChatListNavigationView(view: ChatList())
                .tabItem({
                    Image(systemName: "message")
                    Text("GoChat")
                })
            
            Book()
                .tabItem({
                    Image(systemName: "person.crop.circle")
                    Text("通讯录")
                })
            
            Find()
                .tabItem({
                    Image(systemName: "safari")
                    Text("发现")
                })
            My()
                .tabItem({
                    Image(systemName: "person")
                    Text("我")
                })
        }
    }
}
