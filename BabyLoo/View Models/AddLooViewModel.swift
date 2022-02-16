//
//  AddLooViewModel.swift
//  BabyLoo
//
//  Created by Selvarajan on 04/01/22.
//

import Foundation

class AddLooViewModel: ObservableObject {
    
    var timestamp: Date = Date()
    var poo: Bool = false
    var pee: Bool = false
    
    func save() {
        let loo = Loo(context: Loo.viewContext)
        loo.timestamp = timestamp
        loo.poo = poo
        loo.pee = pee
        
        loo.save()
    }
    
}
