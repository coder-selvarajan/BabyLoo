//
//  StartScreen.swift
//  BabyLoo
//
//  Created by Selvarajan on 01/01/22.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    let login = ContentView()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow.ignoresSafeArea()
                VStack {
                    LottieView().frame(width: 300, height: 400)
                    
                    NavigationLink(destination: login,
                                   isActive: $isActive,
                                   label: { EmptyView() })
                    
                    Text("Baby LOO")
                        .font(.system(size: 45))
                    Text("Tracker")
                        .font(.largeTitle)
                    
                }
                .onAppear(perform: {
                    self.gotoHomeScreen(time: 1.5)
                })
            }
        }
    }
    
    func gotoHomeScreen(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
            self.isActive = true
        }
    }
    
    func animateSplash() {
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        //            withAnimation(Animation.easeOut(duration: 0.75)) {
        //                showHome.toggle()
        //            }
        //        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
