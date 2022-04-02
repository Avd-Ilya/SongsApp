//
//  Songs.swift
//  SongsApp
//
//  Created by Avdeev Ilya Aleksandrovich on 13.01.2022.
//  Copyright © 2022 Avdeev Ilya Aleksandrovich. All rights reserved.
//

import Foundation
import FirebaseFirestore


let db = Firestore.firestore()

struct SongLine {
    var chords: String
    var text: String
    var isHeader: Bool
}

struct SongInfo {
    var songName: String
    var artistName: String
    var userID: String
    var lines: [SongLine]
    var documentID: String
}

public var indexRow = 0

class SongsModel {
    var songs = [SongInfo]()
    
    func deleteSong(songID: String) {
        db.collection("songs").document(songID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func getSongs(completion: @escaping ([SongInfo]) -> Void){
        var new = [SongInfo]()
        let docRef = db.collection("songs")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let docID = document.documentID
                    let songLines = document.data()["lines"] as! [String:[String:Any]]
                    let songName = document.data()["songName"] as! String
                    let artistName = document.data()["artistName"] as! String
                    let userID = document.data()["userID"] as! String
                    var s = [SongLine]()

                    for i in 0..<songLines.count{
                        let chords = songLines[String(i)]?["chords"] as! String
                        let text = songLines[String(i)]?["text"] as! String
                        let isHeader = songLines[String(i)]?["isHeader"] as! Bool
                        s.append(SongLine(chords: chords, text: text, isHeader: isHeader))
                    }
                    new.append(SongInfo(songName: songName, artistName: artistName, userID: userID, lines: s, documentID: docID))
                }
                completion(new)
            }
        }
    }
    
    func getSongWithIndex(completion: @escaping ([SongInfo]) -> Void){
        var new = [SongInfo]()
        var i = 0
        let docRef = db.collection("songs")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if i == indexRow {
                        let docID = document.documentID
                        let songLines = document.data()["lines"] as! [String:[String:Any]]
                        let songName = document.data()["songName"] as! String
                        let artistName = document.data()["artistName"] as! String
                        let userID = document.data()["userID"] as! String
                        var s = [SongLine]()

                        for i in 0..<songLines.count{
                            let chords = songLines[String(i)]?["chords"] as! String
                            let text = songLines[String(i)]?["text"] as! String
                            let isHeader = songLines[String(i)]?["isHeader"] as! Bool
                            s.append(SongLine(chords: chords, text: text, isHeader: isHeader))
                        }
                        new.append(SongInfo(songName: songName, artistName: artistName, userID: userID, lines: s, documentID: docID))
                        
                    }
                    i += 1
                }
                completion(new)
            }
        }
    }
    
    func addNewSong(songInfo: SongInfo) {
        let newSongRef = db.collection("songs").document()
        var songLinesDic = [String:[String:Any]]()
        for i in 0..<songInfo.lines.count{
            songLinesDic[String(i)] = ["chords":songInfo.lines[i].chords, "text":songInfo.lines[i].text, "isHeader":songInfo.lines[i].isHeader]
        }
        
        newSongRef.setData([
            "songName":songInfo.songName,
            "artistName":songInfo.artistName,
            "userID":songInfo.userID,
            "lines":songLinesDic
        ])
    }
    
    func updateLines(docID: String, line: [SongLine]) {
        let SongRef = db.collection("songs").document(docID)
        var songLinesDic = [String:[String:Any]]()
        for i in 0..<line.count{
            songLinesDic[String(i)] = ["chords":line[i].chords, "text":line[i].text, "isHeader":line[i].isHeader]
        }

        SongRef.updateData([
            "lines":songLinesDic
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
            
        }
    }
    
    func updateSongs(docID: String, songInfo: SongInfo ) {
        let SongRef = db.collection("songs").document(docID)
        
        var songLinesDic = [String:[String:Any]]()
        for i in 0..<songInfo.lines.count{
            songLinesDic[String(i)] = ["chords":songInfo.lines[i].chords, "text":songInfo.lines[i].text, "isHeader":songInfo.lines[i].isHeader]
        }
        
        SongRef.setData([
            "songName":songInfo.songName,
            "artistName":songInfo.artistName,
            "userID":songInfo.userID,
            "lines":songLinesDic
        ])
    }

}

