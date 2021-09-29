import SwiftUI

struct Index: View {
    init(){
        UITabBar.appearance().backgroundColor = UIColor(normal: 0xf8f8f8, normalAlpha: 0.9, dark: 0x181818, darkAlpha: 0.9)
    }
    var body: some View {
        NavigationView{
            TabView{
                ChatList()
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
}
