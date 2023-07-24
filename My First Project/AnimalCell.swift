//
//  AnimalCell.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/24/23.
//

import UIKit

class AnimalCell: UITableViewCell {

    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var jenisHewan: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
