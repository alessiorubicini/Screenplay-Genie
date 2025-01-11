//
//  ScreenplayPreviewView.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 10/01/25.
//

import SwiftUI

struct ScreenplayPreviewView: View {
    let screenplay: String
    let fontSize: CGFloat = 18
    let spacing: CGFloat = 16

    private enum ElementType {
        case heading, action, dialogue, parenthetical, transition
    }
    
    private func parseScreenplay() -> [(String, ElementType)] {
        let lines: [String] = screenplay.split(whereSeparator: \.isNewline)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        var parsedLines: [(String, ElementType)] = []
        var isDialogueBlock = false
        
        for line in lines {
            let type = getElementType(for: line)
            
            // If we're in a dialogue block and the line is a parenthetical, treat it as part of the dialogue
            if isDialogueBlock && type == .parenthetical {
                parsedLines.append((line, .parenthetical))
                continue
            }
            
            // If we're in a dialogue block and the line is not a transition or heading, treat it as dialogue
            if isDialogueBlock && type != .transition && type != .heading {
                parsedLines.append((line, .dialogue))
                continue
            }
            
            // Otherwise, treat the line based on its type
            switch type {
            case .dialogue:
                isDialogueBlock = true
                parsedLines.append((line, .dialogue))
            case .parenthetical:
                // If a parenthetical appears outside dialogue, treat it as action
                parsedLines.append((line, .action))
            default:
                isDialogueBlock = false
                parsedLines.append((line, type))
            }
        }
        
        return parsedLines
    }
    
    private func getElementType(for line: String) -> ElementType {
        // Regex for Scene Heading (e.g., "INT. LIVING ROOM - DAY")
        let sceneHeadingRegex = "^(INT|EXT)\\. .+ - (DAY|NIGHT|MORNING|EVENING)$"
        // Regex for Dialogue (e.g., "CHARACTER: Text here")
        let dialogueRegex = "^[A-Z]+: .+"
        // Regex for Parentheticals (e.g., "(whispering)")
        let parentheticalRegex = "^\\(.*\\)$"
        // Regex for Transitions (e.g., "CUT TO", "FADE OUT")
        let transitionRegex = "^(CUT TO|FADE TO|DISSOLVE TO|SMASH CUT|WIPE TO|JUMP CUT|FADE OUT)\\.?$"
        
        if NSPredicate(format: "SELF MATCHES %@", sceneHeadingRegex).evaluate(with: line) {
            return .heading
        } else if NSPredicate(format: "SELF MATCHES %@", dialogueRegex).evaluate(with: line) {
            return .dialogue
        } else if NSPredicate(format: "SELF MATCHES %@", parentheticalRegex).evaluate(with: line) {
            return .parenthetical
        } else if NSPredicate(format: "SELF MATCHES %@", transitionRegex).evaluate(with: line) {
            return .transition
        } else {
            return .action
        }
    }
    
    var body: some View {
        if screenplay.isEmpty {
            ContentUnavailableView("Start Writing in a lesson or on the playground and see the magic happen!", systemImage: "pencil.line")
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: spacing) {
                    ForEach(parseScreenplay(), id: \.0) { line, type in
                        switch type {
                        case .heading:
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .fontWeight(.bold)
                                .padding(.leading, fontSize)
                                .multilineTextAlignment(.leading)
                            
                        case .action:
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .padding(.leading, fontSize)
                                .multilineTextAlignment(.leading)
                            
                        case .dialogue:
                            let components = line.split(separator: ":")
                            if components.count > 1 {
                                let characterName = String(components[0]).trimmingCharacters(in: .whitespaces)
                                let dialogueText = String(components[1]).trimmingCharacters(in: .whitespaces)
                                
                                VStack(alignment: .center) {
                                    Text(characterName)
                                        .font(.custom("Courier", size: fontSize))
                                    Text(dialogueText)
                                        .font(.custom("Courier", size: fontSize))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, fontSize)
                            } else {
                                // Handle dialogue lines without a character name (e.g., continuation after parenthetical)
                                Text(line)
                                    .font(.custom("Courier", size: fontSize))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.horizontal, fontSize)
                                    .padding(.top, -14)
                            }
                            
                        case .parenthetical:
                            VStack(alignment: .center) {
                                Text(line)
                                    .font(.custom("Courier", size: fontSize))
                                    .padding(.top, -14)
                            }.frame(maxWidth: .infinity)
                            
                        case .transition:
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, fontSize)
                        }
                    }
                }
                .padding(.top, 20)
                .navigationTitle("Live Preview")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    NavigationSplitView(columnVisibility: .constant(.all)) {
        //ContentUnavailableView("Select a lesson or the playground", systemImage: "pencil")
    } content: {
        //ContentUnavailableView("Select a lesson or the playground", systemImage: "pencil")
    } detail: {
        ScreenplayPreviewView(screenplay: """
        INT. LIVING ROOM - DAY
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vel libero vel libero.

        JOHN: Hello, how are you?
        (whispering)
        I think we should leave.

        MARY: Yeah, I agree.

        FADE OUT.
        """)
    }
}
