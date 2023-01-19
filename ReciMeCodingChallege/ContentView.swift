//
//  ContentView.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("\(AppConfiguration.shared.environment.rawValue)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
