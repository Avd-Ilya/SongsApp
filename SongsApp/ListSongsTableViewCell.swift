//
//  ListSongsTableViewCell.swift
//  SongsApp
//
//  Created by Avdeev Ilya Aleksandrovich on 13.01.2022.
//  Copyright © 2022 Avdeev Ilya Aleksandrovich. All rights reserved.
//

import UIKit

class ListSongsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSongView: UIImageView!
    @IBOutlet weak var nameSongLabel: UILabel!
    @IBOutlet weak var nameArtistLabel: UILabel!
    @IBOutlet weak var cellLikeBtn: UIButton!
    @IBOutlet weak var cellAddBtn: UIButton!
    @IBOutlet weak var cellMoreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func cellLikeBtnClick(_ sender: Any) {
        if cellLikeBtn.tag == 0 {
            cellLikeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cellLikeBtn.tag = 1
        } else {
            cellLikeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            cellLikeBtn.tag = 0
        }
    }
    @IBAction func cellAddBtnClick(_ sender: Any) {
    }
    @IBAction func cellMoreAction(_ sender: Any) {
    }
    
}
