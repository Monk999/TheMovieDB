//
//  ServiceManager.swift
//  AlexExamenCoppel
//
//  Created by Alexander on 28/01/22.
//

import Foundation
import Combine

struct APIConstants {
    
     static let api_key = "e296392b9b8ea8caba54f2e752ccf9f4"
    
    static let validateWithLoginEndPoint = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key="
    
    static let popularMoviesEndpoint = "https://api.themoviedb.org/3/movie/popular?api_key="
    
    static let topRatedMoviesEndpoint = "https://api.themoviedb.org/3/movie/top_rated?api_key="
    
    static let nowPlayingMoviesEndpoint = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    
    static let upcomingMoviesEndpoint = "https://api.themoviedb.org/3/movie/upcoming?api_key="

    static let tokenEndpoint = "https://api.themoviedb.org/3/authentication/token/new?api_key="

    static let movieDetailEndpoint = "https://api.themoviedb.org/3/movie/"

    static let imagePath = "https://image.tmdb.org/t/p/w200/"
    
    static let videosEndpoint = "https://api.themoviedb.org/3/movie/"
    
    static let youtubeLink = "https://www.youtube.com/watch?v="
    
    private init() {}
    
   
   /* func logOutSession(sessionId: String, closure: @escaping(Result<LoginResponse, Error>) -> Void){
        //https://api.themoviedb.org/3/authentication/session?api_key=<<api_key>>
        
        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/session?api_key=\(api_key)&language=en-US")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let params = [
            "session_id": sessionId
        ] as [String:Any]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    
                    let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print(json!)
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(LoginResponse.self, from: data)
                    closure(.success(res))
                    print(res)
                } catch {
                    closure(.failure(error))
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }*/
    
   /* func createSession(params: LoginRequest, closure: @escaping(Result<LoginResponse, Error>) -> Void){
        //https://api.themoviedb.org/3/authentication/session/new?api_key=<<api_key>>

        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(api_key)&language=en-US")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let params = [
            "request_token": params.request_token
        ] as [String:Any]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    
                    let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print(json!)
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(LoginResponse.self, from: data)
                    closure(.success(res))
                    print(res)
                } catch {
                    closure(.failure(error))
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }*/
    /*
    func retrieveDetailMovies(detailsMovieEntityRequest: DetailsMovieEntityRequest, closure: @escaping(Result<Results, Error>) -> Void){
      
    }
    */
   
  
    
    /*
    func retireveListMovies(request: ListMovieRequest ,closure: @escaping(Result<ListMovieResponse, Error>) -> Void){
        
        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/\(request.typeStreaming ?? "")/\(request.type ?? "popular")?api_key=\(api_key)&language=en-US&page=\(request.page ?? 1)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let data = data {
                do {
                    let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    //print(json!)
                    let decoder = JSONDecoder()
                    
                    let res = try decoder.decode(ListMovieResponse.self, from: data)
                    closure(.success(res))
                } catch {
                    closure(.failure(error))
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    */
    /*
    func retireveListMoviesTopRated(request: ListMovieRequest ,closure: @escaping(Result<ListMovieResponse, Error>) -> Void){
        
        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/\(request.typeStreaming ?? "")/\(request.type ?? "popular")?api_key=\(api_key)&language=en-US&page=\(request.page ?? 1)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let data = data {
                do {
                    let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    //print(json!)
                    let decoder = JSONDecoder()
                    
                    let res = try decoder.decode(ListMovieResponse.self, from: data)
                    closure(.success(res))
                } catch {
                    closure(.failure(error))
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
     */
    /*
    
    func retireveListMoviesOnTV(request: ListMovieRequest ,closure: @escaping(Result<ListMovieResponse, Error>) -> Void){
        
        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/\(request.typeStreaming ?? "")/\(request.type ?? "popular")?api_key=\(api_key)&language=en-US&page=\(request.page ?? 1)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let data = data {
                do {
                    let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    //print(json!)
                    let decoder = JSONDecoder()
                    
                    let res = try decoder.decode(ListMovieResponse.self, from: data)
                    closure(.success(res))
                } catch {
                    closure(.failure(error))
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
    func retireveListMoviesAiring(request: ListMovieRequest ,closure: @escaping(Result<ListMovieResponse, Error>) -> Void){
        
        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/\(request.typeStreaming ?? "")/\(request.type ?? "popular")?api_key=\(api_key)&language=en-US&page=\(request.page ?? 1)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let data = data {
                do {
                    let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    //print(json!)
                    let decoder = JSONDecoder()
                    
                    let res = try decoder.decode(ListMovieResponse.self, from: data)
                    closure(.success(res))
                } catch {
                    closure(.failure(error))
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }*/
    
    func retrieveImage(){
        
        //let url = "https://image.tmdb.org/t/p/w300/"
        
        let session = URLSession.shared
        let url = URL(string: "https://image.tmdb.org/t/p/w300/eG0oOQVsniPAuecPzDD1B1gnYWy.jpg")
        
        
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let data = data {
                do {
                    let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print(json!)
                    let decoder = JSONDecoder()
                    
                    //let res = try decoder.decode(ListMovieResponse.self, from: data)
                    //closure(.success(res))
                    //print(res)
                } catch {
                    //closure(.failure(error))
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
}
