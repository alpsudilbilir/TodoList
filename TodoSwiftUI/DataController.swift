//
//  DataController.swift
//  TodoSwiftUI
//
//  Created by Alpsu Dilbilir on 7.02.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Todomodel")
    
    init() {
        container.loadPersistentStores { description, error in
            if error != nil {
                print("Failed to load Core Data...")
            }
        }
    }
}
