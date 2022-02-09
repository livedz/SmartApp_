//
//  MovieList Model.swift
//  SmartApp_Demo
//
//  Created by MOKSHA on 04/02/22.
//

import Foundation
struct Dates : Codable {
    let maximum : String?
    let minimum : String?

    enum CodingKeys: String, CodingKey {

        case maximum = "maximum"
        case minimum = "minimum"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        maximum = try values.decodeIfPresent(String.self, forKey: .maximum)
        minimum = try values.decodeIfPresent(String.self, forKey: .minimum)
    }

}
struct ResponseMovieList : Codable {
    let dates : Dates?
    let page : Int?
    let Movieresults : [MovieResults]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case dates = "dates"
        case page = "page"
        case Movieresults = "Movieresults"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dates = try values.decodeIfPresent(Dates.self, forKey: .dates)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        Movieresults = try values.decodeIfPresent([MovieResults].self, forKey: .Movieresults)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }

}


struct MovieResults : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let genre_ids : [Int]?
    let id : Int?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let release_date : String?
    let title : String?
    let video : Bool?
    let vote_average : Double?
    let vote_count : Int?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case genre_ids = "genre_ids"
        case id = "id"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case release_date = "release_date"
        case title = "title"
        case video = "video"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
    }

}
struct ResponseTrailersList : Codable {
    let id : Int?
    let Trailersresults : [Trailersresult]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case Trailersresults = "Trailersresults"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        Trailersresults = try values.decodeIfPresent([Trailersresult].self, forKey: .Trailersresults)
    }

}
struct Trailersresult : Codable {
    let iso_639_1 : String?
    let iso_3166_1 : String?
    let name : String?
    let key : String?
    let site : String?
    let size : Int?
    let type : String?
    let official : Bool?
    let published_at : String?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case iso_639_1 = "iso_639_1"
        case iso_3166_1 = "iso_3166_1"
        case name = "name"
        case key = "key"
        case site = "site"
        case size = "size"
        case type = "type"
        case official = "official"
        case published_at = "published_at"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        iso_3166_1 = try values.decodeIfPresent(String.self, forKey: .iso_3166_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        site = try values.decodeIfPresent(String.self, forKey: .site)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        official = try values.decodeIfPresent(Bool.self, forKey: .official)
        published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}
