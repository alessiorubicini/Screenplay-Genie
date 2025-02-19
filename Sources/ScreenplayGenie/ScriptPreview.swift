import SwiftUI

struct ScriptPreview: View {
    let screenplay: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(parseScreenplay(screenplay), id: \.self) { element in
                    switch element.type {
                    case .heading:
                        Text(element.text)
                            .font(.custom("Courier", size: 16))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    case .action:
                        Text(element.text)
                            .font(.custom("Courier", size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    case .character:
                        Text(element.text)
                            .font(.custom("Courier", size: 16))
                            .frame(maxWidth: .infinity, alignment: .center)
                    case .dialogue:
                        Text(element.text)
                            .font(.custom("Courier", size: 16))
                            .frame(maxWidth: .infinity, alignment: .center)
                    case .transition:
                        Text(element.text)
                            .font(.custom("Courier", size: 16))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .padding()
        }
    }

    func parseScreenplay(_ screenplay: String) -> [ScreenplayElement] {
        // Simple parser for demonstration purposes
        let lines = screenplay.split(separator: "\n").map { String($0) }
        var elements: [ScreenplayElement] = []

        for line in lines {
            if line.hasPrefix("INT.") || line.hasPrefix("EXT.") {
                elements.append(ScreenplayElement(type: .heading, text: line))
            } else if line.hasSuffix(":") {
                elements.append(ScreenplayElement(type: .character, text: line))
            } else if line.hasSuffix(".") {
                elements.append(ScreenplayElement(type: .transition, text: line))
            } else if line.starts(with: "    ") {
                elements.append(ScreenplayElement(type: .dialogue, text: line.trimmingCharacters(in: .whitespaces)))
            } else {
                elements.append(ScreenplayElement(type: .action, text: line))
            }
        }

        return elements
    }
}

struct ScreenplayElement: Hashable {
    enum ElementType {
        case heading, action, character, dialogue, transition
    }

    let type: ElementType
    let text: String
}

struct ScriptPreview_Previews: PreviewProvider {
    static var previews: some View {
        ScriptPreview(screenplay: """
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
