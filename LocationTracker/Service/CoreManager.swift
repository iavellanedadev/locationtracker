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
        
        locationTrack.fromDateTime = location.fromDateTime.toDate()
        locationTrack.address = location.address
        locationTrack.locationName = location.locationName
        locationTrack.longitude = location.longitude
        locationTrack.latitude = location.latitude
        print("saving the coredata")

        saveContext()
    }
    
    func updateData() {
        
        if let core = fetchLastData(), let fromDateTime = core.fromDateTime{
            let toDateTime = Date()

            let timeSpent = toDateTime.timeIntervalSince(fromDateTime).toString()
            
            core.setValue(toDateTime, forKey: "toDateTime")
            core.setValue(timeSpent, forKey: "timeSpent")
            print("updating to coredata")
            saveContext()
        }

    }
    
    func fetchLastData() -> LocationTrack? {
        let fetch = NSFetchRequest<LocationTrack>(entityName: "LocationTrack")
        let departmentSort = NSSortDescriptor(key: "fromDateTime", ascending: false)
        
        fetch.sortDescriptors = [departmentSort]
        
        do {
            let coreLocations = try context.fetch(fetch)
            print("we fetched corelocations!")
            return coreLocations.first
        } catch {
            print("Issue Fetching Last Location Record: \(error.localizedDescription)")
            return nil
        }
    }
    
    func loadLastRecord() -> Location? {
        
        var location: Location?
        
        if let core = fetchLastData() {
            guard let fromDateTime = core.fromDateTime, let longitude = core.longitude, let latitude = core.latitude, let address = core.address, let locationName = core.locationName, let toDateTime = core.toDateTime else { return location }
            
            location = Location(fromDateTime: fromDateTime.toString() ?? "N/A", latitude: latitude, longitude: longitude, address: address, locationName: locationName, toDateTime: toDateTime.toString() ?? "", timeSpent: core.timeSpent)
            print("it did stuff!")
            return location
        }
        
        return location
    }
    
    func loadData() -> [Location] {
        var locations = [Location]()
        
        let fetch = NSFetchRequest<LocationTrack>(entityName: "LocationTrack")
        
        do{
            let coreLocations = try context.fetch(fetch)
            
            for core in coreLocations{
            
                guard let fromDateTime = core.fromDateTime, let longitude = core.longitude, let latitude = core.latitude, let address = core.address, let locationName = core.locationName, let toDateTime = core.toDateTime else { return locations }
                
                let location = Location(fromDateTime: fromDateTime.toString() ?? "N/A", latitude: latitude, longitude: longitude, address: address, locationName: locationName, toDateTime: toDateTime.toString() ?? "", timeSpent: core.timeSpent)
                locations.append(location)
            }
            
        } catch {
            print("Could Not Fetch Tracks \(error.localizedDescription)")
        }

        return locations
    }
}
