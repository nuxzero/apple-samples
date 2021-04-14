//
//  NoteFormViewController.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 13/1/2564 BE.
//

import UIKit

class NoteFormViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: NoteFormDelegate?
    var note: Note?
    private let noteService = NoteService.shared
    var isNewNote = true
    var randomImageUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let note = note {
            isNewNote = false
            titleTextField.text = note.title
            noteTextField.text = note.note
            ImageLoader.loadImage(with: imageView, for: note.image, completionHandler: nil)
        } else {
            randomImage()
        }
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(randomImage)))
    }
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        if isNewNote {
            addNote()
        } else {
            updateNote()
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.noteFormCancelled()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func randomImage() {
        let url = "https://picsum.photos/id/\(Int.random(in: 1..<1000))/800/1200"
        ImageLoader.loadImage(with: imageView, for: url) { result in
            switch result {
            case .success(let url):
                self.randomImageUrl = url
            case .failure(let error):
                print(error)
            }
        }
        
        print("random image")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            
        }
    }
    
    private func addNote() {
        let id = Int.random(in: 1..<1000)
        let parameters = NoteParameters(
            id: id,
            title: titleTextField.text ?? "",
            note: noteTextField.text ?? "",
            author: "John Doe",
            image: randomImageUrl?.absoluteString ?? "",
            createdAt: Date()
        )
        noteService.addNote(parameters) { result in
            switch result {
            case .success(_):
                print("Add note success.")
            case .failure(let error):
                print(error)
            }
            self.delegate?.noteFormSaved()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateNote() {
        guard let note = note else {
            fatalError("Note must not be nil.")
        }
        
        let parameters = NoteParameters(
            id: note.id,
            title: titleTextField.text ?? "",
            note: noteTextField.text ?? "",
            author: "John Doe",
            image: note.image,
            createdAt: Date()
        )
        
        noteService.updateNote(parameters) { result in
            switch result {
            case .success(_):
                print("Update note success.")
            case .failure(let error):
                print(error)
            }
            self.delegate?.noteFormSaved()
            self.dismiss(animated: true, completion: nil)
        }
    }
}

protocol NoteFormDelegate {
    func noteFormSaved()
    func noteFormCancelled()
}
