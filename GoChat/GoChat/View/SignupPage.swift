import SwiftUI

struct SignupPage: View {
    let screen_width = UIScreen.main.bounds.size.width;
    let screen_height = UIScreen.main.bounds.size.height;
    @State var username = "";
    @State var email = "";
    @State var password = "";
    @State var confirmPassword = "";
    var body: some View {
        VStack{
            Text("用户名")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.08)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
            TextField("",text: $username)
                .frame(width: screen_width*0.6-16, height: screen_height*0.058, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .background(Color(hex: 0xECECEC))
                .cornerRadius(12)
                .foregroundColor(Color(hex: 0xD30E0E))
            Text("邮箱")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.035)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
            TextField("",text: $email)
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
            Text(confirmPassword==password ? "确认密码" : "密码不一致")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.035)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
                .foregroundColor(confirmPassword==password ? Color(hex: 0x000000) : Color(hex: 0xD30E0E))
            SecureField("",text: $confirmPassword)
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
                    .foregroundColor(username != "" && password != "" ? Color(hex: 0xD30E0E) : Color(hex: 0xECECEC))
            })
        }
    }
}

struct SignupPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupPage()
    }
}
