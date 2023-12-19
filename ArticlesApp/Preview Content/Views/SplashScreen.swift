//
//  SplashScreen.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 02/06/1445 AH.
//

import SwiftUI

struct SplashScreen: View {
    @State var animate = false
    @State var isActive = false
    var body: some View {
        ZStack{
            if self.isActive{
                LoginView()
            }else{
                Image("logo" )
                    .resizable()
                    .frame(width: self.animate ? 1000 : 100, height: self.animate ? 1000 : 100)
                    .opacity(self.animate ? 0 : 1)
                    .animation(Animation .linear .delay(2) , value: animate)
                    
                
            }
                }.onAppear{
                    self.animate.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isActive = true
                        }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
