//
//  GirlImageDetailView.swift
//  GankIO
//
//  Created by 河图。 on 16/3/10.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit
import Kingfisher

class GirlImageDetailViewController: UIViewController {
  @IBOutlet var scrollView: UIScrollView! {
    didSet {
      scrollView.delegate = self
      scrollView.maximumZoomScale = 1
    }
  }
  
  var imageURL = NSURL()
  
  var girlImageView = UIImageView()
  
  override func viewDidLoad() {
    self.navigationController!.navigationBar.alpha = 0
    setUpImageView()
  }
  
  override func viewDidAppear(animated: Bool) {
    self.navigationController!.navigationBar.alpha = 0
  }
  
  func setUpImageView() {
    girlImageView.kf_setImageWithURL(imageURL)
    girlImageView.sizeToFit()
    scrollView.contentSize = girlImageView.frame.size
    scrollView.contentOffset = CGPoint(x: 0, y: 20)
    scrollView.minimumZoomScale = minScale()
    scrollView.addSubview(girlImageView)
  }
  
  func minScale() -> CGFloat {
    let heightScale = scrollView.bounds.height / girlImageView.image!.size.height
    let widthScale = scrollView.bounds.width / girlImageView.image!.size.width
    return min(heightScale, widthScale)
  }
}

extension GirlImageDetailViewController: UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return girlImageView
  }
}