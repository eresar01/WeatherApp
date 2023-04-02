//
//  WeatherCoreDataManager.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import Foundation
import CoreData

// MARK: - Protocol

protocol WeatherCoreDataProtocol {
    func save(_ model: WeatherPageModel)
    func getWeathers() -> [WeaterItem]
    func getWeather(name: String) -> WeaterItem?
    func eraseData()
    func saveData()
}

class WeatherCoreDataManager {
    
    static let shared = WeatherCoreDataManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// MARK: WeatherCoreDataProtocol

extension WeatherCoreDataManager: WeatherCoreDataProtocol {
    
    //MARK: Save data in DB
    
    func save(_ model: WeatherPageModel) {
        let item = WeaterItem(context: context)
        item.name = model.cityName
        item.type = model.weatherType.title
        item.temp = Int16(model.temperature)
        saveData()
    }
    
    func saveData() {
        try? context.save()
    }
    
    //MARK: Get data
    
    func getWeathers() -> [WeaterItem] {
        let request: NSFetchRequest<WeaterItem> = WeaterItem.fetchRequest()
        let item = try? context.fetch(request)
        return item ?? []
    }
    
    func getWeather(name: String) -> WeaterItem? {
        let request: NSFetchRequest<WeaterItem> = WeaterItem.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        let item = try? context.fetch(request).first
        return item ?? nil
    }
    
    //MARK: Erase data
    
    func eraseData() {
        let requestToDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "WeaterItem")
        let batchDelete = NSBatchDeleteRequest(fetchRequest: requestToDelete)
        do {
            try context.execute(batchDelete)
            try context.save()
        } catch {
            saveContext()
        }
    }
}
 
