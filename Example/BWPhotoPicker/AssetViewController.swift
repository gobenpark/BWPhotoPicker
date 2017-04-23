//
//  AssetViewController.swift
//  sample
//
//  Created by 박범우 on 2017. 4. 23..
//  Copyright © 2017년 bumwoo. All rights reserved.
//

import UIKit
import Photos
import PhotosUI


@available(iOS 9.1, *)
class AssetViewController: UIViewController{
    
    var asset: PHAsset!
    var assetCollection: PHAssetCollection!
    
    var imageView = UIImageView()
    var livePhotoView = PHLivePhotoView()
    var isPlayingHint = false
    
    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: imageView.bounds.width * scale,
                      height: imageView.bounds.height * scale)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(livePhotoView)
        
        
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        livePhotoView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        livePhotoView.delegate = self
        
        // Make sure the view layout happens before requesting an image sized to fit the view.
        view.layoutIfNeeded()
        updateImage()

    }
    
    func updateImage() {
        if asset.mediaSubtypes.contains(.photoLive) {
            updateLivePhoto()
        } else {
            updateStaticImage()
        }
    }
    
    func updateLivePhoto() {
        // Prepare the options to pass when fetching the live photo.
        let options = PHLivePhotoRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        
        // Request the live photo for the asset from the default PHImageManager.
        PHImageManager.default().requestLivePhoto(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { livePhoto, info in
            // Hide the progress view now the request has completed.
            
            // If successful, show the live photo view and display the live photo.
            guard let livePhoto = livePhoto else { return }
            
            // Now that we have the Live Photo, show it.
            self.imageView.isHidden = true
            self.livePhotoView.isHidden = false
            self.livePhotoView.livePhoto = livePhoto
            
            if !self.isPlayingHint {
                // Playback a short section of the live photo; similar to the Photos share sheet.
                self.isPlayingHint = true
                self.livePhotoView.startPlayback(with: .hint)
            }
            
        })
    }
    
    func updateStaticImage() {
        // Prepare the options to pass when fetching the (photo, or video preview) image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
     
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { image, _ in
            // Hide the progress view now the request has completed.
            
            // If successful, show the image view and display the image.
            guard let image = image else { return }
            
            // Now that we have the image, show it.
            self.livePhotoView.isHidden = true
            self.imageView.isHidden = false
            self.imageView.image = image
        })
    }
}

extension AssetViewController: PHLivePhotoViewDelegate {
    func livePhotoView(_ livePhotoView: PHLivePhotoView, willBeginPlaybackWith playbackStyle: PHLivePhotoViewPlaybackStyle) {
        isPlayingHint = (playbackStyle == .hint)
    }
    
    func livePhotoView(_ livePhotoView: PHLivePhotoView, didEndPlaybackWith playbackStyle: PHLivePhotoViewPlaybackStyle) {
        isPlayingHint = (playbackStyle == .hint)
    }
}
