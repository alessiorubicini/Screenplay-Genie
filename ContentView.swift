//
//  ContentView.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 10/01/25.
//

import SwiftUI

struct ContentView: View {
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
                    ForEach($lessons) { $lesson in
                        NavigationLink {
                            LessonDetailView(lesson: $lesson, screenplay: $screenplay)
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

                    }
                }
                
                Section(header: Text("Playground")) {
                    NavigationLink {
                        EmptyView()
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
                ContentUnavailableView("Select a lesson.\n\nThe playground will be available once you complete all lessons", systemImage: "graduationcap.fill")
            }
        } detail: {
            ScreenplayPreviewView(screenplay: screenplay)
        }
    }
    
    var allLessonsCompleted: Bool {
        lessons.allSatisfy { $0.isCompleted }
    }
}
