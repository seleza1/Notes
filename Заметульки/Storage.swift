import Foundation

final class StorageManager {
    static let shared = StorageManager()

    private let defaults = UserDefaults.standard
    private let notesKey = "Notes"

    private init() {}

    func saveNotes(note: String) {
        var notes = fetchNotes()
        notes.append(note)
        defaults.set(notes, forKey: notesKey)
    }

    func fetchNotes() -> [String] {
        if let notes = defaults.value(forKey: notesKey) as? [String] {
            return notes
        }
        return []
    }

    func deleteContact(at index: Int) {
        var notes = fetchNotes()
        notes.remove(at: index)
        defaults.set(notes, forKey: notesKey)

    }
}
