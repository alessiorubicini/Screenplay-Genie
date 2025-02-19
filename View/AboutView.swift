//
//  AboutView.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 11/01/25.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(systemName: "film.stack")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
            
            Text("Screenplay Genie")
                .font(.title)
                .fontWeight(.semibold)
            
            // Version
            Text("Version 1.0")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Submitted for Swift Student Challenge 2025 🎓")
                .font(.subheadline)
                .fontWeight(.light)
                .padding(10)
                .padding(.horizontal, 15)
                .background(Color(uiColor: .systemGray6))
                .clipShape(.capsule)
            

            VStack {
                Text("Created by Alessio Rubicini")
                    .font(.headline)
                    
                
                Text("iOS Developer & Cinephile")
                    .font(.subheadline)
                    
                    .padding(.top, 1)
                
                Text("To learn more about me, visit my [website](https://alessiorubicini.github.io) or my [GitHub profile](https://github.com/alessiorubicini). If you have any questions or suggestions, feel free to [email me](mailto:alessiorubicini16@icloud.com).")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(5)
                    .padding(.horizontal)
                
                
                
            }.padding(.top, 30)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Dismiss")
                    .padding(5)
            }.buttonStyle(.bordered)
            .padding(.top, 70)

        }
        .padding()
        
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            AboutView()
        }
}
