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
  
  var gankDailysGirlImage = GankDaily()
  var gankDailysAndroid = [GankDaily]()
  var gankDailysIOS = [GankDaily]()
  var gankDailysFrontEnd = [GankDaily]()
  var gankDailysBlindlyRecommend = [GankDaily]()
  var gankDailysExpandResource = [GankDaily]()
  var gankDailysRelaxVedio = GankDaily()
  
  var delegate: GankModelDelegate?
  
  func getAlamofireFromString(string: String) {
    let url = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString: string))
    Alamofire.request(.GET, url!).responseJSON() {
      response in
      if let data = response.result.value {
        self.parseJSON(data)
      }
    }
  }
  
  func getAlamofireFromDate(date: NSDate) {
    let url = URLFromDate(date)
    Alamofire.request(.GET, url).responseJSON() {
      response in
      if let data = response.result.value {
        self.parseJSONForDaily(data)
      }
    }
  }
  
  func URLFromDate(date: NSDate) -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy"
    let year = dateFormatter.stringFromDate(date)
    dateFormatter.dateFormat = "MM"
    let month = dateFormatter.stringFromDate(date)
    dateFormatter.dateFormat = "dd"
    let day = dateFormatter.stringFromDate(date)
    let urlString: String = "http://gank.io/api/day/\(year)/\(month)/\(day)"
    return urlString
  }
  
  func parseJSON(data: AnyObject) {
    let json = JSON(data)
    for i in 0...99 {
      let dictionary: GankDaily = {
        var dictionary = GankDaily()
        dictionary.who = json["results"][i]["who"].stringValue
        if dictionary.who != "" {
          dictionary.url = json["results"][i]["url"].stringValue
          dictionary.desc = json["results"][i]["desc"].stringValue
          dictionary.dateFromString(json["results"][i]["createdAt"].stringValue)
        }
        return dictionary
      }()
      if dictionary.who != "" {
        gankDailys.append(dictionary)
      }
      delegate!.gankModelDidGetAlamofire()
    }
  }
  
  func parseJSONForDaily(data: AnyObject) {
    let json = JSON(data)
    gankDailysGirlImage = dictionaryFromJSONWithTypeAndIndex(json, type: "福利", index: 0)
    gankDailysRelaxVedio = dictionaryFromJSONWithTypeAndIndex(json, type: "休息视频", index: 0)
    for index in 0...20 {
      let dictionary = dictionaryFromJSONWithTypeAndIndex(json, type: "Android", index: index)
      if dictionary.who != "" {
        gankDailysAndroid.append(dictionary)
      }
    }
    for index in 0...20 {
      let dictionary = dictionaryFromJSONWithTypeAndIndex(json, type: "iOS", index: index)
      if dictionary.who != "" {
        gankDailysIOS.append(dictionary)
      }
    }
    for index in 0...10 {
      let dictionary = dictionaryFromJSONWithTypeAndIndex(json, type: "前端", index: index)
      if dictionary.who != "" {
        gankDailysFrontEnd.append(dictionary)
      }
    }
    for index in 0...10 {
      let dictionary = dictionaryFromJSONWithTypeAndIndex(json, type: "瞎推荐", index: index)
      if dictionary.who != "" {
        gankDailysBlindlyRecommend.append(dictionary)
      }
    }
    for index in 0...10 {
      let dictionary = dictionaryFromJSONWithTypeAndIndex(json, type: "拓展资源", index: index)
      if dictionary.who != "" {
        gankDailysExpandResource.append(dictionary)
      }
    }
    
    delegate!.gankModelDidGetAlamofire()
  }
  
  func dictionaryFromJSONWithTypeAndIndex(json: JSON, type: String, index: Int) -> GankDaily {
    var dictionary = GankDaily()
    if json["results"][type][index]["who"].stringValue != "" {
      dictionary.who = json["results"][type][index]["who"].stringValue
      dictionary.url = json["results"][type][index]["url"].stringValue
      dictionary.desc = json["results"][type][index]["desc"].stringValue
      dictionary.type = type
    }
    return dictionary
  }
}