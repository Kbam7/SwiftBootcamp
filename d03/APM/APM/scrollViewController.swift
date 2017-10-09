//
//  scrollViewController.swift
//  APM
//
//  Created by Kyle BAMPING on 2017/10/08.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit

class scrollViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet weak var myScrollView: UIScrollView!
    var imageName : String!
	var image : UIImage!
    let imgView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view title
        self.title = imageName != "" ? imageName : self.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
    
    // This is called later than viewDidLoad()
    // Some view do not have their runtime values when viewDidLoad() is called
    // Use this function to get a bit more surety
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Display image view with selected image
        imgView.image = image
        imgView.contentMode = .topLeft
        //imgView.clipsToBounds = false
        
        // Setup frame for position and size
        imgView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        // Set ScrollView content size
        myScrollView.contentSize = imgView.bounds.size
        
        // Set scrollView delegate - for zooming
        myScrollView.delegate = self
        // Set image scaling properties
        setZoomScale()
        
        // Add image view
        myScrollView.addSubview(imgView)
    }
    
    func setZoomScale() {
        let imageViewSize = image.size
        let scrollViewSize = myScrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        myScrollView.minimumZoomScale = min(widthScale, heightScale)
        myScrollView.maximumZoomScale = 2.0
        myScrollView.zoomScale = 1.0
        
    }

}
