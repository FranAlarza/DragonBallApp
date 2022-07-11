//
//  TableViewCell.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 7/7/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataCell(image: String, name: String, description: String){
        characterImage.image = UIImage(named: image)
        labelName.text = name
        descriptionLabel.text = description
    }
        
    
}
