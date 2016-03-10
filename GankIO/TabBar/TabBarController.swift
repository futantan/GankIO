//
//  NavigationControllerViewController.swift
//  GankIO
//
//  Created by 河图。 on 16/3/6.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController
{
  private struct ChildViewNames {
    static let girlsView = "Girls"
    static let iOSView = "IOS"
    static let androidView = "Android"
    static let frontEndView = "FrontEnd"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setAllChildViews()
    self.tabBar.barTintColor = UIColor(red:0.29, green:0.35, blue:0.5, alpha:1)
    self.tabBar.tintColor = UIColor.whiteColor()
  }
  
  func setAllChildViews() {
    let girlsViewController = loadViewControllerFromStoryboard(ChildViewNames.girlsView)
    girlsViewController!.tabBarItem.title = "福利"
    girlsViewController!.tabBarItem.image = UIImage(named: "bra")
    self.addChildViewController(girlsViewController!)
    
    let iOSViewController = loadViewControllerFromStoryboard(ChildViewNames.iOSView) as! UINavigationController
    iOSViewController.tabBarItem.title = "iOS"
    iOSViewController.tabBarItem.image = UIImage(named: "apple")
    self.addChildViewController(iOSViewController)
    
    let androidViewController = loadViewControllerFromStoryboard(ChildViewNames.androidView)
    androidViewController!.tabBarItem.title = "Android"
    androidViewController!.tabBarItem.image = UIImage(named: "android")
    self.addChildViewController(androidViewController!)
    
    let frontEndViewController = loadViewControllerFromStoryboard(ChildViewNames.frontEndView)
    frontEndViewController!.tabBarItem.title = "前端"
    frontEndViewController!.tabBarItem.image = UIImage(named: "frontEnd")
    self.addChildViewController(frontEndViewController!)
  }
  
  func setAllTabBarItems() {
    
  }
  
  func loadViewControllerFromStoryboard(name: String) -> UIViewController? {
    let storyboard = UIStoryboard(name: name, bundle: nil)
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
