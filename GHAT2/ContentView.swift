//
//  ContentView.swift
//  GHAT2
//
//  Created by Scott Bennett on 5/5/23.
//
// Testing

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName : "globe")
                .imageScale(.large)
                .foregroundColor(.red)
                .font(.title)
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
