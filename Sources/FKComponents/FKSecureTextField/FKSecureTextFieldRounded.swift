//
//  SwiftUIView.swift
//
//
//  Created by Manollo Martinez on 16/07/22.
//

import SwiftUI

struct FKSecureTextFieldRounded: View {
    
    var icLeft : String
    var colorIcLeft : Color
    var width : CGFloat = UIScreen.main.bounds.width
    var height : CGFloat = 40.0
    var placeholder : String
    var backgroundColor : Color = .white
    var regexValidationField : String = ""
    
    @Binding var text : String
    
    @State var color : Color = .black
    @State var isSecured : Bool  = true
    
    init(
        icLeft : String = "",
        colorIcLeft : Color = .clear,
        placeholder : String = "Placeholder",
        text : Binding<String>
    ){
        self.icLeft = icLeft
        self.colorIcLeft = colorIcLeft
        self.placeholder = placeholder
        self._text = text
    }
    
    
    var body: some View {
        HStack(spacing: 8){
            Image(
                uiImage: ((UIImage(systemName: icLeft) ?? UIImage(named: icLeft)) ?? UIImage(named : ""))!
            )
            .foregroundColor(colorIcLeft)
            
            Group{
                if isSecured{
                    SecureField(placeholder, text: $text)
                }else{
                    TextField(placeholder, text: $text)
                }
            }
            .font(Font.caption)
            .onChange(of: text){ text in
                if (text.range(
                    of: regexValidationField,
                    options: .regularExpression
                ) != nil){
                    color = .black
                }else{
                    color = .red
                }
            }
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.black)
            }
                
        }
        .padding(8)
        .frame(width: width * 0.90, height: height)
        .overlay{
            RoundedRectangle(cornerRadius: 14)
                .stroke(color, lineWidth: 1)
        }
    }

}

struct FKSecureTextFieldRounded_Previews: PreviewProvider {
    static var previews: some View {

        
        FKSecureTextFieldRounded(icLeft: "trash.fill", colorIcLeft: .black, text: .constant(""))
        
    }
}
