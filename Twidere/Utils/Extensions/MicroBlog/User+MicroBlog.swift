//
//  User+MicroBlog.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON

extension User {
    
    convenience init(accountJson: JSON) {
        self.init(json: accountJson, accountKey: User.getUserKey(accountJson))
    }
    
    convenience init(json: JSON, accountKey: UserKey) {
        self.init()
        self.accountKey = accountKey
        self.key = User.getUserKey(json)
        self.createdAt = parseTwitterDate(json["created_at"].stringValue)?.timeIntervalSince1970Millis ?? -1
        self.isProtected = json["protected"].boolValue
        self.isVerified = json["verified"].boolValue
        self.name = json["name"].string
        self.screenName = json["screen_name"].string
        self.profileImageUrl = json["profile_image_url_https"].string ?? json["profile_image_url"].string
        self.profileBannerUrl = json["profile_banner_url"].string ?? json["cover_photo"].string
        self.profileBackgroundUrl = json["profile_background_image_url_https"].string ?? json["profile_background_image_url"].string
        self.descriptionPlain = json["description"].string
        self.descriptionDisplay = self.descriptionPlain
        self.url = json["url"].string
        self.urlExpanded = json["entities"]["url"]["urls"][0]["expanded_url"].string
        self.location = json["location"].string
        self.metadata = UserMetadata(json: json)
    }
    
    static func getUserKey(json: JSON) -> UserKey {
        return UserKey(id: json["id_str"].string ?? json["id"].string!, host: User.getUserHost(json))
    }
    
    static func getUserHost(json: JSON) -> String {
        if (json["unique_id"].isExists() && json["profile_image_url_large"].isExists()) {
            return "fanfou.com"
        }
        guard let profileUrl = json["statusnet_profile_url"].string else {
            return "twitter.com"
        }
        return NSURLComponents(string: profileUrl)!.host!
    }
}

extension UserMetadata {
    
    convenience init(json: JSON) {
        self.init()
        self.statusesCount = json["statuses_count"].int64 ?? -1
        self.followersCount = json["followers_count"].int64 ?? -1
        self.friendsCount = json["friends_count"].int64 ?? -1
        self.listedCount = json["listed_count"].int64 ?? -1
        self.groupsCount = json["groups_count"].int64 ?? -1
    }
    
}