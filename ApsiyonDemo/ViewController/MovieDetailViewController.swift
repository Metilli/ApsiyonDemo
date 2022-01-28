//
//  MovieDetailViewController.swift
//  ApsiyonDemo
//
//  Created by Metilli on 28.01.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    private var _movieTitle:String?
    public var movieTitle:String{
        get{
            return _movieTitle ?? ""
        }
        set(title){
            _movieTitle = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
        loadMovieDetails()
        view.layoutIfNeeded()
    }
    
    private func setTitle(){
        view.backgroundColor = .white
        navigationItem.title = movieTitle
    }
    
    private func loadMovieDetails(){
        let viewBackground = UIView()
        view.addSubview(viewBackground)
        viewBackground.translatesAutoresizingMaskIntoConstraints = false
        viewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewBackground.backgroundColor = UIColor(named: Constants.Color.viewBackgroundColorGray)
        view.layoutIfNeeded()
        
        let label = UILabel()
        viewBackground.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 32).isActive = true
        label.text = "This is detail page of \(movieTitle)."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        view.layoutIfNeeded()
        
    }
    
}
