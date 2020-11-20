import SwiftUI
import Firebase

let greenColor = Color(red: 133/255, green: 183/255, blue: 145/256, opacity: 1.0)
let greenColor2 = Color(red: 133/255, green: 183/255, blue: 145/256, opacity: 0.4)
let greyColor = Color (red: 165/255, green: 165/255, blue: 165/255, opacity: 1.0)
let textFieldColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct actIndSignup: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var errorText: String = ""
    @State private var showAlert = false
    @State private var shouldAnimate = false
    
    var alert: Alert {
        Alert(title: Text("Verify your Email ID"), message: Text("Please click the link in the verification email sent to you"), dismissButton: .default(Text("Dismiss")){
            
            self.presentationMode.wrappedValue.dismiss()
            self.emailAddress = ""
            self.password = ""
            self.errorText = ""
            
            })
    }
    
    var body: some View {
        
        VStack() {
            WelcomeText()
            UserImage()
            TextField("Email", text: $emailAddress).textContentType(.emailAddress)
                .padding()
                .background(textFieldColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            SecureField("Password", text: $password)
                .padding()
                .background(textFieldColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            Button(action: {
                self.shouldAnimate = true
                self.sayHelloWorld(email:self.emailAddress, password:self.password)
            })
                {
                    Text("Sign up")
                        .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                        .foregroundColor(.white)
                        .background(greenColor)
                        .cornerRadius(15.0)
                        .font(.headline)
                }

            Text(errorText).frame(minWidth: 0, maxWidth: .infinity, alignment: .center).foregroundColor(Color.red).padding()
            actIndSignup(shouldAnimate: self.$shouldAnimate)
        }.padding()
            
            .alert(isPresented: $showAlert, content: { self.alert })
    }
    
    func sayHelloWorld(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                let errorText: String  = error?.localizedDescription ?? "unknown error"
                self.errorText = errorText
                return
            }
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                if let error = error {
                    self.errorText = error.localizedDescription
                    return
                }
                self.showAlert.toggle()
                self.shouldAnimate = false
            }
            print("\(user.email!) created")
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct WelcomeText : View {
    var body: some View {
        return Text("Dr. Horticulture")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(greenColor)
    }
}

struct UserImage : View {
    var body: some View {
        return Image("Logo-1")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}
