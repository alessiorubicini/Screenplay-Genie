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
    @State private var isShowingAbout = false  // Stato per mostrare la AboutView
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List {
                // Introduction Section
                Section {
                    NavigationLink(value: "introduction") {
                        Label("Introduction", systemImage: "info.circle")
                    }
                }
                
                // Lessons Section
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
                
                // Playground Section
                Section(header: Text("Experiment")) {
                    NavigationLink(value: "playground") {
                        Label("Playground", systemImage: "pencil")
                    }
                    NavigationLink(value: "fountain") {
                        Label("Syntax Manual", systemImage: "book.pages")
                    }
                }
                //.disabled(!allLessonsCompleted)
                
                // About Section (apre lo sheet)
                Section(header: Text("About")) {
                    Button {
                        isShowingAbout = true  // Mostra lo sheet
                    } label: {
                        Label("About this app", systemImage: "info.circle")
                    }
                }
            }
            .navigationTitle("Screenplay Genie")
            .navigationDestination(for: Lesson.self) { lesson in
                LessonDetailView(lesson: binding(for: lesson), screenplay: $screenplay)
            }
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "introduction":
                    IntroductionView(selectedLesson: $selectedLesson)
                case "playground":
                    Playground(screenplay: $screenplay)
                case "manual":
                    SafariView(url: URL(string: "https://fountain.io/syntax")!)
                    
                default:
                    EmptyView()
                }
            }
        } content: {
            
            if allLessonsCompleted {
                ContentUnavailableView("Select a lesson or the playground", systemImage: "pencil")
            } else {
                ContentUnavailableView("Select a lesson.", systemImage: "graduationcap.fill", description: Text("The playground will be available once you complete all the lessons."))
            }
            
        } detail: {
            
            ScreenplayPreviewView(screenplay: screenplay)
            
        }
        .sheet(isPresented: $isShowingAbout) {
            AboutView()
        }
        .sheet(isPresented: $firstLaunch) {
            OnboardingView()
        }
    }
    
    var allLessonsCompleted: Bool {
        lessons.allSatisfy { $0.isCompleted }
    }
    
    private func canAccessLesson(_ lesson: Lesson) -> Bool {
        guard let index = lessons.firstIndex(where: { $0.id == lesson.id }) else { return false }
        return index == 0 || lessons[index - 1].isCompleted
    }
    
    private func binding(for lesson: Lesson) -> Binding<Lesson> {
        guard let index = lessons.firstIndex(where: { $0.id == lesson.id }) else {
            fatalError("Lesson not found")
        }
        return $lessons[index]
    }
}
