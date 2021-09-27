import SwiftUI
import AlertToast

struct SignupPage: View {
    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var usericon = Data.init(capacity: 0)
    @State var shown = false
    @State var showSignupResult:Bool = false
    @State var json:NSDictionary = NSDictionary()
    @Binding var signPage:Bool
    var body: some View {
        VStack{
            Button(action: {
                self.shown.toggle();
            }){
                if(usericon.count==0){
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: screen_width*0.15))
                        .frame(width:screen_width*0.2,height:screen_width*0.2)
                }else{
                    Image(uiImage: UIImage(data: usericon)!)
                        .resizable()
                        .frame(width:screen_width*0.2,height:screen_width*0.2)
                        .cornerRadius(20)
                }
            }.sheet(isPresented: $shown) {picker(shown: self.$shown, usericon: self.$usericon,isCamera: false)}
            Text("用户名")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.03)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
            TextField("",text: $username)
                .frame(width: screen_width*0.6-16, height: screen_height*0.058, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .background(Color(hex: 0xECECEC,alpha:0.5))
                .cornerRadius(12)
                .foregroundColor(Color(hex: 0xD30E0E))
            Text("邮箱")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.03)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
            TextField("",text: $email)
                .frame(width: screen_width*0.6-16, height: screen_height*0.058, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .background(Color(hex: 0xECECEC,alpha:0.5))
                .cornerRadius(12)
                .foregroundColor(Color(hex: 0xD30E0E))
            Text("密码")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.03)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
            SecureField("",text: $password)
                .frame(width: screen_width*0.6-16, height: screen_height*0.058, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .background(Color(hex: 0xECECEC,alpha:0.5))
                .cornerRadius(12)
                .foregroundColor(Color(hex: 0xD30E0E))
            Text(confirmPassword==password ? "确认密码" : "密码不一致")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,screen_height*0.03)
                .padding(.leading,screen_width*0.2)
                .font(.system(size: 12))
                .foregroundColor(confirmPassword==password ? Color(hex: 0x2EA043) : Color(hex: 0xD30E0E))
            SecureField("",text: $confirmPassword)
                .frame(width: screen_width*0.6-16, height: screen_height*0.058, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .background(Color(hex: 0xECECEC,alpha:0.5))
                .cornerRadius(12)
                .foregroundColor(Color(hex: 0xD30E0E))
            Button(action: {
                if username != "" && email != "" && password==confirmPassword && password.lengthOfBytes(using: .utf8) >= 8{
                    json = SignUp(Username: username, Email: email, Password: password.sha256, Icon: usericon)
                    showSignupResult.toggle()
                }
            }, label: {
                Image(systemName: "arrowshape.turn.up.right.circle")
                    .font(.system(size: 60))
                    .padding(.top,screen_height*0.07)
                    .foregroundColor(username != "" && email != "" && password==confirmPassword && password.lengthOfBytes(using: .utf8) >= 8 ? Color(hex: 0xD30E0E) : Color(hex: 0xECECEC))
            })
        }.toast(isPresenting: $showSignupResult, duration: 2, tapToDismiss: false, offsetY: 0, alert: {
            if json.count==0 {
                return AlertToast(type: .loading,title: Optional("注册中"))
            }else{
                if json["code"] as! Int == 200{
                    return AlertToast(type: .complete(Color(hex: 0x2EA043)),title: Optional(json["msg"] as! String))
                }else{
                    return AlertToast(type: .error(Color(hex: 0xD30E0E)),title: Optional(json["msg"] as! String))
                }
            }
        }, onTap: {}, completion: {
            if json["code"] as! Int == 200{
                signPage = false
                
            }
        })
    }
}

struct picker : UIViewControllerRepresentable {
    
    @Binding var shown : Bool
    @Binding var usericon : Data
    let isCamera : Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(shown1: $shown, usericon1: $usericon)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<picker>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        if(isCamera){
            controller.sourceType = .camera
        }else{
            controller.sourceType = .photoLibrary
        }
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<picker>) {
        
    }
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        @Binding var shown : Bool
        @Binding var usericon : Data
        
        init(shown1 : Binding<Bool>, usericon1 : Binding<Data>) {
            
            _shown = shown1
            _usericon = usericon1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            shown.toggle()
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let img = info[.originalImage] as! UIImage
            usericon = img.jpegData(compressionQuality: 80)!
            shown.toggle()
        }
    }
}
