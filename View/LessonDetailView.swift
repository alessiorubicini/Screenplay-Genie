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
                TextEditor(text: $lesson.userInput)
                    .frame(height: 100)
                    .border(editorBorderColor)
                    .padding(.bottom)
                    .onChange(of: lesson.userInput) {
                        
                        print("User input: " + lesson.userInput)
                        print("Formatted: " + lesson.userInput.replacingOccurrences(of: "\n", with: "\\n"))
                        
                        let newIsValid = NSPredicate(format: "SELF MATCHES %@", lesson.regex).evaluate(with: lesson.userInput)
                        
                        if newIsValid {
                            if !lesson.isCompleted {
                                lesson.isCompleted = true
                            }
                            
                            // Trova e sostituisci solo il vecchio valore all'interno di screenplay
                            if let range = screenplay.range(of: lesson.previousInput) {
                                screenplay.replaceSubrange(range, with: lesson.userInput)
                            } else {
                                // Se il valore non esiste ancora nello screenplay, lo aggiunge
                                screenplay += "\n\n" + lesson.userInput
                            }
                            
                            // Aggiorna il valore precedentemente scritto
                            lesson.previousInput = lesson.userInput
                        }
                        
                        isValid = newIsValid
                    }
                
                // Feedback
                if isValid {
                    Text("Correct!")
                        .font(.headline)
                        .foregroundColor(.green)
                } else if lesson.userInput.isEmpty {
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
        } else if lesson.userInput.isEmpty {
            return .gray
        } else {
            return .red
        }
    
    }
}

#Preview {
    LessonDetailView(lesson: .constant(Lesson.allLessons[0]), screenplay: .constant(""))
}
