//
//  TodoSwiftUIApp.swift
//  TodoSwiftUI
//
//  Created by Alpsu Dilbilir on 7.02.2022.
//

import SwiftUI

@main
struct TodoSwiftUIApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
