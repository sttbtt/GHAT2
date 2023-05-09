//
//  UnitTestingView.swift
//  GHAT2
//
//  Created by Scott Bennett on 5/8/23.
//

import SwiftUI

struct UnitTestingView: View {
    
    @StateObject private var vm: UnitTestingViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.yellow)
                .font(.title)
            Text(vm.isPremium.description)
        }
        .padding()
    }
}

struct UnitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingView(isPremium: true)
    }
}
