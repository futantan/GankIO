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
  }
  
  func setAllChildViews() {
    let girlsViewController = loadViewControllerFromStoryboard(ChildViewNames.girlsView)
    girlsViewController!.tabBarItem.title = "妹子"
    self.addChildViewController(girlsViewController!)
    
    let iOSViewController = loadViewControllerFromStoryboard(ChildViewNames.iOSView)
    iOSViewController!.tabBarItem.title = "iOS"
    self.addChildViewController(iOSViewController!)
    
    let androidViewController = loadViewControllerFromStoryboard(ChildViewNames.androidView)
    androidViewController!.tabBarItem.title = "Android"
    self.addChildViewController(androidViewController!)
    
    let frontEndViewController = loadViewControllerFromStoryboard(ChildViewNames.frontEndView)
    frontEndViewController!.tabBarItem.title = "前端"
    self.addChildViewController(frontEndViewController!)
  }
  
  func setAllTabBarItems() {
    
  }
  
  func loadViewControllerFromStoryboard(name: String) -> UIViewController? {
    let storyboard = UIStoryboard(name: name, bundle: nil)
    let controller = storyboard.instantiateInitialViewController()
    return controller
  }
}
