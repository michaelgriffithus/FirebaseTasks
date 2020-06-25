//
//  SignInWithAppleButton.swift
//  FirebaseTasks
//
//  Created by Michael Griffith on 6/25/20.
//  Copyright © 2020 Michael Griffith. All rights reserved.
//

import Foundation
import SwiftUI
import AuthenticationServices


struct SigninWithAppleButton: UIViewRepresentable {
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
    
    // UIViewRepresentable Wraps to wrap ui kit components and make available to swiftui
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }

}
