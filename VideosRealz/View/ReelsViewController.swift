//
//  ReelsViewController.swift
//  VideosRealz
//
//  Created by User on 24/08/2022.
//
import UIKit
import SDWebImage
import youtube_ios_player_helper_swift

class ReelsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var reelsCollectionView: UICollectionView!
    @IBOutlet weak var videoView: YTPlayerView!
    
    // MARK: - Vars
    var viewModel = ReelsViewModel()
    let spinner = SpinnerViewController()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showLoadingView()
        viewModel.bindReelsToView = onSuccess
        viewModel.bindErrorToView = onFail
        setConfiguration()
        customizeUI()
    }
    // MARK: - Helprs
    func onSuccess(){
        dismissLoadingView()
        reelsCollectionView.reloadData()
    }
    
    func onFail(error: String){
        dismissLoadingView()
        showAlert(with: "Error", and: error, completionHandler: nil)
    }
    
    func showLoadingView() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func dismissLoadingView() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    func setConfiguration(){
        reelsCollectionView.delegate   = self
        reelsCollectionView.dataSource = self
        
        videoView.delegate = self
        
        let nib = UINib(nibName: K.CELL_ID, bundle: nil)
        reelsCollectionView.register(nib, forCellWithReuseIdentifier: K.CELL_ID)
    }
    
    func customizeUI(){
        reelsCollectionView.layer.masksToBounds = true
        reelsCollectionView.layer.cornerRadius  = K.CORNER_RADUIS
        reelsCollectionView.layer.borderWidth   = K.BORDER_WIDTH
        reelsCollectionView.layer.borderColor   = UIColor.gray.cgColor
    }
    

}

// MARK: - Extensions

extension ReelsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showLoadingView()
        let reel   = viewModel.reels[indexPath.item]
        let reelID = reel.snippet.resourceID.videoID
        
        let _ = videoView.load(videoId: reelID)
        videoView.playVideo()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: UIScreen.main.bounds.size.width * 0.25, height: reelsCollectionView.frame.size.height - 5)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension ReelsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.reels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CELL_ID, for: indexPath) as? ReelCollectionViewCell else{ return UICollectionViewCell() }
        let reel = viewModel.reels[indexPath.item]
        cell.setCell(reel: reel)
        
        return cell
    }
    
    
}

extension ReelsViewController: YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        
        case .playing:
            dismissLoadingView()
        
        default:
            dismissLoadingView()
        }
    }
    
}


