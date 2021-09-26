import SwiftUI

struct LoginView: View {
    let screen_width = UIScreen.main.bounds.size.width;
    let screen_height = UIScreen.main.bounds.size.height;
    @State var account = "";
    @State var password = "";
    @Binding var logined:Bool;
    var body: some View {
        VStack{
            Text("用户名或邮箱")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.08)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
            TextField("",text: $account)
                .frame(width: screen_width*0.6-16, height: screen_height*0.058, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .background(Color(hex: 0xECECEC))
                .cornerRadius(12)
                .foregroundColor(Color(hex: 0xD30E0E))
            Text("密码")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.035)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
            SecureField("",text: $password)
                .frame(width: screen_width*0.6-16, height: screen_height*0.058, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .background(Color(hex: 0xECECEC))
                .cornerRadius(12)
                .foregroundColor(Color(hex: 0xD30E0E))
            Button(action: {
                
            }, label: {
                Image(systemName: "arrowshape.turn.up.right.circle")
                    .font(.system(size: 60))
                    .padding(.top,screen_height*0.07)
                    .foregroundColor(account != "" && password != "" ? Color(hex: 0xD30E0E) : Color(hex: 0xECECEC))
            })
        }
    }
}
