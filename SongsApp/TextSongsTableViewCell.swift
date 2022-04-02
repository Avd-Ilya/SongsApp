//
//  TextSongsTableViewCell.swift
//  SongsApp
//
//  Created by Avdeev Ilya Aleksandrovich on 15.01.2022.
//  Copyright © 2022 Avdeev Ilya Aleksandrovich. All rights reserved.
//

import UIKit

class TextSongsTableViewCell: UITableViewCell {


    @IBOutlet weak var chordsSongLabel: UILabel!
    @IBOutlet weak var textSongLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
