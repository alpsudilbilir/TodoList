//
//  AddTaskView.swift
//  TodoSwiftUI
//
//  Created by Alpsu Dilbilir on 7.02.2022.
//

import SwiftUI


struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var detailedInfo = ""
    let priorities = ["Low", "Medium", "High"]
    @State private var selectedPriority = "Medium"
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $name)
                    } header: {
                        Text("Please enter the name of task.")
                    }
                    Section {
                        Picker("Priority", selection: $selectedPriority) {
                            ForEach(priorities, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    } header: {
                        Text("Prıorıty")
                    }
                    Section {
                        TextEditor(text: $detailedInfo)
                    } header: {
                        Text("Detailed Information")
                    }
                }
                Button {
                    let newTask = Task(context: moc)
                    newTask.name = name
                    newTask.priority = selectedPriority
                    newTask.detail = detailedInfo
                    newTask.date = Date()
                    try? moc.save()
                    dismiss()
                } label: {
                    Text("Save")
                    
                }.disabled(isNameEmpty())
                Spacer()
            }
            
            .navigationTitle("Add task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func isNameEmpty() -> Bool {
        if name.isEmpty {
            return true
        }
        return false
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
