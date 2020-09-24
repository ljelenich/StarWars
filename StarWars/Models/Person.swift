//
//  Person.swift
//  StarWars
//
//  Created by LAURA JELENICH on 9/24/20.
//

import Foundation

struct Person: Decodable {
    let name: String
    let films: [URL]
}

struct Films: Decodable {
    let title: String
}
