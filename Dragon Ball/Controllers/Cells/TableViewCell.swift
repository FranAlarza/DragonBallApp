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
    
    func setDataCell(model: Hero){
        labelName.text = model.name
        descriptionLabel.text = model.description
        characterImage.downloadImage(from: model.photo)
        
    }
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
        self.layer.cornerRadius = (frame.size.width - 300) / 2
        self.clipsToBounds = true
    }
        
    
}
