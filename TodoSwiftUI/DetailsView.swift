//
//  DetailsView.swift
//  TodoSwiftUI
//
//  Created by Alpsu Dilbilir on 7.02.2022.
//

import SwiftUI

struct DetailsView: View {
    @State var task: Task?
    @State var doneTask: Donetask?
    @State var isTask: Bool
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text(isTask ? "\(task!.name!)" : "\(doneTask!.name!)")
                } header: {
                    Text("TITLE")
                }
                Section {
                    Text( isTask ? "\(task!.priority!)" : "\(doneTask!.priority!)")
                } header: {
                    Text("PRIORITY")
                }
                Section {
                    Text(isTask ? formatDate(date: task!.date!) : formatDate(date:doneTask!.date!))
                } header: {
                    Text("DATE ADDED")
                }
                Section {
                    Text( isTask ? "\(task!.detail!)" : "\(doneTask!.detail!)")
                } header: {
                    Text("DETAILS")
                }
            }    
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E"
        return formatter.string(from: isTask ? task!.date! : doneTask!.date!)
    }
}






