//
//  DetailView.swift
//  MovieList
//
//  Created by Eugene Berezin on 12/7/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DetailView: UIViewController {
    
    var movieResult: Result? {
        didSet {
            let baseImageURL = "https://image.tmdb.org/t/p/w500"
            let backDropPath = movieResult?.backdrop_path ?? ""
            guard let backDropUrl = URL(string: baseImageURL + backDropPath) else {
                imageView.image = UIImage(named: "placeholder")
                return
            }
            imageView.sd_setImage(with: backDropUrl)
            movieTitaleLabel.text = movieResult?.original_title
            releseDate.text = "Release date: \(movieResult?.release_date ?? "")"
            rating.text = "Rating: \(NSString(format: "%.1f", movieResult?.vote_average ?? 0))"
            overViewLabel.text = movieResult?.overview
            
        }
    }
    
     let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
     let movieTitaleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie title"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .systemOrange
        return label
    }()
    
    
    
     let releseDate: UILabel = {
        let label = UILabel()
        label.text = "Relese date: "
        label.textColor = .orange
        return label
    }()
    
     let rating: UILabel = {
        let label = UILabel()
        label.text = "Rating: "
        label.textColor = .orange
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemOrange
        return label
    }()
    
     let overViewLabel: UILabel = {
        let textView = UILabel()
        textView.text = "Overview."
        textView.font = .systemFont(ofSize: 14)
        textView.numberOfLines = 0
        textView.textColor = .orange
        
        return textView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let labelStack = UIStackView(arrangedSubviews: [movieTitaleLabel, releseDate, rating])
        labelStack.axis = .vertical
        labelStack.spacing = 10
        labelStack.distribution = .fillEqually
        
        let overallStack = UIStackView(arrangedSubviews: [imageView, labelStack, overViewLabel])
        overallStack.axis = .vertical
        overallStack.distribution = .fill
        overallStack.alignment = .leading
        overallStack.spacing = 5
        
        view.addSubview(overallStack)
        overallStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        
    }
}
