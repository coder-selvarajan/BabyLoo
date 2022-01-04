//
//  LooListViewModel.swift
//  BabyLoo
//
//  Created by Selvarajan on 04/01/22.
//

import Foundation
import CoreData

class LooListViewModel: ObservableObject {
    @Published var looEntries = [looActivity]()
    
    func getAllLooActivities() {
//        let looActivities : [Loo] = Loo.all()
    }
}

struct looActivity {
    
}
