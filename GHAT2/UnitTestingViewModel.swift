//
//  UnitTestingViewModel.swift
//  GHAT2
//
//  Created by Scott Bennett on 5/8/23.
//

import SwiftUI

class UnitTestingViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}
