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
    let spacing: CGFloat = 5

    private enum ElementType {
        case heading, character, action, dialogue, parenthetical, transition
    }
    
    private func parseScreenplay() -> [(String, ElementType)] {
        let lines: [String] = screenplay.split(whereSeparator: \.isNewline)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        var parsedLines: [(String, ElementType)] = []
        var previousType: ElementType? = nil
        
        for line in lines {
            let type = getElementType(for: line, previousType: previousType)
            
            switch type {
            case .dialogue, .parenthetical:
                // Dialogue and parentheticals stick to the previous character
                parsedLines.append((line, type))
            default:
                parsedLines.append((line, type))
            }
            
            previousType = type
        }
        
        return parsedLines
    }
    
    private func getElementType(for line: String, previousType: ElementType?) -> ElementType {
        let sceneHeadingRegex = #"^(INT\.?|EXT\.?)(.*)$"#
        let characterRegex = #"^[A-Z][A-Z0-9 @'’\-]+$"#
        let parentheticalRegex = #"^\(.*\)$"#
        let transitionRegex = #"^(?:FADE (?:IN|OUT)|CUT TO|DISSOLVE TO|SMASH TO|WIPE TO|JUMP CUT|MATCH CUT TO)[.:]$"#
        
        if NSPredicate(format: "SELF MATCHES %@", sceneHeadingRegex).evaluate(with: line) {
            return .heading
        } else if NSPredicate(format: "SELF MATCHES %@", characterRegex).evaluate(with: line) {
            return .character
        } else if NSPredicate(format: "SELF MATCHES %@", parentheticalRegex).evaluate(with: line) {
            return .parenthetical
        } else if NSPredicate(format: "SELF MATCHES %@", transitionRegex).evaluate(with: line) {
            return .transition
        } else if previousType == .character || previousType == .parenthetical {
            return .dialogue
        } else {
            return .action
        }
    }
    
    var body: some View {
        if screenplay.isEmpty {
            ContentUnavailableView("Start Writing in a lesson or on the playground and see the magic happen!", systemImage: "pencil.line")
        } else {
            ScrollView {
                VStack {
                    let parsedLines = parseScreenplay() // Store parsed screenplay lines
                    ForEach(parsedLines.indices, id: \.self) { index in
                        let (line, type) = parsedLines[index]
                        let nextType = index + 1 < parsedLines.count ? parsedLines[index + 1].1 : nil
                        
                        switch type {
                        case .heading:
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .bold()
                                .padding(.leading, fontSize)
                                .padding(.bottom, spacing)
                                .multilineTextAlignment(.leading)
                            
                        case .action:
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, fontSize)
                                .padding(.bottom, spacing)
                                .multilineTextAlignment(.leading)
                            
                        case .character:
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, fontSize)
                            
                        case .dialogue:
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, fontSize * 5)
                                .padding(.bottom, nextType == .parenthetical ? 0 : spacing) // Conditionally apply bottom padding
                            
                        case .parenthetical:
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, fontSize * 5)
                            
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
    } content: {
    } detail: {
        ScreenplayPreviewView(screenplay: ScreenplayMocks.fullScreenplay.rawValue)
    }
}
