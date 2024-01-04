//
//  NoteModel.swift
//  Notes
//
//  Created by Pedro on 4/1/24.
//

import Foundation

enum NoteStatus: String, Codable {
    case toDo = "TO-DO"
    case inProgress = "IN-Progress"
    case done = "Done"
}

struct NoteModel: Codable, Identifiable {
    let id: String
    var isFavorited: Bool
    let description: String
    var status: NoteStatus

    init(id: String = UUID().uuidString, isFavorited: Bool = false, description: String, status: NoteStatus = .toDo) {
        self.id = id
        self.isFavorited = isFavorited
        self.description = description
        self.status = status
    }
}
