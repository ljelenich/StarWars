//
//  PersonController.swift
//  StarWars
//
//  Created by LAURA JELENICH on 9/24/20.
//

import Foundation

//https://swapi.dev/api/people/1/

struct StringConstants {
    fileprivate static let baseURL = "https://swapi.dev/api"
    fileprivate static let peopleEndpoint = "people"
}

class PersonController {
    static let shared = PersonController()
    func fetchPerson(id: String, completion: @escaping (Result<Person, PersonError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL)) }
        let peopleEndpoint = baseURL.appendingPathComponent(StringConstants.peopleEndpoint)
        let finalURL = peopleEndpoint.appendingPathComponent("\(id)")
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error)
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
   
            guard let data = data else { return completion(.failure(.noData)) }

            do {
                let person = try JSONDecoder().decode(Person.self, from: data)
                return completion(.success(person))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchFilm(url: URL, completion: @escaping (Result<Films, PersonError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {return completion(.failure(.noData)) }
            
            do {
                let decoder = JSONDecoder()
                let film = try decoder.decode(Films.self, from: data)
                return completion(.success(film))
            } catch {
                print(error)
                print(error.localizedDescription)
                return completion(.failure(.noData))
            }
        }.resume()
    }
}

