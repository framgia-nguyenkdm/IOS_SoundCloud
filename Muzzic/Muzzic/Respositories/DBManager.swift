//
//  DBManager.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/18/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit
import CoreData
class DBManager {
    class var sharedInstance: DBManager {
        struct Static {
            static let instance: DBManager = DBManager()
        }
        return Static.instance
    }

    func getManagedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }

    func isExistSong(songID: Int) -> NSManagedObject? {
        guard let managedObjectContext = getManagedObjectContext() else {
            return nil
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: UserProfile.songModel)
        do {
            let coreDataSongs = try managedObjectContext.fetch(fetchRequest)
            for item in coreDataSongs {
                let coreDataSongID = item.value(forKey: "songID") as? Int
                if coreDataSongID == songID {
                    return item
                }
            }
        } catch {
            return nil
        }
        return nil
    }

    func removeSong(songID: Int) {
        guard let managedObjectContext = getManagedObjectContext(), let existSong = isExistSong(songID: songID) else {
            return
        }
        managedObjectContext.delete(existSong)
        do {
            try managedObjectContext.save()
        } catch {
        }
    }
    func getArrSong() -> [Song] {
        var songs = [Song]()
        guard let managedObjectContext = getManagedObjectContext() else {
            return songs
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: UserProfile.songModel)
        do {
            let coreDataSongs = try managedObjectContext.fetch(fetchRequest)
            for item in coreDataSongs {
                let song = Song(songID: item.value(forKey: "songID") as? Int ?? 0,
                                name: item.value(forKey: "name") as? String ?? "",
                                downloadLink: "",
                                singer: item.value(forKey: "singer") as? String ?? "",
                                genre: "",
                                imageLink: item.value(forKey: "imagePath") as? String ?? "",
                                stream: item.value(forKey: "audioPath") as? String ?? "")
                songs.append(song)
            }
        } catch {
        }
        return songs
    }

    func insertSong(currentSong: Song,
                    imgPath: String,
                    songPath: String,
                    completion: @escaping(_ isInserted: Bool) -> Void) {
        guard let managedObjectContext = getManagedObjectContext() else {
            completion(false)
            return
        }
        let newSong = NSEntityDescription.insertNewObject(forEntityName: UserProfile.songModel,
                                                          into: managedObjectContext)

        newSong.setValue(currentSong.songID, forKey: "songID")
        newSong.setValue(currentSong.name, forKey: "name")
        newSong.setValue(currentSong.singer, forKey: "singer")
        newSong.setValue(songPath, forKey: "audioPath")
        newSong.setValue(imgPath, forKey: "imagePath")

        do {
            try managedObjectContext.save()
            completion(true)
        } catch let error {
            print("Could not save. Error: \(error.localizedDescription)")
            completion(false)
        }
    }
}
