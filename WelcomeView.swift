import SwiftUI
import Firebase

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

struct WelcomeView: View {
    
    @State var signUpIsPresent: Bool = false
    @State var signInIsPresent: Bool = false
    @State var selection: Int? = nil
    @State var viewState = CGSize.zero
    @State var MainviewState =  CGSize.zero
    
    var body: some View {
        ZStack{
            if Auth.auth().currentUser != nil {
                ContentView()
            }
            else {
                    VStack() {
                        WelcomeTexttt()
                        UserImageee()
                        Button(action: {self.signUpIsPresent = true}){
                            Text("Sign up")
                            .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                            .foregroundColor(.white)
                            .background(greenColor)
                            .cornerRadius(15.0)
                            .font(.headline)
                        }
                        .sheet(isPresented: self.$signUpIsPresent){
                            SignUpView()
                        }
                        .padding()
                        Button(action: {self.signInIsPresent = true}){
                            Text("Sign In")
                            .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                            .foregroundColor(.white)
                            .background(greenColor)
                            .cornerRadius(15.0)
                            .font(.headline)
                            }
                        .sheet(isPresented: $signInIsPresent) {
                            SignInView(onDismiss:{
                                self.viewState = CGSize(width: screenWidth, height: 0)
                                self.MainviewState = CGSize(width: 0, height: 0)
                        })}}
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

struct WelcomeTexttt : View {
    var body: some View {
        return Text("Dr. Horticulture")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(greenColor)
    }
}

struct UserImageee : View {
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

