//
//  AuthButton.swift
//  mkdir
//
//  Created by Apple on 08/11/23.
//


import SwiftUI

enum AuthButtonType {
    case filled, bordered, text
}

struct AuthButton: View {
    
    private static let buttonHorizontalMargins: CGFloat = 0
    
    var buttonType: AuthButtonType
    var onTap: (() -> Void)?

    private let title: String
    private let disabled: Bool
    private let imageName: String
    
    init(title: String,
         disabled: Bool = false,
         type: AuthButtonType = .filled,
         imageName: String = "",
         onTap: (() -> Void)? = nil) {
        self.title = title
        self.onTap = onTap
        self.disabled = disabled
        self.buttonType = type
        self.imageName = imageName
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: AuthButton.buttonHorizontalMargins)
            
            Button(action: { onTap?() }) {
                Label(self.title, systemImage: imageName)
                    .frame(maxWidth:.infinity)
              }
            .buttonStyle(AuthButtonStyle(buttonType: buttonType, isDisabled: disabled))
            .disabled(self.disabled)
            Spacer(minLength: AuthButton.buttonHorizontalMargins)
        }
        .frame(maxWidth: .infinity)
    }
}

struct AuthButtonStyle: ButtonStyle {
    
    let buttonType: AuthButtonType
    let isDisabled: Bool

    private let primaryColor = Color(.sRGB, red: 0.298, green: 0.102, blue: 0.518, opacity: 1)
    private let disabledBgColor = Color(.sRGB, red: 0.847, green: 0.863, blue: 0.902, opacity: 1)
    private let disabledFgColor = Color(.sRGB, red: 0.51, green: 0.533, blue: 0.58, opacity: 1)
    private let fgColor = Color(.sRGB, red: 0.925, green: 0.894, blue: 1, opacity: 1)
    private let opacity: CGFloat = 0.8
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            .foregroundColor(getForegroundColor(configuration: configuration))
            .background(getBackgoundColor(configuration: configuration))
            .cornerRadius(4)
            .border(getBorderColor(configuration: configuration), width: 2, cornerRadius: 4)
            .font(.system(size:16,weight:.bold))
            .font(.custom("Poppins", size: 16))
      
    }
}

extension AuthButtonStyle {
    private func getForegroundColor(configuration: Configuration) -> Color {
        
        var color: Color
        
        if buttonType == .filled {
            color = isDisabled ? disabledFgColor : fgColor
        } else {
            color = isDisabled ? disabledFgColor : primaryColor
        }
        
        if configuration.isPressed {
            return color.opacity(opacity)
        } else {
            return color
        }
    }
    
    private func getBackgoundColor(configuration: Configuration) -> Color {
        if buttonType == .filled {
            let color = isDisabled ? disabledBgColor : primaryColor
            if configuration.isPressed {
                return color.opacity(opacity)
            } else {
                return color
            }
        } else if buttonType == .bordered {
            return Color.white
        } else {
            return Color.clear
        }
    }
    
    private func getBorderColor(configuration: Configuration) -> Color {
        if buttonType == .bordered {
            let color = isDisabled ? disabledBgColor : primaryColor
            if configuration.isPressed {
                return color.opacity(opacity)
            } else {
                return color
            }
        } else {
            return Color.clear
        }
    }
}
extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
            .cornerRadius(cornerRadius)
    }
}

struct NyButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthButton(title: "Save" ,disabled:false)
            .padding(.all, 20)
    }
}
