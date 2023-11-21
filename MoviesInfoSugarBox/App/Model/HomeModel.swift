//
//  HomeModel.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import Foundation

struct ListMediaDataModel: Codable {
    let data: [Datum]?
    let pagination: Pagination?
}

struct Datum: Codable {
    let id, contentID, createdAt, description: String?
    let title, updatedAt: String?
    let contents: [Content]?
    let datumID, addedOn: String?
    let designID: DesignID?
    let designMeta: DesignMeta?
    let designSlug, widgetType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case contentID
        case createdAt, description, title, updatedAt, contents
        case datumID
        case addedOn
        case designID
        case designMeta, designSlug, widgetType
    }
}

struct Content: Codable {
    let id, contentID: String?
    let assets: [Asset]?
    let contentType: ContentType?
    let description: String?
    let isLicensed: Bool?
    let metaData: MetaData?
    let partnerContentID: String?
    let partnerID: Int?
    let releaseDate, title: String?
    let partnerDetails: PartnerDetails?
    let partnerName: PartnerName?
    let addedOn: String?

    enum CodingKeys: String, CodingKey {
        case id
        case contentID
        case assets, contentType, description, isLicensed, metaData
        case partnerContentID
        case partnerID
        case releaseDate, title, partnerDetails, partnerName, addedOn
    }
}

struct Asset: Codable {
    let assetType: AssetType?
    let sourceURL: String?
    let type: TypeEnum?
    let sourcePath: String?

    enum CodingKeys: String, CodingKey {
        case assetType
        case sourceURL
        case type, sourcePath
    }
}

enum AssetType: String, Codable {
    case image = "IMAGE"
    case video = "VIDEO"
}

enum TypeEnum: String, Codable {
    case dash = "dash"
    case detail = "detail"
    case hls = "hls"
    case thumbnail = "thumbnail"
    case thumbnailList = "thumbnail_list"
}

enum ContentType: String, Codable {
    case movie = "Movie"
    case show = "Show"
}

struct MetaData: Codable {
    let duration: Int?
    let isNonCompressed: Bool?
    let episodeNumber: Int?
    let enableDownloadOnDongle, hasAssets, shouldHaveChildren: Bool?
    let ageRating: AgeRating?

    enum CodingKeys: String, CodingKey {
        case duration, isNonCompressed
        case episodeNumber
        case enableDownloadOnDongle, hasAssets, shouldHaveChildren, ageRating
    }
}

enum AgeRating: String, Codable {
    case a = "A"
    case u = "U"
    case uA13 = "U/A 13+"
    case uA16 = "U/A 16+"
    case uA7 = "U/A 7+"
}

struct PartnerDetails: Codable {
    let partnerID: Int?
    let partnerName: PartnerName?
    let partnerShortName: PartnerShortName?

    enum CodingKeys: String, CodingKey {
        case partnerID
        case partnerName, partnerShortName
    }
}

enum PartnerName: String, Codable {
    case zee5 = "ZEE5"
}

enum PartnerShortName: String, Codable {
    case zee5 = "zee5"
}

struct DesignID: Codable {
    let id, designSlug: String?

    enum CodingKeys: String, CodingKey {
        case id
        case designSlug
    }
}

struct DesignMeta: Codable {
    let title, backgroundImage: String?
    let isSpacerViewReq, isItemTitleReq: Bool?
}

struct Pagination: Codable {
    let totalPages, currentPage, perPage, totalCount: Int?
}
