//
//  ListSongsViewController.swift
//  SongsApp
//
//  Created by Avdeev Ilya Aleksandrovich on 13.01.2022.
//  Copyright © 2022 Avdeev Ilya Aleksandrovich. All rights reserved.
//

import UIKit
import Firebase

class ListSongsViewController: UIViewController {

    let idCell = "mailCell"
    public var model = SongsModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.tintColor = .black
        
        model.getSongs { (SongsInfo) in
            self.model.songs = SongsInfo
            self.tableView.reloadData()
        }
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
        let btnAddSong = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSong))
        navigationItem.rightBarButtonItem = btnAddSong
    }
     
    override func viewWillAppear(_ animated: Bool) {

    }
    
    @IBAction func moreBtnClick(_ sender: UIButton) {
        let index = tableView.indexPath(for: sender.superview?.superview as! UITableViewCell)?.row
        
        let alert = UIAlertController(title: "Song", message: nil, preferredStyle: .alert)
        
        let saveBtn = UIAlertAction(title: "Save", style: .default) { (action) in
            let nameSong = alert.textFields?[0].text
            let nameArtist = alert.textFields?[1].text
            
            self.model.songs[index!].songName = nameSong ?? "error"
            self.model.songs[index!].artistName = nameArtist ?? "error"
            
            self.model.updateSongs(docID: self.model.songs[index!].documentID, songInfo: self.model.songs[index!])
            
            self.model.getSongs { (SongsInfo) in
                self.model.songs = SongsInfo
                self.tableView.reloadData()
            }
        }
        
        let deleteBtn = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.model.deleteSong(songID: self.model.songs[index!].documentID )
            
            self.model.getSongs { (SongsInfo) in
                self.model.songs = SongsInfo
                self.tableView.reloadData()
            }
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (textField) in
            textField.text = self.model.songs[index!].songName
            textField.placeholder = "Name song"
        }
        
        alert.addTextField { (textField) in
            textField.text = self.model.songs[index!].artistName
            textField.placeholder = "Name artist"
        }
        
        alert.addAction(saveBtn)
        alert.addAction(deleteBtn)
        alert.addAction(cancelBtn)
        
        present(alert, animated: true, completion: nil)
    }
    

    
    
    @objc func addSong(){
        let alert = UIAlertController(title: "Add a new song", message: nil, preferredStyle: .alert)
        let addBtn = UIAlertAction(title: "Save", style: .default) { (action) in
            let nameSong = alert.textFields?[0].text
            let nameArtist = alert.textFields?[1].text

            self.model.addNewSong(songInfo: SongInfo(songName: nameSong ?? "", artistName: nameArtist ?? "", userID: Auth.auth().currentUser?.uid ?? "error" , lines: [SongLine(chords: "", text: nameSong ?? "Error", isHeader: true)], documentID: ""))
            self.model.getSongs { (SongsInfo) in
                self.model.songs = SongsInfo
                self.tableView.reloadData()
            }
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name song"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name artist"
        }
        
        alert.addAction(addBtn)
        alert.addAction(cancelBtn)
        present(alert, animated: true, completion: nil)
    }
}
extension ListSongsViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! ListSongsTableViewCell

        let song = model.songs[indexPath.row]
        cell.nameSongLabel.text = song.songName
        cell.nameArtistLabel.text = song.artistName
        cell.imageSongView.image = #imageLiteral(resourceName: "song")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //новый ViewController для текса
//        let newVC = self.storyboard?.instantiateViewController(identifier: "TextSongViewController") as! TextSongViewController
//        self.navigationController?.pushViewController(newVC, animated: true)
        indexRow = indexPath.row
    }

}
extension ListSongsViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}

