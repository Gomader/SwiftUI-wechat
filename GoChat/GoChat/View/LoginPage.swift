import SwiftUI
import AlertToast

struct LoginView: View {
    @State var account = ""
    @State var password = ""
    @Binding var logined:Bool
    @State var showLoginResult:Bool = false
    @State var json:SignReturnFormat = SignReturnFormat(code: 0, msg: "", accesstoken: "")
    var body: some View {
        VStack{
            Image(uiImage: UIImage(imageLiteralResourceName: "logo"))
            Text("邮箱")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.08)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
            TextField("",text: $account)
                .frame(width: screen_width*0.6-16, height: screen_height*0.058, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .background(Color(hex: 0xECECEC,alpha:0.5))
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
                .background(Color(hex: 0xECECEC,alpha:0.5))
                .cornerRadius(12)
                .foregroundColor(Color(hex: 0xD30E0E))
            Button(action: {
                if(account != "" && password.lengthOfBytes(using: .utf8) >= 8){
                    SignFuctions().Login(Account: account, Password: password.sha256) { (result) in
                        self.json = result
                    }
                    if json.code == 200 {
                        ACCESS_TOKEN = json.accesstoken
                        SaveAccessToken()
                    }
                    showLoginResult.toggle()
                }
            }, label: {
                Image(systemName: "arrowshape.turn.up.right.circle")
                    .font(.system(size: 60))
                    .padding(.top,screen_height*0.07)
                    .foregroundColor(account != "" && password.lengthOfBytes(using: .utf8) >= 8 ? Color(hex: 0xD30E0E) : Color(hex: 0xECECEC))
            })
        }
        .toast(isPresenting: $showLoginResult, duration: 2, tapToDismiss: false, offsetY: 0, alert: {
            if json.code == 200{
                return AlertToast(type: .complete(Color(hex: 0x2EA043)),title: Optional(json.msg))
            }else{
                return AlertToast(type: .error(Color(hex: 0xD30E0E)),title: Optional(json.msg))
            }
        }, onTap: {}, completion: {
            if json.code == 200{
                logined = true
            }
        })
    }
}
