//
//  ArticlesDB+CoreDataProperties.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 07.08.2022.
//
//

import Foundation
import CoreData
import UIKit


extension ArticlesDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticlesDB> {
        return NSFetchRequest<ArticlesDB>(entityName: "ArticlesDB")
    }

    @NSManaged public var additionDate: Date?
    @NSManaged public var articleDescription: String?
    @NSManaged public var articleTitle: String?
    @NSManaged public var id: UUID?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var savedImage: Data?
    
    static var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    func delete() throws {
        Self.viewContext.delete(self)
        try Self.viewContext.save()
    }
}

extension ArticlesDB : Identifiable {

}
