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
    static let showGirlImageDetailViewSegueIdentifier = "showGirlImageDetailView"
  }
  
  struct CellGroups {
     var girl = 0
     var iOS = 0
     var Android = 0
     var frontEnd = 0
     var recommend = 0
     var resource = 0
     var vedio = 0
  }
  
  var cellGroups = CellGroups()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    model = GankModel()
    model.getAlamofireFromDate(girlsDailyDate)
    
    girlsDailyTableView.registerNib(UINib(nibName: GirlsDailyViewNames.tableViewCellForImageXib, bundle: nil), forCellReuseIdentifier: GirlsDailyViewNames.tableViewCellForImage)
    girlsDailyTableView.registerNib(UINib(nibName: GirlsDailyViewNames.tableViewCellForArticleXib, bundle: nil), forCellReuseIdentifier: GirlsDailyViewNames.tableViewCellForArticle)
    
    setUpNavigationBar()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(true)
    self.navigationController!.navigationBar.alpha = 1
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    self.navigationController!.navigationBar.alpha = 0
  }
  
  func setUpNavigationBar() {
    self.title = "每日干货"
    if let nc = self.navigationController {
      nc.navigationBar.alpha = 0
      nc.navigationBar.tintColor = UIColor.whiteColor()
    }
  }
  
  func countCellGroups() {
    cellGroups.iOS = model.gankDailysIOS.count
    cellGroups.Android = model.gankDailysAndroid.count + cellGroups.iOS
    cellGroups.frontEnd = model.gankDailysFrontEnd.count + cellGroups.Android
    cellGroups.recommend = model.gankDailysBlindlyRecommend.count + cellGroups.frontEnd
    cellGroups.resource = model.gankDailysExpandResource.count + cellGroups.recommend
    cellGroups.vedio = 1 + cellGroups.resource
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifier = segue.identifier {
      switch identifier {
      case GirlsDailyViewNames.showGirlImageDetailViewSegueIdentifier:
        let controller = segue.destinationViewController as! GirlImageDetailViewController
        let url = model.gankDailysGirlImage.url
        controller.imageURL = NSURL(string: url)!
      default: break
      }
    }
  }
}

extension GirlsDailyViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1 + cellGroups.vedio
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if cellGroups.iOS == 0 {
      let dictionary = model.gankDailysGirlImage
      let cell = imageCellForDictionary(dictionary)
      return cell
    } else {
      switch indexPath.row {
      case cellGroups.girl:
        let dictionary = model.gankDailysGirlImage
        let cell = imageCellForDictionary(dictionary)
        return cell
      case cellGroups.girl...cellGroups.iOS:
        let dictionary = model.gankDailysIOS[indexPath.row - 1]
        let cell = articleCellForDictionary(dictionary)
        cell.logoImageView.image = UIImage(named: "apple")
        return cell
      case cellGroups.iOS...cellGroups.Android:
        let dictionary = model.gankDailysAndroid[indexPath.row - cellGroups.iOS - 1]
        let cell = articleCellForDictionary(dictionary)
        cell.logoImageView.image = UIImage(named: "android")
        return cell
      case cellGroups.Android...cellGroups.frontEnd:
        let dictionary = model.gankDailysFrontEnd[indexPath.row - cellGroups.Android - 1]
        let cell = articleCellForDictionary(dictionary)
        cell.logoImageView.image = UIImage(named: "frontEnd")
        return cell
      case cellGroups.frontEnd...cellGroups.recommend:
        let dictionary = model.gankDailysBlindlyRecommend[indexPath.row - cellGroups.frontEnd - 1]
        let cell = articleCellForDictionary(dictionary)
        cell.logoImageView.image = UIImage(named: "recommend")
        return cell
      case cellGroups.recommend...cellGroups.resource:
        let dictionary = model.gankDailysExpandResource[indexPath.row - cellGroups.recommend - 1]
        let cell = articleCellForDictionary(dictionary)
        cell.logoImageView.image = UIImage(named: "resource")
        return cell
      case cellGroups.vedio:
        let dictionary = model.gankDailysRelaxVedio
        let cell = articleCellForDictionary(dictionary)
        cell.logoImageView.image = UIImage(named: "play")
        return cell
      default:
        return UITableViewCell()
      }
    }
  }
  
  func articleCellForDictionary(dictionary: GankDaily) -> GirlsDailyArticleTableViewCell{
    let cell = girlsDailyTableView.dequeueReusableCellWithIdentifier(GirlsDailyViewNames.tableViewCellForArticle) as! GirlsDailyArticleTableViewCell
    cell.titleLabel.text = dictionary.desc
    let string = "ឳ "
    cell.autherLabel.text = string.stringByAppendingString(dictionary.who)
    return cell
  }
  
  func imageCellForDictionary(dictionary: GankDaily) -> GirlsDailyImageTableViewCell{
    let cell = girlsDailyTableView.dequeueReusableCellWithIdentifier(GirlsDailyViewNames.tableViewCellForImage) as! GirlsDailyImageTableViewCell
    let url = model.gankDailysGirlImage.url
    cell.girlImageView.kf_setImageWithURL(NSURL(string: url)!)
    cell.girlImageView.contentMode = .ScaleAspectFill
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return CGFloat(400)
    default:
      return CGFloat(80)
    }
  }
}

extension GirlsDailyViewController:UITableViewDelegate
{
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier(GirlsDailyViewNames.showGirlImageDetailViewSegueIdentifier, sender: indexPath)
  }
}

extension GirlsDailyViewController: GankModelDelegate
{
  func gankModelDidGetAlamofire() {
    countCellGroups()
    girlsDailyTableView.reloadData()
  }
}

extension GirlsDailyViewController
{
  func scrollViewDidScroll(scrollView: UIScrollView) {
    let offSetY = scrollView.contentOffset.y
    if let navigation = self.navigationController {
      navigation.navigationBar.alpha = min((offSetY + 20) / 200, 1)
    }
  }
}