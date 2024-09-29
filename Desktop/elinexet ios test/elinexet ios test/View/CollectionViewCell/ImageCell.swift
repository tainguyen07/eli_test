//
//  ImageCell.swift
//  elinexet ios test
//
//  Created by Tai Nguyen on 28/9/24.
//

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        imageView.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground, .scaleDownLargeImages])
    }
}
