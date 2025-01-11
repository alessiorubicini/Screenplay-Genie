//
//  LessonDetailView.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 10/01/25.
//

import SwiftUI

struct LessonDetailView: View {
    
    @Binding var lesson: Lesson
    @Binding var screenplay: String
    @State private var userInput: String = ""
    @State private var isValid: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Explanation
                Text(lesson.explanation)
                    .font(.body)
            
                // Example
                Text(lesson.example)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .italic()
                
                // Text Editor for Input
                TextEditor(text: $userInput)
                    .frame(height: 100)
                    .border(editorBorderColor)
                    .padding(.bottom)
                    .onChange(of: userInput) {
                        isValid = NSPredicate(format: "SELF MATCHES %@", lesson.regex).evaluate(with: userInput)
                        if isValid && !lesson.isCompleted {
                            lesson.isCompleted = true
                            screenplay += ("\n\n" + userInput)
                        }
                    }
                
                // Feedback
                if isValid {
                    Text("Correct!")
                        .font(.headline)
                        .foregroundColor(.green)
                } else if userInput.isEmpty {
                    Text("Please write something.")
                        .font(.headline)
                } else {
                    Text("Please follow the correct format.")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(lesson.title)
    }
    
    var editorBorderColor: Color {
        if isValid {
            return .green
        } else if userInput.isEmpty {
            return .gray
        } else {
            return .red
        }
    
    }
}

#Preview {
    LessonDetailView(lesson: .constant(Lesson.allLessons[0]), screenplay: .constant(""))
}
