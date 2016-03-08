//
//  GirlsViewModel.swift
//  GankIO
//
//  Created by 河图。 on 16/3/7.
//  Copyright © 2016年 Study. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol GankModelDelegate
{
  func gankModelDidGetAlamofire()
}

class GankModel
{
  var gankDailys = [GankDaily]()
  
  var delegate: GankModelDelegate?
  
  func getAlamofireFromString(string: String) {
    let url = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString: string))
    print(url)
    Alamofire.request(.GET, url!).responseJSON() {
      response in
      if let data = response.result.value {
        self.parseJSON(data)
      }
    }
  }
  
  func parseJSON(data: AnyObject) {
    let json = JSON(data)
    for i in 0...99 {
      let dictionary: GankDaily = {
        var dictionary = GankDaily()
        dictionary.who = json["results"][i]["who"].stringValue
        dictionary.url = json["results"][i]["url"].stringValue
        dictionary.desc = json["results"][i]["desc"].stringValue
        dictionary.dateFromString(json["results"][i]["createdAt"].stringValue)
        return dictionary
      }()
      gankDailys.append(dictionary)
//      print(gankDailys)
      delegate!.gankModelDidGetAlamofire()
    }
  }
}