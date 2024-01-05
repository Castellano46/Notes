//
//  SplashView.swift
//  Notes
//
//  Created by Pedro on 5/1/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image("hg 1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Spacer()
                        ProgressView(NSLocalizedString("Organizando tu día", comment: ""))
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .foregroundColor(Color(UIColor(red: 0/255.0, green: 155.0/255.0, blue: 148.0/255.0, alpha: 1.0)))
                            .font(.system(size: 20, weight: .bold))
                            .scaleEffect(2.0)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
        }
    }
}

#Preview {
    SplashView()
}
