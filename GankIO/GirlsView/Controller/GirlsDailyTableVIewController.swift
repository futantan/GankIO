//
//  GirlsDailyTableVIewController.swift
//  GankIO
//
//  Created by 河图。 on 16/3/10.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit

class GirlsDailyViewController: UIViewController
{
  @IBOutlet weak var girlsDailyTableView: UITableView! {
    didSet {
      girlsDailyTableView.delegate = self
      girlsDailyTableView.dataSource = self
    }
  }
  
  var model = GankModel() {
    didSet {
      model.delegate = self
    }
  }
  
  var girlsDailyDate = NSDate()
  
  private struct GirlsDailyViewNames {
    static let tableViewCellForImageXib = "GirlsDailyImageTableViewCell"
    static let tableViewCellForImage = "girlsDailyImage"
    static let tableViewCellForArticleXib = "GirlsDailyArticleTableViewCell"
    static let tableViewCellForArticle = "girlsDailyArticle"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    model = GankModel()
    model.getAlamofireFromDate(girlsDailyDate)
    
    girlsDailyTableView.registerNib(UINib(nibName: GirlsDailyViewNames.tableViewCellForImageXib, bundle: nil), forCellReuseIdentifier: GirlsDailyViewNames.tableViewCellForImage)
    girlsDailyTableView.registerNib(UINib(nibName: GirlsDailyViewNames.tableViewCellForArticleXib, bundle: nil), forCellReuseIdentifier: GirlsDailyViewNames.tableViewCellForArticle)
    
    setUpNavigationBar()
  }
  
  func setUpNavigationBar() {
    if let nc = self.navigationController {
      nc.navigationBar.alpha = 0
    }
  }
}

extension GirlsDailyViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCellWithIdentifier(GirlsDailyViewNames.tableViewCellForImage, forIndexPath: indexPath) as! GirlsDailyImageTableViewCell
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "yyyy.MM.dd"
      let url = model.gankDailysGirlImage.url
      cell.girlImageView.kf_setImageWithURL(NSURL(string: url)!)
      cell.girlImageView.contentMode = .ScaleAspectFill
      return cell
    default:
      let cell = tableView.dequeueReusableCellWithIdentifier(GirlsDailyViewNames.tableViewCellForArticle, forIndexPath: indexPath)
      return cell
    }
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return CGFloat(400)
    default:
      return CGFloat(60)
    }
  }
}

extension GirlsDailyViewController:UITableViewDelegate
{

}

extension GirlsDailyViewController: GankModelDelegate
{
  func gankModelDidGetAlamofire() {
    girlsDailyTableView.reloadData()
  }
}