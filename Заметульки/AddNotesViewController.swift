//
//  AddNotesViewController.swift
//  Заметульки
//
//  Created by user on 18.02.2023.
//

import UIKit

class AddNotesViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    let userDefaults = UserDefaults.standard

    var delegate: AllNotesViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.cornerRadius = 30
    }
    @IBAction func saveTapped(_ sender: UIButton) {
        saveDate()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func saveDate() {
        guard let notes = textField.text else { return }
        StorageManager.shared.saveNotes(note: notes)
        delegate.addAddress(city: notes)
        dismiss(animated: true)
    }

}
