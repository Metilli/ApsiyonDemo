//
//  CoreDataService.swift
//  ApsiyonDemo
//
//  Created by Metilli on 29.01.2022.
//

import Foundation
import UIKit
import CoreData

struct CoreDataService{
    
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public static func saveContext(movies: PopulerMovies){
        var cachedMovies:[CachedMovie] = []
        for movie in movies.results{
            cachedMovies.append(encodeMovie(movie))
        }
        saveContext()
    }
    
    public static func fetchPopulerMovies() -> PopulerMovies{
        let movieListRequest: NSFetchRequest<CachedMovie> = CachedMovie.fetchRequest()
        do{
            let cachedMovieList = try context.fetch(movieListRequest)
            var movieList:[Movie] = []
            for movie in cachedMovieList{
                movieList.append(decodeCacheMovies(movie))
            }
            let populerMovies = PopulerMovies(page: 0, results: movieList, totalPages: 0, totalResults: 0)
            return populerMovies
        }
        catch{
            print(error.localizedDescription)
            return PopulerMovies(page: 0, results: [], totalPages: 0, totalResults: 0)
        }
    }
    
    private static func encodeMovie(_ movie:Movie)->CachedMovie{
        let cacheMovie = CachedMovie.init(context: context)
        cacheMovie.posterPath = movie.posterPath
        cacheMovie.originalTitle = movie.originalTitle
        cacheMovie.voteAverage = movie.voteAverage
        cacheMovie.releaseDate = movie.releaseDate
        cacheMovie.title = movie.title
        cacheMovie.adult = movie.adult
        cacheMovie.backdropPath = movie.backdropPath
        cacheMovie.id = Int32(movie.id)
        cacheMovie.originalLanguage = movie.originalLanguage
        cacheMovie.overview = movie.overview
        cacheMovie.popularity = movie.popularity
        cacheMovie.video = movie.video
        cacheMovie.voteCount = Int32(movie.voteCount)
        return cacheMovie
    }
    
    private static func decodeCacheMovies(_ cachedMovie: CachedMovie) -> Movie{
        let movie = Movie(adult: cachedMovie.adult,
                            backdropPath: cachedMovie.backdropPath,
                            genreIDS: [],
                            id: Int(cachedMovie.id),
                            originalLanguage: cachedMovie.originalLanguage ?? "",
                            originalTitle: cachedMovie.originalTitle ?? "",
                            overview: cachedMovie.overview ?? "",
                            popularity: cachedMovie.popularity,
                            posterPath: cachedMovie.posterPath,
                            title: cachedMovie.title,
                            releaseDate: cachedMovie.releaseDate,
                            video: cachedMovie.video,
                            voteAverage: cachedMovie.voteAverage,
                            voteCount: Int(cachedMovie.voteCount))
        return movie
    }
    
    private static func saveContext(){
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
}
