//
//  NoteDetailViewController.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 13/1/2564 BE.
//

import UIKit

class NoteDetailViewController: UIViewController {

    let noteService = NoteService.shared
    
    var note: Note?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    @IBAction func editNote(_ sender: Any) {
        print("Go to note form")
    }
    
    
    func updateView() {
        noteService.retrieveNote(with: note!.id) { result in
            switch result {
            case .success(let note):
                self.titleLabel.text = note.title
                self.descriptionLabel.text = note.note
                ImageLoader.loadImage(with: self.bannerImageView, for: note.image, completionHandler: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToEditNote" {
            guard let destinationViewController = segue.destination as? UINavigationController,
                  let noteFormViewController = destinationViewController.children[0] as? NoteFormViewController else {
                fatalError("The segue is not instance of NoteFormViewController.")
            }
            noteFormViewController.delegate = self
            noteFormViewController.note = note
        }
    }

}

extension NoteDetailViewController: NoteFormDelegate {
    func noteFormSaved() {
        updateView()
    }
    
    func noteFormCancelled() {
        
    }
}
