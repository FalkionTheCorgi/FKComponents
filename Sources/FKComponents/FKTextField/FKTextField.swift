//
//  SwiftUIView.swift
//  
//
//  Created by Manollo Martinez on 16/07/22.
//

import SwiftUI

struct SwiftUIView: View {
    
    var imageLeft : String = "trash.fill"
    var colorIcLeft : Color = .black
    var imageRight : String = "rectangle.portrait.and.arrow.right.fill"
    var colorIcRight : Color = .black
    var width : CGFloat = UIScreen.main.bounds.width
    var height : CGFloat = 40.0
    var placeholder : String = "Placeholder"
    var backgroundColor : Color = .white
    var callback: () -> Void?
    
    var regexValidationField : String = ""
    
    @Binding var text : String
    @Binding var icRightPg : Bool
    @State var color : Color = .black
    
    init(
        text : Binding<String>,
        icRightPg : Binding<Bool> = .constant(false),
        callback : @escaping () -> Void
    ){
        self._text = text
        self._icRightPg = icRightPg
        self.callback = callback
    }
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(backgroundColor)
                .frame(width: width*0.915, height: 40)
                .border(color)
            HStack(spacing: 8){
                
                Image(
                    uiImage: ((UIImage(systemName: imageLeft) ?? UIImage(named: imageLeft)) ?? UIImage(named : ""))!
                )
                .foregroundColor(colorIcLeft)
                
                TextField(placeholder, text: $text)
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
                    
                    
                if(!icRightPg){
                    Image(
                        uiImage: ((UIImage(systemName: imageRight) ?? UIImage(named: imageRight)) ?? UIImage(named : ""))!
                    )
                        .foregroundColor(colorIcRight)
                        .onTapGesture {
                            callback()
                        }
                }else{
                    ProgressView()
                }
            }
            .padding(8)
            .frame(width: width * 0.90, height: height)
        }
    }

}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {

        
        SwiftUIView(text: .constant(""), callback: {
            
        })
    }
}
