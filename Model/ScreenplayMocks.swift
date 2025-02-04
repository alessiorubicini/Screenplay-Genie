//
//  ScreenplayMocks.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 04/02/25.
//


enum ScreenplayMocks: String {
    case onlyHeading = "INT. COFFEE SHOP - MORNING"
    case onlyActionLine = "The door opens"
    case onlyCharacter = "JOHN"
    case onlyDialogue = "Hello"
    case onlyTransition = "FADE OUT"
    case fullScreenplay = """
        INT. LIVING ROOM - DAY
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vel libero vel libero.

        JOHN: Hello, how are you?
        (whispering)
        I think we should leave.

        MARY: Yeah, I agree.

        FADE OUT.
    """
}
