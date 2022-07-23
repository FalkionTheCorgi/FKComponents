//
//  SwiftUIView.swift
//  
//
//  Created by Manollo Martinez on 23/07/22.
//

import SwiftUI

struct FKButton: View {
    
    let width = UIScreen.main.bounds.width
    
    @State var onClick : Bool = false
    @State var circleProgress = 0.0
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: onClick ? 50 : 0)
                .fill( onClick ? .white : Color.blue)
                .frame(
                    width: onClick ? 40 : width*0.915,
                    height: 40
                )
            
           
            
            if !onClick{
                Text("Button")
                    .foregroundColor(.white)
            }
            
        }
        .onTapGesture {
            withAnimation(.easeOut(duration: 0.5)){
                onClick = !onClick
                startLoading()
            }
        }
        .overlay{
            if onClick{
                Circle()
                    .trim(from: 0.0, to: 0.6)
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: 40, height: 40)
                    .rotationEffect(Angle(degrees: circleProgress))
            }
        }
    }
    
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            withAnimation {
                self.circleProgress += 10.0
            }
            if self.circleProgress == 360.0 {
                self.circleProgress = 0.0
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FKButton()
    }
}
