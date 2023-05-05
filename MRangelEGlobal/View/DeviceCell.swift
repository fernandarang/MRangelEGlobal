//
//  DeviceCell.swift
//  MRangelEGlobal
//
//  Created by MacBookMBA5 on 28/04/23.
//

import UIKit

class DeviceCell: UITableViewCell {
    
    @IBOutlet weak var nombre: UILabel!
    

    @IBOutlet weak var identificador: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
