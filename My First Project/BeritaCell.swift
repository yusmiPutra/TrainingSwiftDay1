//
//  BeritaCell.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/25/23.
//

import UIKit

class BeritaCell: UITableViewCell {

    @IBOutlet weak var judulBerita: UILabel!
    @IBOutlet weak var imageBerita: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
