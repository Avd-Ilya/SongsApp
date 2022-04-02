//
//  TextSongViewController.swift
//  SongsApp
//
//  Created by Avdeev Ilya Aleksandrovich on 13.01.2022.
//  Copyright © 2022 Avdeev Ilya Aleksandrovich. All rights reserved.
//

import UIKit
import Foundation

class TextSongViewController: UIViewController {

    let idCell = "textCell"
    public var model = SongsModel()
    var index = 0
    
    @IBOutlet weak var nameArtistLabel: UILabel!
    @IBOutlet weak var nameSongLabel: UILabel!
    @IBOutlet weak var tableTextView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableTextView.dataSource = self
        tableTextView.delegate = self
        
        model.getSongWithIndex { (SongInfo) in
            self.index = indexRow
            self.model.songs = SongInfo
            self.tableTextView.reloadData()
            self.nameSongLabel.text = self.model.songs[0].songName
            self.nameArtistLabel.text = self.model.songs[0].artistName
        }
        
        let btnAddLine = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddLine))
        navigationItem.rightBarButtonItem = btnAddLine

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if index != indexRow {
            model.getSongWithIndex { (SongInfo) in
                self.index = indexRow
                self.model.songs = SongInfo
                self.tableTextView.reloadData()
                self.nameSongLabel.text = self.model.songs[0].songName
                self.nameArtistLabel.text = self.model.songs[0].artistName
            }
        }
    }
    
    @objc func AddLine() {
        let alert = UIAlertController(title: "Add a new line", message: nil, preferredStyle: .alert)
        let addBtn = UIAlertAction(title: "Save", style: .default) { (action) in
            let chords = alert.textFields?[0].text
            let text = alert.textFields?[1].text

            let new = SongLine(chords: chords ?? "error", text: text ?? "error", isHeader: false)
            self.model.songs[0].lines.append(new)
            
            self.model.updateLines(docID: self.model.songs[0].documentID, line: self.model.songs[0].lines)
            
            self.model.getSongWithIndex { (SongInfo) in
                self.index = indexRow
                self.model.songs = SongInfo
                self.tableTextView.reloadData()
                self.nameSongLabel.text = self.model.songs[0].songName
                self.nameArtistLabel.text = self.model.songs[0].artistName
            }
        }
        
        let addHeader = UIAlertAction(title: "Add header", style: .default) { (action) in
            let chords = alert.textFields?[0].text
            let text = alert.textFields?[1].text
            
            let new = SongLine(chords: chords ?? "error", text: text ?? "error", isHeader: true)
            self.model.songs[0].lines.append(new)
            
            self.model.updateLines(docID: self.model.songs[0].documentID, line: self.model.songs[0].lines)

            self.model.getSongWithIndex { (SongInfo) in
                self.index = indexRow
                self.model.songs = SongInfo
                self.tableTextView.reloadData()
                self.nameSongLabel.text = self.model.songs[0].songName
                self.nameArtistLabel.text = self.model.songs[0].artistName
            }
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Chords"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Text"
        }
        
        alert.addAction(addBtn)
        alert.addAction(cancelBtn)
        alert.addAction(addHeader)
        present(alert, animated: true, completion: nil)
    }


}

extension TextSongViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !model.songs.isEmpty {
            return model.songs[0].lines.count
        } else {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextSongsTableViewCell

        let song = model.songs[0].lines[indexPath.row]
        cell.chordsSongLabel.text = song.chords
        cell.textSongLabel.text = song.text
        
//        if song.isHeader {
//            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)]
//            cell.chordsSongLabel.attributedText = NSMutableAttributedString(string: cell.chordsSongLabel.text ?? "", attributes:attrs)
//            cell.textSongLabel.attributedText = NSMutableAttributedString(string: cell.textSongLabel.text ?? "", attributes:attrs)
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//60.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let line = model.songs[0].lines[indexPath.row]
        let alert = UIAlertController(title: "Edit line", message: nil, preferredStyle: .alert)
        
        let updateBtn = UIAlertAction(title: "Update", style: .default) { (action) in
            let chords = alert.textFields?[0].text
            let text = alert.textFields?[1].text
            
            self.model.songs[0].lines[indexPath.row].chords = chords ?? "error"
            self.model.songs[0].lines[indexPath.row].text = text ?? "error"
            
            self.model.updateLines(docID: self.model.songs[0].documentID, line: self.model.songs[0].lines)
            
            self.model.getSongWithIndex { (SongInfo) in
                self.index = indexRow
                self.model.songs = SongInfo
                self.tableTextView.reloadData()
                self.nameSongLabel.text = self.model.songs[0].songName
                self.nameArtistLabel.text = self.model.songs[0].artistName
            }
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let addHeader = UIAlertAction(title: "Add header", style: .default) { (action) in
            let chords = alert.textFields?[0].text
            let text = alert.textFields?[1].text
            
            self.model.songs[0].lines[indexPath.row].chords = chords ?? "error"
            self.model.songs[0].lines[indexPath.row].text = text ?? "error"
            self.model.songs[0].lines[indexPath.row].isHeader = true

            self.model.updateLines(docID: self.model.songs[0].documentID, line: self.model.songs[0].lines)
            
            self.model.getSongWithIndex { (SongInfo) in
                self.index = indexRow
                self.model.songs = SongInfo
                self.tableTextView.reloadData()
                self.nameSongLabel.text = self.model.songs[0].songName
                self.nameArtistLabel.text = self.model.songs[0].artistName
            }

        }
        
        let deleteBtn = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.model.songs[0].lines.remove(at: indexPath.row)
            self.model.updateLines(docID: self.model.songs[0].documentID, line: self.model.songs[0].lines)
    
            self.model.getSongWithIndex { (SongInfo) in
                self.index = indexRow
                self.model.songs = SongInfo
                self.tableTextView.reloadData()
                self.nameSongLabel.text = self.model.songs[0].songName
                self.nameArtistLabel.text = self.model.songs[0].artistName
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Chords"
            textField.text = line.chords
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Text"
            textField.text = line.text
        }
        
        alert.addAction(updateBtn)
        alert.addAction(cancelBtn)
        alert.addAction(addHeader)
        alert.addAction(deleteBtn)
        present(alert, animated: true, completion: nil)
    }
    
}
