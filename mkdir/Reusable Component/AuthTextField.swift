
//
//  AuthTextField.swift
//  Auth
//
//  Created by Kashif on  08/11/23.
//

import SwiftUI

struct KTextField: View {
    var title:String=""
    @Binding var text:String
    @State var editing = false
    var isMaskingAllow:Bool?
    var color: Color?
    var isDisbaled: Bool?
    var onTap: (() -> Void)?
    var body: some View {
        ZStack(alignment: .leading){
            Text(title)
                .opacity(0.8)
                .foregroundColor(text.isEmpty ? .red : (color ?? .green))
                .padding(.leading,10)
                .padding(.top,10)
                .offset(y:text.isEmpty ? 0 : -15)
                .scaleEffect(text.isEmpty ? 1 : 0.9,anchor: .leading)
                .font(.system(size: text.isEmpty ? 14 : 10))
            TextField("",text: $text,onEditingChanged: {edit in
                editing=edit
                if editing {
                                   onTap?() // Invoke the onTap closure if provided
                               }
            })
            .font(Font.system(size: 14.0))
                .textFieldStyle(MyTextFieldStyle(focused: $editing))
        }
        .animation(.default)
    }
}

struct TextFieldView:View{
    @State var text:String=""
    var body: some View{
        VStack{
            KTextField(title: "Name", text: $text)
        }
    }
}
struct MyTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .frame(maxWidth:.infinity)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(focused ? .red : .green, lineWidth: 1)
            ).padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
    }
}


//struct KTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldView()
//    }
//}

