//
//  SplashScreenView.swift
//  Easy Tip
//
//  Created by Hannah Jacob on 6/30/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        
        if isActive {
            ContentView()
        }else {
            VStack {
                ZStack {
                    Color("purple_accent")
                        .ignoresSafeArea()
                    
                    Image("easy_tip_purple")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    
                }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.isActive = true
                    }
                    
                }
            }
        }
        
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
