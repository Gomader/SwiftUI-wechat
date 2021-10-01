import SwiftUI

struct Index: View {
    
    @Binding var logined:Bool
    
    init(logined: Binding<Bool>){
        self._logined = logined
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
                My(logined:$logined)
                    .tabItem({
                        Image(systemName: "person")
                        Text("我")
                    })
            }.accentColor(Color(hex: 0xD30E0E))
        }.accentColor(Color(hex: 0x5f5f5f))
    }
}

struct IndexNavigationView: UIViewControllerRepresentable{
    
    var view: Index
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let childView = UIHostingController(rootView: view)
        let controller = UINavigationController(rootViewController: childView)
        
        controller.navigationBar.isHidden = true
        controller.navigationBar.isTranslucent = true
        controller.navigationBar.prefersLargeTitles = false
        
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
