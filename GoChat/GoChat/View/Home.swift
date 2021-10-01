import SwiftUI

struct HomeView: View {
    @State var signPage = false;
    @State var logined = ACCESS_TOKEN=="" ? false : true;
    var body: some View {
        if(logined){
            IndexNavigationView(view: Index(logined: $logined))
                .edgesIgnoringSafeArea(.all)
        }else{
            VStack{
                if(signPage){
                    SignupPage(logined: $logined)
                        .transition(.move(edge: .trailing))
                }else{
                    LoginView(logined: $logined)
                        .transition(.move(edge: .trailing))
                }
            }.frame(maxHeight: .infinity)
                .overlay(
                HStack{
                    Text(signPage ? "已经有账号？" : "还没有账号？")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Button(action: {
                        withAnimation{
                            signPage.toggle()
                        }
                    }, label: {
                        Text(signPage ? "登录" : "注册账户")
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: 0xD30E0E))
                    })
                }
                ,alignment: .bottom
            )
        }
    }
}
