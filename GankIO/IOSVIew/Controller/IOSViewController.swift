//
//  IOSViewController.swift
//  GankIO
//
//  Created by 河图。 on 16/3/6.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit

class IOSViewController: UIViewController
{
  @IBOutlet weak var iOSTableView: UITableView! {
    didSet {
      iOSTableView.delegate = self
      iOSTableView.dataSource = self
    }
  }
  
  var model = GankModel() {
    didSet {
      model.delegate = self
    }
  }
  
  override func viewDidLoad() {
    <#code#>
  }
}

extension IOSViewController: UITableViewDelegate
{
  
}

extension IOSViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

extension IOSViewController: GankModelDelegate {
  func gankModelDidGetAlamofire() {
    iOSTableView.reloadData()
  }
}