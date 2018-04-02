//
//  VideoDescriptionController.swift
//  TestYouTube
//
//  Created by Ruslan on 20/03/2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import UIKit

class VideoDescritpionController: UIViewController {
    
    var getDescription =  String()
    var getImage = UIImage()
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var imageVideo: UIImageView!
    
    
    override func viewDidLoad() {
      //  super.viewDidLoad()
        descriptionText.text = getDescription
        imageVideo.image = getImage
    }
    
}
