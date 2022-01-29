//
//  MovieListViewController.swift
//  ApsiyonDemo
//
//  Created by Metilli on 28.01.2022.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var movieCollectionView: UICollectionView? = nil
    
    private var populerMovies:PopulerMovies?
    private var movieList:[Movie] = []
    
    override func viewSafeAreaInsetsDidChange() {
        setupCollectionView()
        addButton()
        fetchPopulerMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "MovieLIST"
        self.navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
        
    }
    
    func setupCollectionView(){
        movieCollectionView = UICollectionView(frame: self.view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        guard let safeMovieCollectionView = movieCollectionView else{
            fatalError()
        }
        if let flowLayout = safeMovieCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        
        safeMovieCollectionView.backgroundColor = UIColor(named: Constants.Color.viewBackgroundColorGray)
        
        view.addSubview(safeMovieCollectionView)
        
        safeMovieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        safeMovieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        safeMovieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        safeMovieCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        safeMovieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100).isActive = true
        view.layoutIfNeeded()
        
        safeMovieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        safeMovieCollectionView.dataSource = self
        safeMovieCollectionView.delegate = self
        
        safeMovieCollectionView.showsVerticalScrollIndicator = false
        safeMovieCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func addButton(){
        let viewBackground = UIView()
        viewBackground.backgroundColor = .white
        view.addSubview(viewBackground)
        viewBackground.translatesAutoresizingMaskIntoConstraints = false
        viewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewBackground.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let button = AddButton()
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let buttonTitle = NSMutableAttributedString(string: "Add", attributes:attrs)
        button.attributedText = buttonTitle
        button.systemImageName = "plus"
        viewBackground.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leftAnchor.constraint(equalTo: viewBackground.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: viewBackground.rightAnchor, constant: -16).isActive = true
        button.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: 16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layoutIfNeeded()
    }
    
    func fetchPopulerMovies(){
        let pageNumber = 1 + (populerMovies?.page ?? 0)
        if pageNumber <= 5{
            ApiService.fetchPopulerMovies (page: pageNumber) { (result) in
                switch result {
                case .success(let movies):
                    self.populerMovies = movies
                    for movie in movies.results{
                        self.movieList.append(movie)
                    }
                    DispatchQueue.main.async {
                        self.movieCollectionView?.reloadData()
                    }
                case .failure(let error):
                    print("Error processing json data: \(error)")
                }
            }
        }
    }
}

// MARK: - CollectionView DataSource
extension MovieListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        cell.layoutSubviews()
        
        if movieList.count > indexPath.row{
            cell.setTitle(movieList[indexPath.row].originalTitle)
            cell.setReleaseDate(movieList[indexPath.row].releaseDate ?? "")
            cell.setScore(movieList[indexPath.row].voteAverage)
            cell.setPosterURL(movieList[indexPath.row].posterPath)
        }
        if movieList.count - 1 == indexPath.row{
            fetchPopulerMovies()
        }
        return cell
    }
    
}

// MARK: - CollectionView DelegateFlowLayout
extension MovieListViewController:  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24.0, left: 0, bottom: 8, right: 0)
    }
}

// MARK: - CollectionView Delegate
extension MovieListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movieTitle = movieList[indexPath.row].originalTitle
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
