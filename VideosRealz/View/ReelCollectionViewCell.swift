//
//  ReelCollectionViewCell.swift
//  VideosRealz
//
//  Created by User on 24/08/2022.
//

import UIKit

class ReelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reelImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = 10
        self.layer.borderWidth   = 0.5
        self.layer.borderColor   = UIColor.gray.cgColor
    }

    func setCell(reel: Item){
        let imageUrl = URL(string: reel.snippet.thumbnails.standard.url)
        self.reelImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "ReelPlaceholder"))
        titleLabel.text = reel.snippet.title
    }
    
}
