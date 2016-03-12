//
//  NavigationControllerViewController.swift
//  GankIO
//
//  Created by 河图。 on 16/3/6.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  private enum ChildViewName: String {
    case GirlsView = "Girls"
    case iOSView = "IOS"
    case AndroidView = "Android"
    case FrontEndView = "FrontEnd"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setAllChildViews()
    self.tabBar.barTintColor = UIColor(red:0.29, green:0.35, blue:0.5, alpha:1)
    self.tabBar.tintColor = UIColor.whiteColor()
  }
  
  func setAllChildViews() {
    addChildViewControllerFromStoryboradWithName(.GirlsView, title: "福利", imageName: "bra")
    addChildViewControllerFromStoryboradWithName(.iOSView, title: "iOS", imageName: "apple")
    addChildViewControllerFromStoryboradWithName(.AndroidView, title: "Android", imageName: "android")
    addChildViewControllerFromStoryboradWithName(.FrontEndView, title: "前端", imageName: "frontEnd")
  }
  
  private func addChildViewControllerFromStoryboradWithName(name: ChildViewName, title: String, imageName: String) {
    let vc = loadViewControllerFromStoryboard(name)
    vc!.tabBarItem.title = title
    vc!.tabBarItem.image = UIImage(named: imageName)
    self.addChildViewController(vc!)
  }
  
  private func loadViewControllerFromStoryboard(name: ChildViewName) -> UIViewController? {
    let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
    let controller = storyboard.instantiateInitialViewController()
    return controller
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  override func childViewControllerForStatusBarStyle() -> UIViewController? {
    return nil
  }
}
