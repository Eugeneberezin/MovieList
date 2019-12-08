//
//  MovieCell.swift
//  MovieList
//
//  Created by Eugene Berezin on 12/7/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
     
    var movieResult: Result! {
        didSet {
            let baseImageURL = "https://image.tmdb.org/t/p/w500"
            let posterPath = movieResult.poster_path ?? ""
            guard let posterUrl = URL(string: baseImageURL + posterPath) else {
                posterImageView.image = UIImage(named: "placeholder")
                return
            }
            posterImageView.sd_setImage(with: posterUrl)
            
            let backDropPath = movieResult.backdrop_path ?? ""
            guard let backDropUrl = URL(string: baseImageURL + backDropPath) else { return }
            backDropImage.sd_setImage(with: backDropUrl)
            movieLabel.text = movieResult.original_title
        }
    }
    
    
     let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
     let movieLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie title"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemOrange
        return label
    }()
    
     let backDropImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backDropTitleStack = UIStackView(arrangedSubviews: [backDropImage, movieLabel])
        backDropTitleStack.axis = .horizontal
        backDropTitleStack.spacing = 10
        
        let overallStackView = UIStackView(arrangedSubviews: [posterImageView, backDropTitleStack])
        overallStackView.axis = .vertical
        
        addSubview(overallStackView)
        overallStackView.fillSuperview()
        
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

