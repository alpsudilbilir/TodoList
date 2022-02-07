//
//  ContentView.swift
//  TodoSwiftUI
//
//  Created by Alpsu Dilbilir on 7.02.2022.
//

import SwiftUI
import CoreData
struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var tasks: FetchedResults<Task>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var doneTasks: FetchedResults<Donetask>
    @State private var showAddScreen = false
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack(spacing: 1) {
                Spacer()
                List {
                    Section {
                        ForEach(tasks, id: \.self) { task in
                            HStack {
                                Image(systemName: "square")
                                    .onTapGesture {
                                        let doneTask = Donetask(context: moc)
                                        doneTask.name = task.name
                                        doneTask.detail = task.detail
                                        doneTask.date = task.date
                                        doneTask.priority = task.priority
                                        moc.delete(task)
                                        try? moc.save()
                                    }
                                Circle()
                                    .fill()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(selectColor(priority: task.priority!))
                                Text(task.name ?? "Unkown")
                                NavigationLink("") {
                                    DetailsView(task: task, doneTask: nil, isTask: true)
                                }
                                
                                
                            }
                        }
                        .onDelete(perform: deleteTasks)
                    } header: {
                        Text("Unfinished Tasks")
                    }
                }
                List {
                    Section {
                        ForEach(doneTasks, id: \.self) { donetask in
                            HStack {
                                Image(systemName: "checkmark.square.fill")
                                    .onTapGesture {
                                        let taskR = Task(context: moc)
                                        taskR.name = donetask.name
                                        taskR.detail = donetask.detail
                                        taskR.date = donetask.date
                                        taskR.priority = donetask.priority
                                        moc.delete(donetask)
                                        try? moc.save()
                                    }
                                Circle()
                                    .fill()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(selectColor(priority: donetask.priority!))
                                Text(donetask.name ?? "Unkown")
                                Spacer()
                                NavigationLink("") {
                                    DetailsView(task: nil, doneTask: donetask, isTask: false)
                                }
                                
                            }
                        }
                        .onDelete(perform: deleteDoneTasks)
                    } header: {
                        Text("Completed Tasks")
                    }
                }
                Button("Finish Day") {
                    showAlert = true
                }
            }
            .navigationTitle("Today's Tasks")
            .toolbar {
                ToolbarItem {
                    Button("Add Task") {
                        showAddScreen = true
                    }
                }
            }
            .sheet(isPresented: $showAddScreen) {
                AddTaskView()
            }
            .alert("Finish Day?", isPresented: $showAlert) {
                Button("Confirm", role: .destructive, action: finishDay)
            } message: {
                Text("Finishing the day will delete all tasks. Are you sure?")
            }
        }
    }
    func finishDay() {
        //Delete Task Entity items
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        do {
            let taskItems = tasks

            for item in taskItems {
                moc.delete(item)
            }

            // Save Changes
            try moc.save()

        } catch {
            print("Failed to delete.")
        }
        //Delete DoneTask Entity items
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Donetask")
        fetchRequest2.includesPropertyValues = false
        do {
            let doneTaskItems = doneTasks
            for item in doneTaskItems {
                moc.delete(item)
            }
            try moc.save()
        } catch {
            print("Failed to delete.")
        }
        
    }
    func selectColor(priority: String) -> Color {
        switch priority {
        case "Low":
            return Color.green
        case "High":
            return Color.red
        default:
            return Color.yellow
        }
    }
    func deleteTasks(at offsets: IndexSet) {
        for offset in offsets {
            let task = tasks[offset]
            moc.delete(task)
            try? moc.save()
        }
    }
    func deleteDoneTasks(at offsets: IndexSet){
        for offset in offsets {
            let doneTask = doneTasks[offset]
            moc.delete(doneTask)
            try? moc.save()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .accessibilityIdentifier(/*@START_MENU_TOKEN@*/"Identifier"/*@END_MENU_TOKEN@*/)
    }
}
