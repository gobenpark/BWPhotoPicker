//
//  BWPhotoCell.swift
//  Pods
//
//  Created by 박범우 on 2017. 4. 23..
//
//

import UIKit

public class PhotoViewCell: UICollectionViewCell{
    
    static let ID = "PhotoViewCell"
    
    var livePhotoBadgeImageView: UIImageView = UIImageView()
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var representedAssetIdentifier: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(livePhotoBadgeImageView)
        self.layer.borderWidth = 0.5
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
