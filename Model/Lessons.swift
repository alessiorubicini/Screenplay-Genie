//
//  Lessons.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 10/01/25.
//

extension Lesson {
    
    // Example lessons
    static var allLessons: [Lesson] = [
        Lesson(
            title: "Scene Headings",
            icon: "rectangle.and.text.magnifyingglass",
            explanation: "A scene heading is a crucial element in a screenplay. It sets the scene by specifying whether the location is interior (INT.) or exterior (EXT.), followed by the specific location, and then the time of day.\n\nThis gives the reader (or director, actor, etc.) a clear understanding of where and when the scene is taking place. Scene headings are always written in all caps and must adhere to a specific structure to maintain consistency and clarity in the screenplay.\n\nThe format also includes terms like “DAY” or “NIGHT” to indicate the time of day. Using correct scene headings ensures your screenplay is easy to read and professional.",
            example: "Example: INT. OFFICE - NIGHT",
            regex: "^(INT|EXT)\\. [A-Z0-9 ]+ - (DAY|NIGHT|MORNING|EVENING)$"
        ),
        Lesson(
            title: "Action Lines",
            icon: "figure.walk",
            explanation: "Action lines describe everything that happens on screen during a scene. They provide vivid, concise details about what the audience is seeing, and should always be written in present tense.\n\nThese lines should start with a capital letter, and the focus should be on what is happening in the scene. For example, you might describe the movements of characters or the surrounding environment.\n\nAction lines give life to the screenplay and provide critical context to the actors and directors. A well-written action line should be simple, yet descriptive, providing just enough information without overwhelming the reader.",
            example: "Example: He walks into the room and sits down.",
            regex: "^[A-Z].+$"
        ),
        Lesson(
            title: "Dialogues",
            icon: "text.bubble",
            explanation: "Dialogue lines represent what the characters say during the story. This is one of the most important elements of a screenplay because it reveals a character’s personality, thoughts, and motivations.\n\nDialogue is always preceded by the character’s name, written in uppercase letters, followed by a colon. The dialogue text itself is typically written in regular sentence case.\n\nWhen writing dialogue, you need to ensure it’s realistic and true to the character, advancing the plot or revealing something about the character. Dialogue can convey a lot of information in a few words, so each line should be carefully crafted to suit the tone and pacing of the scene.",
            example: "Example: JOHN: Hello, how are you?",
            regex: "^[A-Z]+: .+$"
        ),
        Lesson(
            title: "Parentheticals",
            icon: "parentheses",
            explanation: "Parentheticals are instructions that clarify how a line of dialogue should be delivered by the actor. They are placed in parentheses directly below the character’s name and are typically used to indicate the character’s emotional state, actions, or tone of voice.\n\nThese instructions should be used sparingly, as excessive parentheticals can clutter the screenplay and detract from the dialogue. They’re often used in specific moments to help guide the performance, such as “(shouting)” or “(whispering)”.\n\nParentheticals are meant to enhance the script and not dictate every nuance of the performance. It’s important to strike a balance—use them when necessary, but don’t over-explain the delivery of lines.",
            example: "Example: (whispering) I'm not sure about this.",
            regex: "^\\(.+\\)$"
        ),
        Lesson(
            title: "Transitions",
            icon: "arrowshape.turn.up.right",
            explanation: "Transitions in a screenplay indicate how one scene transitions to another. They are typically written in all caps to make them stand out.\n\nTransitions help the director and editor know what kind of change is happening between scenes, such as whether one scene will cut to another or fade out to black. The most common transitions are “CUT TO”, “FADE OUT”, “DISSOLVE TO”, and “SMASH CUT”. These terms help to structure the flow of the film.\n\nHowever, screenwriters should be cautious about overusing transitions, as they can break the natural flow of the story. It’s often best to leave transitions to the director unless they are crucial for the visual storytelling.",
            example: "Example: CUT TO:",
            regex: "^(CUT TO|FADE OUT|DISSOLVE TO|SMASH CUT):$"
        )
    ]
    
}
