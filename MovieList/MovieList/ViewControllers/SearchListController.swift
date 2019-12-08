//
//  ViewController.swift
//  MovieList
//
//  Created by Eugene Berezin on 12/7/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import SDWebImage

class SearchListController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    fileprivate let cellId = "movieCell"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        
        
        title = "Movies"
        navigationItem.largeTitleDisplayMode = .always
        collectionView.backgroundColor = .black
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        setupSearchBar()
        fetchListOfMovies()
        
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.text = "Black"
        searchController.searchBar.tintColor = .lightGray
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .lightGray
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        // introduce some delay before performing the search
        // throttling the search
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            // this will actually fire my search
            Service.shared.fetchMovies(searchTerm: searchText) { (res, err) in
                self.movieResults = res
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        })
    }
    
    fileprivate var movieResults = [Result]()
    
    fileprivate func fetchListOfMovies() {
        Service.shared.fetchMovies(searchTerm: "Black") { (results, err) in
            
            if let err = err {
                print("Failed to fetch apps:", err)
                return
            }
            
            self.movieResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailView()
        detailView.movieResult = movieResults[indexPath.item]
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
        cell.movieResult = movieResults[indexPath.item]
        return cell
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

