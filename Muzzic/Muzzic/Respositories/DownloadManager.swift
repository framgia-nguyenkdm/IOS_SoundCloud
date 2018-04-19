//
//  DownloadManager.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/18/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
enum DownloadState: String {
    case error
    case complete
    case existFile
}
class DownloadManager {
    static let sharedInstance = DownloadManager()

    func deleteData(name: String) {
        let audio = name + ".mp3"
        let image = name + ".jpg"

        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let audioPath = documentDirectoryURL?.appendingPathComponent(audio),
            let imagePath = documentDirectoryURL?.appendingPathComponent(image) {
            print(imagePath)
            do {
                try FileManager.default.removeItem(at: audioPath)
                try FileManager.default.removeItem(at: imagePath)
                print("Complete delete")
            } catch let error {
                print("Ooops cannot delete file! Something went wrong: \(error)")
            }
        }
    }

    func downloadDataFrom(url: String,
                          fileName: String,
                          isImg: Bool,
                          completion: @escaping (_ imgPath: String, _ state: DownloadState) -> Void) {
        var dataName = ""
        var newURL = url

        if isImg {
            dataName = fileName + ".jpg"
        } else {
            dataName = fileName + ".mp3"
            newURL = url + "?client_id=\(UserProfile.myClientID)"
        }
        if let dataURL = URL(string: newURL) {
            //Create document folder url
            let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

            var state = DownloadState.error
            if let destinationURL = documentDirectoryURL?.appendingPathComponent(dataName) {

                 if FileManager.default.fileExists(atPath: destinationURL.path) {
                    print("File already exist")
                    print(destinationURL.path)
                    state = DownloadState.existFile
                    completion("", state)

                } else {
                    URLSession.shared.downloadTask(with: dataURL, completionHandler: { (location, _, error) in
                        guard let location = location, error == nil else { return }

                        do {
                            // after downloading move it to destination URL
                            try FileManager.default.moveItem(at: location, to: destinationURL)
                            state = DownloadState.complete
                            completion(destinationURL.path, state)
                        } catch let error {
                            state = DownloadState.error
                            completion(destinationURL.path, state)
                            print(error.localizedDescription)
                        }
                    }).resume()
                }
            }
        }
    }
    func downLoadAllData(imgURL: String,
                         audioURL: String,
                         fileName: String,
                         completion: @escaping (_ imgPath: String, _ mPath: String, _ state: DownloadState) -> Void) {
        downloadDataFrom(url: imgURL,
                         fileName: fileName,
                         isImg: true) { (imgPath, state) in
                            switch state {
                            case .complete:
                                self.downloadDataFrom(url: audioURL, fileName: fileName, isImg: false,
                                                      completion: { (audioPath, state) in
                                                        if state == DownloadState.complete {
                                                            print("Path: \(imgPath) ---- \(audioPath)")
                                                            completion(imgPath, audioPath, state)
                                                        } else {
                                                            completion("", "", state)
                                                        }
                                })
                            case .existFile:
                                completion("", "", state)
                            case .error:
                                completion("", "", state)
                            }
        }
    }
}
