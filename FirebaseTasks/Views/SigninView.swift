//
//  SigninView.swift
//  FirebaseTasks
//
//  Created by Michael Griffith on 6/25/20.
//  Copyright © 2020 Michael Griffith. All rights reserved.
//

import SwiftUI

struct SigninView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var coordinator : SigninWithAppleCoordinator?
    var body: some View {
        VStack {
            Text("Please Sign in")
            SigninWithAppleButton().frame(width: 280, height: 45).onTapGesture {
                self.coordinator = SigninWithAppleCoordinator()
                if let coordinator = self.coordinator{
                    coordinator.startSignInWithAppleFlow {
                        // call back fires here
                        print("Sign in sucessful!");
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
