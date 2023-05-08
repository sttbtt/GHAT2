//
//  ContentView.swift
//  GHAT2
//
//  Created by Scott Bennett on 5/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName :"globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .font(.largeTitle)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
