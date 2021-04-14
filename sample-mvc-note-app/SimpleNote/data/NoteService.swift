//
//  NoteService.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 11/1/2564 BE.
//

import Foundation

class NoteService {
    
    static let shared = NoteService()
    
    private var notes:[Note] = []
    private let networkService = NetworkService.shared
    
    init() {
        notes += [
            Note(
                id: 1,
                title: "Lorem ipsum dolor sit amet",
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                author: "John Doe",
                image: "https://images.unsplash.com/photo-1610049952124-214a528991c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1526&q=80",
                createdAt: Date()
            ),
            Note(
                id: 2,
                title: "Lorem ipsum dolor sit amet",
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                author: "John Doe",
                image: "https://images.unsplash.com/photo-1610049952124-214a528991c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1526&q=80",
                createdAt: Date()
            ),
        ]
        
    }
    
    func retrieveNotes(_ completionHandler: @escaping (Result<[Note], Error>) -> Void) {
        let request = Note.getNoteListRequest()
        networkService.send(request) { result in
            var completionResult: Result<[Note], Error>
            defer {
                completionHandler(completionResult)
            }
            
            switch result {
            case .success(let data):
                print(data!)
                completionResult = .success(data!)
            case.failure(let error):
                print(error)
                completionResult = .failure(error)
            }
        }
    }
    
    func retrieveNote(with id: Int, completionHandler: @escaping (Result<Note, Error>) -> Void) {
        let request = Note.getNoteRequest(id)
        networkService.send(request) { result in
            var completionResult: Result<Note, Error>
            defer {
                completionHandler(completionResult)
            }
            
            switch result {
            case .success(let data):
                print(data!)
                completionResult = .success(data!)
            case.failure(let error):
                print(error)
                completionResult = .failure(error)
            }
        }
    }
    
    func addNote(_ parameters: NoteParameters, completionHandler: @escaping (Result<Note, Error>) -> Void) {
        let request = Note.createNoteRequest(parameters)
        networkService.send(request) { result in
            var completionResult: Result<Note, Error>
            defer {
                completionHandler(completionResult)
            }
            
            switch result {
            case .success(let data):
                print(data!)
                completionResult = .success(data!)
            case.failure(let error):
                print(error)
                completionResult = .failure(error)
            }
        }
    }
    
    func updateNote(_ parameters: NoteParameters, completionHandler: @escaping (Result<Note, Error>) -> Void) {
        let request = Note.updateNoteRequest(parameters)
        networkService.send(request) { result in
            var completionResult: Result<Note, Error>
            defer {
                completionHandler(completionResult)
            }
            
            switch result {
            case .success(let data):
                print(data!)
                completionResult = .success(data!)
            case.failure(let error):
                print(error)
                completionResult = .failure(error)
            }
        }
//        guard let index = notes.firstIndex(where: {return $0.id == note.id}) else {
//            fatalError("Index not found.")
//        }
//        notes.remove(at: index)
//        notes.insert(note, at: index)
    }
    
    func deleteNote(_ id: Int, completionHandler: @escaping (Result<Note?, Error>) -> Void) {
//        notes.removeAll(where: {return $0.id == id})
        let request = Note.deleteNoteRequest(id)
        networkService.send(request) { result in
            var completionResult: Result<Note?, Error>
            defer {
                completionHandler(completionResult)
            }
            
            switch result {
            case .success(let data):
                print("Deleted note: \(data)")
                completionResult = .success(data)
            case.failure(let error):
                print(error)
                completionResult = .failure(error)
            }
        }
        
    }
}
