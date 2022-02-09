//
//  MovieRepo.swift
//  SmartApp_Demo
//
//  Created by MOKSHA on 04/02/22.
//

import Foundation


class MovieRepo
{
    var Responemsg = ""
    
    public var delegate: OnDataConnectorDelegate?
    var UpdateProfileData = [String:Any]()

    required init(){
        
    }
    
    private var connectorCheckAuthorization: DataConnector?
    private var connectorCheckuservalidate: DataConnector?

    private var connectorRegisterUserProfile: DataConnector?
   
    private var connectorUpdateFCMToken: DataConnector?

    private var api_key = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    private var MoviebaseUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    private var TrailersbaseUrl = "https://api.themoviedb.org/3/movie/209112/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    private var MoviePosterbaseUrl = "https://image.tmdb.org/t/p/w342"
    private var backdropbaseUrl = "https://image.tmdb.org/t/p/original"
    
    
    public func GetAccessToken()
    {
        
    }
    
    public func GetNowplayingMovielist()
    {
        self.connectorCheckuservalidate = DataConnector.init("now_playing")
        self.connectorCheckuservalidate?.setHeaders(["api_key":self.api_key])
        self.connectorCheckuservalidate?.setParameters([:])
        self.connectorCheckuservalidate?.jsonEncoding(false)
        self.connectorCheckuservalidate?.setDelegate(self.delegate)
        self.connectorCheckuservalidate?.request(self.MoviebaseUrl,method: .get)
       
    }
}
