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
    @State private var selectedTabIndex: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            
            OnboardingPage(
                icon: "text.document.fill",
                title: "Welcome to Screenplay Genie!",
                description: "Ever dreamed of writing a screenplay? Screenplay Genie guides you step by step through the fundamentals of screenwriting, helping you turn your creativity into a professionally formatted script. \n\nLearn the essential rules, practice with real-time previews, and unlock a free writing playground to bring your stories to life!",
                isLastPage: false,
                presentationMode: presentationMode,
                firstLaunch: $firstLaunch
            ).tag(0)
            
            OnboardingPage(
                icon: "book.fill",
                title: "Interactive Lessons",
                description: "Screenwriting follows specific rules, but don’t worry: Screenplay Genie makes them easy and fun to learn! Each mini-lesson focuses on a key screenplay element.\n\nAfter a quick explanation, you’ll put your knowledge into practice by writing in Fountain Markdown. Format your text correctly to complete the lesson and unlock the next one! 👨‍🏫",
                isLastPage: false,
                presentationMode: presentationMode,
                firstLaunch: $firstLaunch
            ).tag(1)
            
            OnboardingPage(
                icon: "eye.fill",
                title: "Live Preview",
                description: "Formatting is key in screenwriting, and the Live Preview helps you get it right! As you type, you’ll see your screenplay instantly transform into a properly formatted script with professional styling—just like in Hollywood.\n\nThis way, you not only learn the rules but also see how your script will look on paper. 👀",
                isLastPage: false,
                presentationMode: presentationMode,
                firstLaunch: $firstLaunch
            ).tag(2)
            
            OnboardingPage(
                icon: "paintbrush.pointed.fill",
                title: "Free Playground",
                description: "Finished all the lessons? Congratulations! 🎉\n\nNow it’s time to apply everything you’ve learned. The Playground lets you write without restrictions: create your own scenes, develop engaging dialogue, and bring your story to life.",
                isLastPage: true,
                presentationMode: presentationMode,
                firstLaunch: $firstLaunch
            ).tag(3)
            
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .interactiveDismissDisabled()
    }
}

struct OnboardingPage: View {
    
    let icon: String
    let title: String
    let description: String
    let isLastPage: Bool
    @Binding var presentationMode: PresentationMode
    @Binding var firstLaunch: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                .orange,
                colorScheme == .dark ? Color(uiColor: .systemBackground) : .white
            ]), startPoint: .top, endPoint: .center)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Image(systemName: icon)
                    .symbolEffect(.bounce, options: .speed(3).repeat(3), value: true)
                    .font(.system(size: 80))
                    .foregroundStyle(.tint)

                Text(title)
                    .font(.title)
                    .fontWeight(.bold)

                    .padding()

                Text(description)
                    .multilineTextAlignment(.center)


                if isLastPage {
                    Button(action: {
                        firstLaunch = false
                        presentationMode.dismiss()
                    }, label: {
                        Text("Get Started")
                            .fontWeight(.medium)
                    })
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .buttonBorderShape(.capsule)
                    .padding(.top, 20)
                }

            }
            .padding(20)
        }
    }
}

#Preview {
    ContentView()
        .sheet(isPresented: .constant(true)) {
            OnboardingView()
        }
}
