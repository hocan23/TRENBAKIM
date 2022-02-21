//
//  CellTableViewCell.swift
//  tren
//
//  Created by Hasan onur Can on 14.02.2022.
//

import UIKit

class CellTableViewCell: UITableViewCell {
    @IBOutlet weak var lblKm: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTarih: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        img.layer.cornerRadius = 10

        // Configure the view for the selected state
    }
    
}
