//
//  MovieListViewController.swift
//  ApsiyonDemo
//
//  Created by Metilli on 28.01.2022.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var movieCollectionView: UICollectionView? = nil
    
    override func viewSafeAreaInsetsDidChange() {
        setupCollectionView()
        addButton()
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
        viewBackground.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leftAnchor.constraint(equalTo: viewBackground.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: viewBackground.rightAnchor, constant: -16).isActive = true
        button.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: 16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layoutIfNeeded()
    }
}

// MARK: - CollectionView DataSource
extension MovieListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        if indexPath.row == 0{
            cell.setTitle("The Shawkshank Redemption")
            cell.setReleaseDate("1970")
            cell.setScore(9.1)
        }else if indexPath.row == 1{
            cell.setTitle("Fight Club")
            cell.setReleaseDate("1975")
            cell.setScore(7)
        }else{
            cell.setTitle("Once Upon a Time in America")
            cell.setReleaseDate("1980")
            cell.setScore(5.2)
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
        movieDetailVC.movieTitle = "Fight"
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
