//
//  DataConnector.swift
//  SmartApp_Demo
//
//  Created by MOKSHA on 05/02/22.
//

import Foundation
import Alamofire


protocol OnDataConnectorDelegate
{
    func onLoading(_ TAG: String, _ enable: Bool)
    func onComplete(_ TAG: String, _ statusCode: Int, _ response: String)
}

class DataConnector {
    
    private var delegate: OnDataConnectorDelegate?
    public static let noInternet = "Can't connect, please check your internet connection."
    public static let errorSomething = "Something went wrong, please try again later."
    
    private var TAG: String!

    

    private var encoding : ParameterEncoding = URLEncoding.default
    
    private var dataRequest : DataRequest?
    private var headers: HTTPHeaders = HTTPHeaders.init()
    private var params: Parameters = Parameters.init()
    
    required init(_ TAG: String){
        self.TAG = TAG
    }
    
    func setHeaders(_ headers: HTTPHeaders){
        
        var headerValue = headers
        self.headers =  headerValue

    }
    
    func setParameters(_ params: Parameters){
        self.params =  params
    }
        
    func jsonEncoding(_ enable : Bool){
        if enable {
            self.encoding = JSONEncoding.default
        } else {
            self.encoding = URLEncoding.default
        }
    }
        
    func setDelegate(_ delegate: OnDataConnectorDelegate?){
        self.delegate = delegate
    }
    
    func request(_ connectionUrl: String, method: Alamofire.HTTPMethod = .get){
        
        if !DataConnector.isInternetAvailable() {
            self.delegate?.onComplete(self.TAG, 0, DataConnector.noInternet)
            return
        }
        
        let reqParam: [String:Any] = ["data":self.params]
        
        self.delegate?.onLoading(self.TAG,true)
        
        self.log(self.TAG, "URL: \(connectionUrl)")
        self.log(self.TAG, "Headers: \(self.headers.dictionary)")
        self.log(self.TAG, "Parameters: \(reqParam)")
        
        
      
        self.dataRequest = AF.request(connectionUrl, method: method, encoding: self.encoding, headers: self.headers).responseString {
            response in
            
            self.delegate?.onLoading(self.TAG, false)
            
            if let statusCode = response.response?.statusCode {
                
                self.log(self.TAG, "Status Code: \(statusCode)")
                
                switch response.result {
                case .success(let json):
                    self.log(self.TAG, "results: " + json)
                    self.delegate?.onComplete(self.TAG, statusCode, json)
                    break
                case .failure(let error):
                    self.log(self.TAG, "Error: " + error.localizedDescription)
                    self.delegate?.onComplete(self.TAG, statusCode, error.localizedDescription)
                    break
                }
            } else {
                print(response.error?.localizedDescription)
                self.log(self.TAG, "Error: " + DataConnector.errorSomething)
                self.delegate?.onComplete(self.TAG, 0, DataConnector.errorSomething)
            }
        }
        
    }
    
    public static func isInternetAvailable() -> Bool{
        if let internet = Alamofire.NetworkReachabilityManager.init() {
            return internet.isReachable
        }
        return false
    }
    
    func cancelRequest(){
        self.dataRequest?.cancel()
    }
    
    func log(_ tag: String, _ value: String){
        print(tag + ">>", value)
        #if DEBUG
            //print(tag + ">>", value)
        #else
        
        #endif
    }
}
