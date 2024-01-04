//
//  NotesViewModel.swift
//  Notes
//
//  Created by Pedro on 4/1/24.
//

import Foundation
import SwiftUI

final class NotesViewModel: ObservableObject {
    @Published var notes: [NoteModel] = []

    init() {
        notes = getAllNotes()
    }

    func saveNote(description: String) {
        let newNote = NoteModel(description: description, status: .toDo)
        notes.insert(newNote, at: 0)
        encodeAndSaveAllNotes()
    }

    private func encodeAndSaveAllNotes() {
        do {
            let encoded = try JSONEncoder().encode(notes)
            UserDefaults.standard.set(encoded, forKey: "notes")
        } catch {
            print("Error encoding and saving notes: \(error.localizedDescription)")
        }
    }

    func getAllNotes() -> [NoteModel] {
        guard let notesData = UserDefaults.standard.object(forKey: "notes") as? Data else {
            return []
        }

        do {
            let notes = try JSONDecoder().decode([NoteModel].self, from: notesData)
            return notes
        } catch {
            print("Error decoding notes: \(error.localizedDescription)")
            return []
        }
    }

    func removeNote(withId id: String) {
        notes.removeAll(where: { $0.id == id })
        encodeAndSaveAllNotes()
    }

    func updateFavoriteNote(note: NoteModel) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isFavorited.toggle()
            
            if notes[index].status == .toDo && notes[index].isFavorited {
                notes[index].status = .inProgress
            } else if notes[index].status == .inProgress && !notes[index].isFavorited {
                notes[index].status = .done
            }
            encodeAndSaveAllNotes()
        }
    }

    private func getUpdatedStatus(for note: NoteModel) -> NoteStatus {
        if note.isFavorited {
            return .inProgress
        }
        return note.status
    }

    func getNumberOfNotes() -> String {
        "\(notes.count)"
    }

    func getNotes(forStatus status: NoteStatus) -> [NoteModel] {
        return notes.filter { $0.status == status }
    }
    
    func getCountForToDoAndInProgress() -> String {
        let count = notes.filter { $0.status == .toDo || $0.status == .inProgress }.count
        return "\(count)"
    }
}
