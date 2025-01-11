//
//  AboutView.swift
//  Screenplay Genie
//
//  Created by Alessio Rubicini on 11/01/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NavigationSplitView(columnVisibility: .constant(.all)) {
        
    } content: {
        AboutView()
    } detail: {
        
    }

}
