//
//  ContentView.swift
//  CharactersCoreDataExample
//
//  Created by Kiran Mak on 2/3/20.
//  Copyright © 2020 Kiran Mak. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(entity: Character.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Character.name, ascending: true)]/*, predicate: NSPredicate(format: "book.name = %@", "book 1")*/) var characters: FetchedResults<Character>
    @Environment(\.managedObjectContext) var moc
    let possibleCharacters = ["Frodo": "Lord of the Rings", "Gollum": "Lord of the Rings", "Gandalf": "Lord of the Rings", "Gimli": "Lord of the Rings", "Lupin": "Harry Potter", "McGonagall": "Harry Potter", "Doby": "Harry Potter", "Luna": "Harry Potter" ]
    
    var body: some View {
        VStack {
            HStack {
                EditButton()
                    .padding()
                Spacer()
            }
            List {
                ForEach(characters, id: \.id) { character in
                    HStack {
                        Text(character.name ?? "Unknown")
                            .foregroundColor(.green)
                        Text(character.book?.name ?? "Unknown")
                            .foregroundColor(.purple)
                    }
                }
                .onDelete(perform: self.deleteCharacter)
            }
            
            Button (action: {
                let possibleChars:[String] = Array(self.possibleCharacters.keys)
                let randomName = possibleChars[Int.random(in: 0..<possibleChars.count)]
                let character = Character(context: self.moc)
                character.name = randomName
                character.book = Book(context: self.moc)
                character.book?.name = self.possibleCharacters[randomName]
                character.id = UUID()
                
                //try? self.moc.save()
            }) {
                Text("Add")
                    .foregroundColor(.blue)
            }
            
            Button (action: {
                if self.moc.hasChanges {
                    do {
                        try self.moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }) {
                Text("Save")
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
    }
    
    func deleteCharacter(at offsets: IndexSet) {
        for offset in offsets {
            let character = characters[offset]
            
            moc.delete(character)
        }
        
        try? moc.save()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
