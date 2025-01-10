//
//  Lesson.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 10/01/25.
//

import Foundation

struct Lesson: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String  // SF Symbols icon
    let explanation: String
    let example: String
    let regex: String
    var isCompleted: Bool = false
    
    
}
