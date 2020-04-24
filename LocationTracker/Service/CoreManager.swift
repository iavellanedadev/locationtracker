//
//  CoreManager.swift
//  LocationTracker
//
//  Created by Consultant on 4/24/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation
import CoreData

final class CoreManager {
    static let shared = CoreManager()
    
    private init(){}
    
    // MARK: - Core Data stack
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "LocationTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveData(_ location: Location) {
        guard let entity = NSEntityDescription.entity(forEntityName: "LocationTrack", in: context) else { return }
        let locationTrack = LocationTrack(entity: entity, insertInto: context)
        
        locationTrack.startTime = location.startTime
        locationTrack.longitude = location.longitude
        locationTrack.latitude = location.latitude
        locationTrack.date = location.date
        
        saveContext()
    }
    
    func loadData() -> [Location] {
        var locations = [Location]()
        
        let fetch = NSFetchRequest<LocationTrack>(entityName: "LocationTrack")
        
        do{
            let coreTracks = try context.fetch(fetch)
            
            for core in coreTracks{
            
                guard let startTime = core.startTime, let longitude = core.longitude, let latitude = core.latitude, let date = core.date else { return locations }
                
                let location = Location(startTime: startTime, latitude: latitude, longitude: longitude, date: date)
                locations.append(location)
            }
            
        }catch{
            print("Could Not Fetch Tracks \(error.localizedDescription)")
        }

        return locations
    }
}
