//
//  Playground.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 11/01/25.
//

import SwiftUI

struct Playground: View {
    
    @Binding var screenplay: String
    
    var body: some View {
        TextEditor(text: $screenplay)
            .border(Color(uiColor: UIColor.systemGray5))
            .padding()
            .navigationTitle("Playground")
    }
}

#Preview {
    NavigationSplitView(columnVisibility: .constant(.all)) {
        
        
    } content: {
        Playground(screenplay: .constant("This is a screenplay"))
    } detail: {
        
    }

}
