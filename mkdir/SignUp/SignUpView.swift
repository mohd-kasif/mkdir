//
//  SignUpView.swift
//  Auth
//
//  Created by Apple on 08/11/23.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var vm=SignUpViewModel()
    @State var email:String=""
    @State var passWord:String=""
    var body: some View {
        VStack{
            Text("Sign Up")
                .font(.system(size: 32))
            KTextField(title:"Enter Email",text: $email)
            KTextField(title:"Enter Password",text: $passWord,isMaskingAllow: true)
            AuthButton(title: "SignUp"){
                vm.signUp(email: email, password: passWord)
            }
        }
        .padding([.leading,.trailing],20)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
