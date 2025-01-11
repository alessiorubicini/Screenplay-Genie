//
//  OnboardingView.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 11/01/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "text.document.fill")
                .font(.system(size: 80))
            
            Text("Welcome to Screenplay Genie!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("This app will help you to write your first screenplay in a simple and intuitive way. Learn about the basics and start writing your story!")
                .multilineTextAlignment(.center)
            
            // Three rows with an icon on the left and a title and description on the right
            // First row about lessons, second about live preview, third about playgroun
            Group {
                Row(icon: "book", title: "Lessons", description: "Learn how to write a screenplay with our interactive lessons.")
                Row(icon: "eye", title: "Live Preview", description: "See your screenplay in real-time formatted and ready-to-read as you write it.")
                Row(icon: "pencil", title: "Playground", description: "Write your screenplay in a dedicated environment and express yourself freely.")
            }.frame(width: .infinity)
                
            
            Button("Start Writing for the Screen!") {
                firstLaunch = false
                presentationMode.wrappedValue.dismiss()
            }.buttonStyle(.borderedProminent)
.padding(.top, 40)
            
        }.padding()
    }
}

struct Row: View {
    
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .padding()
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(description)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    ContentView()
        .sheet(isPresented: .constant(true)) {
            OnboardingView()
        }
}
