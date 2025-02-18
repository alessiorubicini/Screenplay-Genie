//
//  IntroductionView.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 10/01/25.
//

import SwiftUI

struct IntroductionView: View {
    
    @Binding var selectedLesson: Lesson?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
            
                
                // What is a Screenplay Section
                Text("What is a Screenplay?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                Text("""
                A screenplay is a written work that serves as the blueprint for a film, television show, or other visual media. It is a detailed description of the story, characters, and the visual and auditory elements that will appear on the screen. A screenplay is more than just dialogue; it includes specific instructions on how the scenes are to be staged, what the audience should see and hear, and how the story progresses.

                In a screenplay, every scene is crafted to create a vivid picture of what will be presented to the audience, and every character's dialogue is written to bring their persona to life. A screenplay allows directors, actors, cinematographers, and all involved in the production to understand how the story is envisioned and how it will come together visually.
                """)
                .font(.body)
                .lineSpacing(6)
                
                // How is a Screenplay Formatted Section
                Text("How is a Screenplay Formatted?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                Text("""
                Screenplay formatting is a standardized structure that ensures consistency and clarity for everyone involved in the production process. A screenplay is divided into several key components, each with its own specific format.
                """)
                .font(.body)
                .lineSpacing(6)
                
                // Why is Screenplay Formatting Important Section
                Text("Why is Screenplay Formatting Important?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                Text("""
                1. **Clarity and Consistency**: Proper formatting ensures that everyone involved in the production process is on the same page. A screenplay that follows industry-standard formatting allows directors, actors, producers, and crew members to easily identify the structure and flow of the story.

                2. **Efficient Communication**: Screenplay formatting is designed to convey as much information as possible with as few words as needed. By adhering to a standardized format, writers ensure that their scripts are clear and easy to interpret, saving time in the production process.

                3. **Industry Standards**: Production companies, agencies, and professionals are accustomed to reading scripts that follow these conventions. Scripts that do not adhere to proper formatting can be difficult to read and may be discarded, regardless of the quality of the content.

                4. **Practicality**: Proper formatting makes it easier for actors to interpret their lines, for directors to plan the staging of scenes, and for producers to determine the pacing and length of a film.

                5. **Time and Budget Management**: By following the established format, the script becomes a functional tool for estimating time, resources, and costs involved in shooting the scenes.
                """)
                .font(.body)
                .lineSpacing(6)
                
                /*Button {
                    selectedLesson = Lesson.allLessons.first
                } label: {
                    Text("Go to Lesson 1").fontWeight(.semibold)
                }.buttonStyle(.bordered).controlSize(.large)*/

                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Introduction")
    }
}
