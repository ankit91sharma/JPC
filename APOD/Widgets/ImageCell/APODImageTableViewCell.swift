//
//  APODImageTableViewCell.swift
//  APOD
//
//  Created by Ankit Sharma on 11/03/22.
//

import UIKit
import Combine
import WebKit

class APODImageTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel! {
        didSet {
            if (self.traitCollection.horizontalSizeClass == .regular && self.traitCollection.verticalSizeClass == .regular) {
                labelTitle.font =  UIFont().scriptFont(size: 32, boldRequired: true)
            } else {
                labelTitle.font =  UIFont().scriptFont(size: 24, boldRequired: true)
            }
        }
    }
    @IBOutlet weak var labelDate: UILabel! {
        didSet {
            if (self.traitCollection.horizontalSizeClass == .regular && self.traitCollection.verticalSizeClass == .regular) {
                labelDate.font =  UIFont().scriptFont(size: 36)
            } else {
                labelDate.font =  UIFont().scriptFont(size: 18)
            }
            
        }
    }
    @IBOutlet weak var labelDescription: UILabel! {
        didSet {
            if (self.traitCollection.horizontalSizeClass == .regular && self.traitCollection.verticalSizeClass == .regular) {
                labelDescription.font =  UIFont().scriptFont(size: 32)
            } else {
                labelDescription.font =  UIFont().scriptFont(size: 16)
            }
            
        }
    }
    @IBOutlet weak var apodImageView: UIImageView!
    @IBOutlet weak var videoView: UIView!
    private var viewModel: APODImageTableViewCellViewModel?
    private var webView: WKWebView?
    private var cancelable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.labelDate.text = ""
        self.labelTitle.text = ""
        self.labelDescription.text = ""
        self.apodImageView.image = nil
        self.webView?.removeFromSuperview()
        self.webView = nil
    }
}

extension APODImageTableViewCell {
    func configureCell(model: APODImageTableViewCellViewModel) {
        viewModel = model
        bindViewModel()
        setData()
    }
    
    private func setData() {
        self.labelDate.text = viewModel?.date
        self.labelTitle.text = viewModel?.title
        self.labelDescription.text = viewModel?.descprition
        self.apodImageView.image = UIImage(named: "loading")
        if viewModel?.mediaType == .video {
            loadVideo()
        } else {
            self.apodImageView.isHidden = false
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let viewModel = self.viewModel else { return }
        viewModel.downloadImage()
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        viewModel.imagePublisher
            .receive(on: DispatchQueue.main)
            .sink { image in
            self.apodImageView.image = image
        }.store(in: &cancelable)
    }
    
    private func loadVideo() {
        webView = WKWebView(frame: self.videoView.bounds, configuration: WKWebViewConfiguration() )
        guard let video = webView else { return }
        video.clipsToBounds = true
        video.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.videoView.addSubview(video)
        video.allowsBackForwardNavigationGestures = true
        let myURL = URL(string: viewModel?.imageUrl ?? "")
        let myRequest = URLRequest(url: myURL!)
        video.load(myRequest)
    }    
}
