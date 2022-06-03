//
//  ContentView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 3/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.location, ascending: true)],
        animation: .default)
    private var Places: FetchedResults<Place>

    var body: some View {
        NavigationView {
            List {
                ForEach(Places) { Place in
                    NavigationLink {
                        PlaceView(place: Place)
                            .navigationBarItems(trailing: EditButton())
                    } label: {
                        PlaceRowView(place: Place)
                    }
                }
                .onDelete(perform: deletePlaces)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addPlace) {
                        Label("Add Place", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Places App")
            Text("Select an Place")
        }
    }

    
    // note: Move all CRUD func to ViewModel
    /// function to add a new Place
    private func addPlace() {
        withAnimation {
            let newPlace = Place(context: viewContext)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    /// function to delete a Place at the offsets
    /// - Parameter offsets: a set of int generated when the user swipe a row
    private func deletePlaces(offsets: IndexSet) {
        withAnimation {
            offsets.map { Places[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//private let PlaceFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
