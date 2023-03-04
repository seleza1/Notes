//
//  ViewController.swift
//  Заметульки
//
//  Created by user on 18.02.2023.
//

import UIKit

protocol AllNotesViewControllerDelegate {
    func addAddress(city: String)
}

class AllNotesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let identifier = "cell"
    var allNotes: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        saveAllAddress()
    }

    private func saveAllAddress() {
        allNotes = StorageManager.shared.fetchNotes()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddNotesViewController else { return }
        vc.delegate = self
    }


}

extension AllNotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let address = allNotes[indexPath.row]
        cell.textLabel?.text = address

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }

        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.shared.deleteContact(at: indexPath.row)
            allNotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}

extension AllNotesViewController: AllNotesViewControllerDelegate {

    func addAddress(city: String) {
        allNotes.append(city)
        tableView.reloadData()
    }
}

