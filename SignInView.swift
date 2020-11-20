import SwiftUI
import Firebase

struct actIndSignin: UIViewRepresentable {
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


struct SignInView: View {
    
    
    @State private var shouldAnimate = false
    
    @Environment(\.presentationMode) var presentationMode
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var verifyEmail: Bool = true
    @State private var showEmailAlert = false
    @State private var showPasswordAlert = false
    @State var errorText: String = ""
    
    var onDismiss: () -> ()
    
    var verifyEmailAlert: Alert {
        Alert(title: Text("Verify your Email ID"), message: Text("Please click the link in the verification email sent to you"), dismissButton: .default(Text("Dismiss")){
            
            self.presentationMode.wrappedValue.dismiss()
            self.emailAddress = ""
            self.verifyEmail = true
            self.password = ""
            self.errorText = ""
            
            })
    }
    
    var passwordResetAlert: Alert {
        Alert(title: Text("Reset your password"), message: Text("Please click the link in the password reset email sent to you"), dismissButton: .default(Text("Dismiss")){
            
            self.emailAddress = ""
            self.verifyEmail = true
            self.password = ""
            self.errorText = ""
            
            })
    }
    
    
    var body: some View {
        VStack() {
            WelcomeTextt()
            UserImagee()
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
            }
            ) {
                LoginButtonContent()
            }
            Button(action: {
                Auth.auth().sendPasswordReset(withEmail: self.emailAddress) { error in
                    if let error = error {
                        self.errorText = error.localizedDescription
                        return
                    }
                    self.showPasswordAlert.toggle()
                }
            }
            ) {
                PasswordButtonContent().padding()
            }
            Text(errorText).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            actIndSignin(shouldAnimate: self.$shouldAnimate)
            if (!verifyEmail) {
                Button(action: {
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        if let error = error {
                            self.errorText = error.localizedDescription
                            return
                        }
                        self.showEmailAlert.toggle()
                    }
                }) {
                    Text("Send Verify Email Again")
                }
            }
        }.padding()
            
            .alert(isPresented: $showEmailAlert, content: { self.verifyEmailAlert })
            
            .alert(isPresented: $showPasswordAlert, content: { self.passwordResetAlert })
    }
    func sayHelloWorld(email: String, password: String) {
        
        
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            
            
            
            
            if let error = error
            {
                self.errorText = error.localizedDescription
                self.shouldAnimate = false
                
                return
            }
            
            
            guard user != nil else { return }
            self.verifyEmail = user?.user.isEmailVerified ?? false
            if(!self.verifyEmail)
            {
                self.errorText = "Please verify your email"
                self.shouldAnimate = false
                return
            }
            
            self.emailAddress = ""
            self.verifyEmail = true
            self.password = ""
            self.errorText = ""
            self.onDismiss()
            self.presentationMode.wrappedValue.dismiss()
            self.shouldAnimate = false
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(onDismiss: {print("hi")})
    }
}

struct WelcomeTextt : View {
    var body: some View {
        return Text("Dr. Horticulture")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(greenColor)
    }
}

struct UserImagee : View {
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

struct LoginButtonContent : View {
    var body: some View {
        return Text("Login")
            .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
            .foregroundColor(.white)
            .background(greenColor)
            .cornerRadius(15.0)
            .font(.headline)
    }
}

struct PasswordButtonContent : View {
    var body: some View {
        return Text("Forgot password?")
            .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
            .foregroundColor(.white)
            .background(greenColor)
            .cornerRadius(15.0)
            .font(.headline)
    }
}

