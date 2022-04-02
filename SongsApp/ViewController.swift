//
//  ViewController.swift
//  SongsApp
//
//  Created by Avdeev Ilya Aleksandrovich on 10.01.2022.
//  Copyright © 2022 Avdeev Ilya Aleksandrovich. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //чтение документов
//        db.collection("songs").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
//
//        let docRef = db.collection("songs").document("9F4alEEcKRkw036hJENN")
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
        
        //удаление документа
//        db.collection("songs").document("fTcKDzcvxuKSADZBkTpi").delete() { err in
//            if let err = err {
//                print("Error removing document: \(err)")
//            } else {
//                print("Document successfully removed!")
//            }
//        }
        
        
        //добавление документа
//        let newDocRef = db.collection("songs").document()
//
//        newDocRef.setData(["artistName":"testName", "lines":["0":["isHeader":false, "text":"testText", "chords":"testChords"]], "songName":"testSongName", "userID":"testUserID"]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
        
        //обновление данных
//        let updateDocRef = db.collection("songs").document("9kINOw1Aj2T6KrTANvhX")
//
//        updateDocRef.updateData(["lines":["0":["chords":"newChords", "isHeader":false, "text":"testText"], "1":["chords":"newChords", "isHeader":false, "text":"testText"], "2":["chords":"newChords", "isHeader":false, "text":"testText"]]]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//
//        }
 
    }
}

