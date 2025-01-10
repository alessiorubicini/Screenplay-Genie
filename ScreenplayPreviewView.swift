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
    
    private func parseScreenplay() -> [String] {
        let lines: [String] = screenplay.split(whereSeparator: \.isNewline)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        return lines
    }
    
    private func getElementType(for line: String) -> ElementType {
        // Regex for Scene Heading (e.g., "INT. LIVING ROOM - DAY")
        let sceneHeadingRegex = "^(INT|EXT)\\. .+ - (DAY|NIGHT|MORNING|EVENING)$"
        // Regex for Dialogue (e.g., "CHARACTER: Text here")
        let dialogueRegex = "^[A-Z]+: .+"
        // Regex for Parentheticals (e.g., "(whispering) text here")
        let parentheticalRegex = "^\\(.+\\)$"
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
        ScrollView {
            VStack(alignment: .leading, spacing: spacing) {
                ForEach(parseScreenplay(), id: \.self) { line in
                    let type = getElementType(for: line)
                    
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
                        }
                        
                    case .parenthetical:
                        VStack(alignment: .center) {
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .padding(.top, -14)
                        }.frame(maxWidth: .infinity)
                        
                    case .transition:
                        VStack(alignment: .trailing) {
                            Text(line)
                                .font(.custom("Courier", size: fontSize))
                                .padding(.leading, 16)
                                .multilineTextAlignment(.trailing)
                            
                        }.frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}

struct ScreenplayPreviewView_Previews: PreviewProvider {
    static var previews: some View {
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
