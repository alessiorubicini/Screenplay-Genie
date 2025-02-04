//
//  ContentView.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 10/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    
    @State private var selectedLesson: Lesson? = nil
    @State private var lessons: [Lesson] = Lesson.allLessons
    @State private var screenplay: String = ""
    
    @State private var visibility: NavigationSplitViewVisibility = .all
    
    var body: some View {

        NavigationSplitView(columnVisibility: $visibility) {
            // Sidebar: List of Lessons
            List {
                Section {
                    NavigationLink {
                        IntroductionView()
                    } label: {
                        Label("Introduction", systemImage: "info.circle")
                    }
                }
                
                Section(header: Text("Lessons")) {
                    ForEach(0..<lessons.count, id: \.self) { index in
                        let lesson = lessons[index]
                        NavigationLink {
                            LessonDetailView(lesson: $lessons[index], screenplay: $screenplay)
                        } label: {
                            HStack {
                                Label(lesson.title, systemImage: lesson.icon)
                                Spacer()
                                if lesson.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                        .disabled(index > 0 && !lessons[index - 1].isCompleted)
                    }
                }
                
                Section(header: Text("Playground")) {
                    NavigationLink {
                        Playground(screenplay: $screenplay)
                    } label: {
                        Label("Free Playground", systemImage: "pencil")
                    }
                }.disabled(!allLessonsCompleted)
                
                Section(header: Text("About")) {
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Label("About this app", systemImage: "info.circle")
                    }
                }
            }
            .navigationTitle("Screenplay Genie")
        } content: {
            if allLessonsCompleted {
                ContentUnavailableView("Select a lesson or the playground", systemImage: "pencil")
            } else {
                ContentUnavailableView("Select a lesson.", systemImage: "graduationcap.fill", description: Text("The playground will be available once you complete all the lessons."))
                
            }
        } detail: {
            ScreenplayPreviewView(screenplay: screenplay)
        }
        
        /*.sheet(isPresented: $firstLaunch) {
            OnboardingView()
        }*/
    }
    
    var allLessonsCompleted: Bool {
        lessons.allSatisfy { $0.isCompleted }
    }
}
