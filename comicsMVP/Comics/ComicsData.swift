//
//  ComicsData.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import Foundation
import UIKit

public struct ComicsData: Codable {
    public var month: String
    public var num: Int
    public var link: String
    public var year: String
    public var news: String
    public var safe_title: String
    public var transcript: String
    public var alt: String
    public var img: String
    public var title: String
    public var day: String
}

public final class ComicsStore {
    
    public static let shared: ComicsStore = .init()
    
    public var comics: [ComicsData] = []
    
    public func appendComics(newComics: ComicsData) {
        comics.append(newComics)
    }
    
}
