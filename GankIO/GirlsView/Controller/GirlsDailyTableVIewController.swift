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
  
  private struct GirlsDailyViewNames {
    static let tableViewCellForImageXib = "GirlsDailyImageTableViewCell"
    static let tableViewCellForImage = "girlsDailyImage"
    static let tableViewCellForArticleXib = "GirlsDailyArticleTableViewCell"
    static let tableViewCellForArticle = "girlsDailyArticle"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    girlsDailyTableView.registerNib(UINib(nibName: GirlsDailyViewNames.tableViewCellForImageXib, bundle: nil), forCellReuseIdentifier: GirlsDailyViewNames.tableViewCellForImage)
    girlsDailyTableView.registerNib(UINib(nibName: GirlsDailyViewNames.tableViewCellForArticleXib, bundle: nil), forCellReuseIdentifier: GirlsDailyViewNames.tableViewCellForArticle)
  }
}

extension GirlsDailyViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

extension GirlsDailyViewController:UITableViewDelegate
{

}