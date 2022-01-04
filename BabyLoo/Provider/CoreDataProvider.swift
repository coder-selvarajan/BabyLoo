//
//  CoreDataProvider.swift
//  BabyLoo
//
//  Created by Selvarajan on 01/01/22.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataProvider {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataProvider()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "LooModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
        
//        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveLoo(poo: Bool, pee: Bool) {
        let loo = Loo(context: viewContext)
        loo.pee = pee
        loo.poo = poo
        loo.timestamp = Date()
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save loo entry")
        }
    }
    func deleteLoo(loo: Loo) {
        
        viewContext.delete(loo)
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateLoo(loo: Loo){
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
    
    func getAllLoo() -> [Loo] {
        let fetchRequest : NSFetchRequest<Loo> = Loo.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
}


