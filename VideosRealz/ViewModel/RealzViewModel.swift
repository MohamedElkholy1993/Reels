//
//  ReelzViewModel.swift
//  VideosRealz
//
//  Created by User on 24/08/2022.
//

import Foundation

class ReelsViewModel{
    
    var reels: [Item] = []
    var bindReelsToView: () -> () = {}
    var bindErrorToView: (String) -> () = {_ in }
    
    
    init(){
        reels = []
        fetchVideosData()
    }
    
    
    func fetchVideosData(){
        NetworkLayer.shared.fetchReels { [weak self] (reals, error) in
            guard let weakSelf = self else { return }
            
            if let unwrappedError = error{
                weakSelf.bindErrorToView(unwrappedError)
            } else if let unwrappedRealz = reals {
                weakSelf.reels = unwrappedRealz
                weakSelf.bindReelsToView()
            }
        }
    }
}
