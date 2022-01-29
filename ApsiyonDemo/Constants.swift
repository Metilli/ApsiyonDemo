//
//  Constants.swift
//  ApsiyonDemo
//
//  Created by Metilli on 28.01.2022.
//

import Foundation

struct Constants{
    struct Color{
        static let viewBackgroundColorGray = "ViewBackgroundColorGray"
        static let goodScore = "GoodScore"
        static let badScore = "BadScore"
        static let avarageScore = "AverageScore"
        static let buttonColor = "ButtonColor"
    }
    
    struct ApiService{
        static let apiKey = "bd7847090fea4f76f5ce0c22bd1a85b8"
        static let moviePopulerUrl = "https://api.themoviedb.org/3/movie/popular?api_key=" + apiKey + "&language=en-US"
        static let posterUrl = "https://image.tmdb.org/t/p/w300"
    }
}
