//
//  PairController.swift
//  Pair
//
//  Created by Chris Gottfredson on 4/10/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import Foundation

class PairController {
    
    //MARK: - Shared Instance and Properties
    
    static let shared = PairController()
    
    var names: [String] = [] {
        didSet {
            pairs = names.chunked(into: 2)
        }
    }
    
    var pairs: [[String]] = [[]]
    
    func shuffleAndRandomize() {
        names = names.shuffled()
        pairs = names.chunked(into: 2)
        saveNamesToPersistentStore()
    }
    
    func removeName() {
        
    }
    
    //MARK: - Persistence
    
    private func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "pair.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    
    func saveNamesToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(names)
            try data.write(to: fileURL())
        } catch {
            print("Error with \(#function) : \(error.localizedDescription) : --> \(error)")
        }
    }
    
    func loadNamesFromPersistentStore() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let names = try decoder.decode([String].self, from: data)
            self.names = names
        } catch {
            print("Error with \(#function) : \(error.localizedDescription) : --> \(error)")

        }
    }
    
}
