//
//  LooListViewModel.swift
//  BabyLoo
//
//  Created by Selvarajan on 04/01/22.
//

import Foundation
import CoreData

class LooListViewModel: ObservableObject {
    @Published var looAllEntries = [LooViewModel]()
    @Published var looEntries = [LooViewModel]()
    @Published var lastPee: String = ""
    @Published var lastPoo: String = ""
    
    func getAllLooEntries() {
        let looEntries : [Loo] = Loo.all()

        DispatchQueue.main.async {
            self.looAllEntries = looEntries.map(LooViewModel.init)
        }
        
        getLastPeeTime()
        getLastPooTime()
    }
    
    func getLooEntriesFor(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let looEntries : [Loo] = Loo.byDate(dat: dateFormatter.string(from: date))
        
        DispatchQueue.main.async {
            self.looEntries = looEntries.map(LooViewModel.init)
        }
        
        getLastPeeTime()
        getLastPooTime()
    }
    
    func deleteLoo(loo: LooViewModel) {
        let loo: Loo? = Loo.byId(id: loo.id)
        if let loo = loo {
            let currentDate = loo.timestamp
            loo.delete()
            getLooEntriesFor(date: currentDate ?? Date())
        }
    }
    
    func getLastPeeTime() {
        let looEntries : [Loo] = Loo.all()
        
        guard looEntries.count > 0 else { return }
        
        let peeEntries = looEntries.filter { loovm in
            loovm.pee
        }
        
        lastPee = peeEntries.last?.timestamp?.displayTime() ?? ""
    }
    
    func getLastPooTime() {
        let looEntries : [Loo] = Loo.all()
        guard looEntries.count > 0 else { return }
        let pooEntries = looEntries.filter { loovm in
            loovm.poo
        }
        lastPoo = pooEntries.last?.timestamp?.displayTime() ?? ""
    }
    
    func getPooCount() -> Int {
        guard looEntries.count > 0 else { return 0 }
        return looEntries.filter { loovm in
            loovm.poo
        }.count
    }
    
    func getPeeCount() -> Int {
        guard looEntries.count > 0 else { return 0 }
        return looEntries.filter { loovm in
            loovm.pee
        }.count
    }
    
    func updateLoo(id: NSManagedObjectID, looTimestamp: Date, poo: Bool, pee: Bool) {
        let loo: Loo? = Loo.byId(id: id)
        if let loo = loo {
            loo.timestamp = looTimestamp
            loo.pee = pee
            loo.poo = poo
            loo.save()
            
            let currentDate = loo.timestamp
            getLooEntriesFor(date: currentDate ?? Date())
        }
    }
}

struct LooViewModel: Identifiable {
    let loo: Loo
    
    var id: NSManagedObjectID {
        return loo.objectID
    }
    var timestamp: Date {
        return loo.timestamp ?? Date()
    }
    var poo: Bool {
        return loo.poo
    }
    var pee: Bool {
        return loo.pee
    }
}
