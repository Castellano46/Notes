//
//  ContentView.swift
//  Notes
//
//  Created by Pedro on 4/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var descriptionNote: String = ""
    @State private var selectedStatus: NoteStatus = .toDo
    @StateObject var notesViewModel = NotesViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Añade una tarea")
                    .underline()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                TextEditor(text: $descriptionNote)
                    .foregroundColor(.gray)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.green, lineWidth: 2)
                    )
                    .padding(.horizontal, 12)
                    .cornerRadius(3.0)

                Picker("Estado", selection: $selectedStatus) {
                    Text("TO-DO").tag(NoteStatus.toDo)
                    Text("IN-Progress").tag(NoteStatus.inProgress)
                    Text("Done").tag(NoteStatus.done)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 12)

                Button("Crear") {
                    guard !descriptionNote.isEmpty else {
                        return
                    }

                    notesViewModel.saveNote(description: descriptionNote)
                    descriptionNote = ""
                }
                .buttonStyle(.bordered)
                .tint(.green)

                Spacer()

                List {
                    ForEach(notesViewModel.getNotes(forStatus: selectedStatus), id: \.id) { note in
                        HStack {
                            if note.isFavorited {
                                Text("⭐️")
                            }
                            Text(note.description)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                notesViewModel.updateFavoriteNote(note: note)
                            } label: {
                                Label("Favorito", systemImage: "star.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                notesViewModel.removeNote(withId: note.id)
                            } label: {
                                Label("Borrar", systemImage: "trash.fill")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle("Notes App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Text(notesViewModel.getCountForToDoAndInProgress())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
