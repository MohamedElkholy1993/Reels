//
//  NetworkLayer.swift
//  VideosRealz
//
//  Created by User on 24/08/2022.
//

import Foundation
import Alamofire

struct NetworkLayer{
    static let shared = NetworkLayer()
    private init(){}
    
    
    private let url = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(K.PLAYLIST_ID)&key=\(K.API_KEY)"
    
    func fetchReels(onCompletion: @escaping (_ reals: [Item]?, _ error: String?) -> ()){
        
        print("URL: \(url)")
                AF.request(url).validate().responseDecodable(of: JsonBody.self) { (response) in
                    switch response.result {
                    case .success(_):
                        guard let data = response.value else { return }
                        print(data.items.count)
                        let videos = data.items
                        onCompletion(videos,nil)
                        
                    case .failure(let error):
                        print(error)
                        onCompletion(nil,error.localizedDescription)
                        
                    }
                }
                
        
    }
}
