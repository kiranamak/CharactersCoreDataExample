//
//  Character+CoreDataProperties.swift
//  CharactersCoreDataExample
//
//  Created by Kiran Mak on 2/3/20.
//  Copyright © 2020 Kiran Mak. All rights reserved.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var book: Book?
    
    public var wrappedName: String {
        return name ?? "Unknown"
    }

}
