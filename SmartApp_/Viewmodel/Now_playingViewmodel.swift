//
//  Now_playingViewmodel.swift
//  SmartApp_Demo
//
//  Created by MOKSHA on 05/02/22.
//

import Foundation
import SwiftyJSON


protocol MovieDelegate
{
    func UpdatedMovielist(Mlist : [MovieResults])
}

struct Movielist : Decodable {

    let results : [MovieResults_]
}

struct MovieResults_: Decodable {
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
}

class Now_playingViewmodel : OnDataConnectorDelegate
{
    var Movierepo = MovieRepo()
    var moviedelegate : MovieDelegate?
    
     var MoviePosterbaseUrl = "https://image.tmdb.org/t/p/w342"
     var backdropbaseUrl = "https://image.tmdb.org/t/p/original"
    
    
    init() {
        self.Movierepo.delegate = self
      
    }
    
 
    public func GetMovielist()
    {
        self.Movierepo.GetNowplayingMovielist()
    }
    
    func onLoading(_ TAG: String, _ enable: Bool) {
        
    }
    
    func onComplete(_ TAG: String, _ statusCode: Int, _ response: String) {
        
        if TAG == "now_playing" && statusCode == 200
        {
            let json = JSON.init(parseJSON: response)
            let result = json["results"].rawString()
            let data = Data(result!.utf8)
            if let list = try? JSONDecoder().decode([MovieResults].self, from: data) {
                self.moviedelegate?.UpdatedMovielist(Mlist: list)
            }
        }
    }
    
}
