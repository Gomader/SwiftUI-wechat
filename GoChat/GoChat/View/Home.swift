import SwiftUI

struct HomeView: View {
    @State var signPage = false;
    @State var logined = ACCESS_TOKEN=="" ? false : true;
    var body: some View {
        if(logined){
            SignupPage()
        }else{
            VStack{
                if(signPage){
                    SignupPage()
                }else{
                    LoginView(logined: $logined)
                }
            }.frame(maxHeight: .infinity)
                .overlay(
                HStack{
                    Text(signPage ? "已经有账号？" : "还没有账号？")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Button(action: {
                        withAnimation{
                            if(signPage){signPage=false}else{signPage=true}
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
