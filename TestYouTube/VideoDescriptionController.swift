//
//  VideoDescriptionController.swift
//  TestYouTube
//
//  Created by Ruslan on 20/03/2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import UIKit


class VideoDescritpionController: UIViewController {
    
    var getDescription = String()
    var getImage = UIImage()
    var titleVideo = String()
    var getVideoId = String()
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var imageVideo: UIImageView!
    
    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
        
    }
    
    
    override func viewDidLoad() {
      //  super.viewDidLoad()
        descriptionText.text = getDescription
        imageVideo.image = getImage
        navigationItem.title = titleVideo
    }
}
