//
//  MediaUploadResponse.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class MediaUploadResponse: StaticMappable {
    
    var mediaId: String!
    var size: Int64!
    var image: Image!
    var video: Video!
    var processingInfo: ProcessingInfo!
    
    func mapping(map: Map) {
        mediaId <- map["media_id"]
        size <- map["size"]
        image <- map["image"]
        video <- map["video"]
        processingInfo <- map["processing_info"]
        
        if (map.mappingType == .fromJSON) {
            if (mediaId == nil) {
                mediaId = map["media_id_string"].value()
            }
            if (mediaId == nil) {
                let idInt: Int64? = map["media_id"].value()
                mediaId = String(describing: idInt)
            }
        }
    }
    
    static func objectForMapping(map: Map) -> BaseMappable? {
        return MediaUploadResponse()
    }
    
    class Image: StaticMappable {
        
        var width: Int!
        var height: Int!
        var imageType: String!
        
        func mapping(map: Map) {
            width <- map["w"]
            height <- map["h"]
            imageType <- map["image_type"]
        }
        
        static func objectForMapping(map: Map) -> BaseMappable? {
            return Image()
        }
    }
    
    class Video: StaticMappable {
        
        var videoType: String!
        
        func mapping(map: Map) {
            videoType <- map["video_type"]
        }
        
        static func objectForMapping(map: Map) -> BaseMappable? {
            return Video()
        }
    }
    
    class ProcessingInfo: StaticMappable {
        
        var state: String!
        var checkAfterSecs: Int64!
        var progressPercent: Int!
//        var error: ErrorInfo!
        
        func mapping(map: Map) {
            state <- map["state"]
            checkAfterSecs <- map["check_after_secs"]
            progressPercent <- map["progress_percent"]
//            error <- map["error"]
        }
        
        static func objectForMapping(map: Map) -> BaseMappable? {
            return ProcessingInfo()
        }
    }
    
    static let serialization = DataResponseSerializer<MediaUploadResponse> { (req, resp, data, err) -> Result<MediaUploadResponse> in
        if let data = data, let json = String(data: data, encoding: String.Encoding.utf8) {
            if let response = Mapper<MediaUploadResponse>().map(JSONString: json) , response.mediaId != nil {
                return .success(response)
            }
        }
        return .failure(MicroBlogError.decodeError)
    }
}
