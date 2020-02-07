//
//  Book+CoreDataProperties.swift
//  CharactersCoreDataExample
//
//  Created by Kiran Mak on 2/3/20.
//  Copyright © 2020 Kiran Mak. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var name: String?
    @NSManaged public var characters: NSObject?
    @NSManaged public var character: NSSet?

    
    public var wrappedName: String {
        return name ?? "Unknown"
    }
    public var characterArray: [Character] {
        let set = character as? Set<Character> ?? []
        return set.sorted {
            $0.wrappedName<$1.wrappedName
        }
    }
}

// MARK: Generated accessors for character
extension Book {

    @objc(addCharacterObject:)
    @NSManaged public func addToCharacter(_ value: Character)

    @objc(removeCharacterObject:)
    @NSManaged public func removeFromCharacter(_ value: Character)

    @objc(addCharacter:)
    @NSManaged public func addToCharacter(_ values: NSSet)

    @objc(removeCharacter:)
    @NSManaged public func removeFromCharacter(_ values: NSSet)

}
