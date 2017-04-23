//
//  ViewController.swift
//  BWPhotoPicker
//
//  Created by qkrqjadn on 04/23/2017.
//  Copyright (c) 2017 qkrqjadn. All rights reserved.
//

import UIKit
import Photos


class ViewController: UIViewController {
    
    
    let imgView = UIImageView()
    
    
    lazy var photoButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진으로 이동", for: .normal)
        button.setTitleColor(.black,for: .normal)
        button.addTarget(self, action: #selector(movePhoto), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(photoButton)
        view.addSubview(imgView)
        
        photoButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(imgView.snp.width)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func movecamera(){
        let croppingEnabled = true
        let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled) { [weak self] image, asset in
            // Do something with your image here.
            // If cropping is enabled this image will be the cropped version
            
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(cameraViewController, animated: true, completion: nil)
    }
    func movePhoto2(){
        let croppingEnabled = true
        
        /// Provides an image picker wrapped inside a UINavigationController instance
        let imagePickerViewController = CameraViewController.imagePickerViewController(croppingEnabled: croppingEnabled) { [weak self] image, asset in
            self?.imgView.image = image
            
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    func movePhoto(){
        self.navigationController?.pushViewController(PhotoViewController(), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



